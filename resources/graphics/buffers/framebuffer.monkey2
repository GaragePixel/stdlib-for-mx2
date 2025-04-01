
Namespace stdlib.graphics

'==============================================================
' Frame Buffer with Triple Buffering & Timer-based Updates
' Low-level Graphics Resource Abstraction
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Purpose:
'
'	The FrameBuffer is the compagnon for drawing with the pixmap
'	of stdlib.
'
' 	It provides a high-performance triple-buffered image surface 
'	for smooth rendering, reduces stalls between rendering and 
'	presentation phases, allows for continuous drawing 
'	while vsync is occurring.
'
' 	The FrameBuffer class implements a rendering pipeline 
' 	that bridges the zero-branch pixel operations of the
' 	stdlib's Aida 4's pixmap with the legacy 
' 	Monkey2's Mojo's Canvas rendering system in the actual
' 	sdk_mojo library (mojo is actually deprecated). 
' 	It encapsulates the complexity of maintaining 
'	separate buffers for drawing and display operations 
'	and it's absolutly agnostic, so you can made your own
'	wrappers of Mojo's Canvas, Image and Texture and use
'	our own classes with the Framebuffer. 
'
'	The FrameBuffer was originally attented to be a
'	renderer for the pixmaps, so you can use it for
'	recreate the real way to make a MS-DOS game-alike
'	until the need to draw the pixmap on the screen.
'	For doing that, you need a canvas, then the FrameBuffer
'	will handle some basic operations in an agnostic way.
'	
'	The FrameBuffer can be used to draw in an OS's Window with
'	the native bitmap object and can helps to create some
'	interesting things like program's splashes, semi-transparent
'	mp4 player, little characters on the os's screen, as you wish.
'
' The nested Buffer class manages the low-level components:
'   - Pixmap: For pixel-level manipulations
'   - Texture: For GPU-accelerated rendering
'   - Image: For drawing to Canvas
'
' The triple-buffer design employs three distinct buffers that rotate roles:
' 	- Front buffer - currently being displayed
' 	- Back buffer - being prepared for swap to display
' 	- Pending buffer - available for immediate drawing operations
'	
' This eliminates the wait time between vsync operations and
' allows for continuous rendering cycles without stalling.
'
' The Update property uses function delegation to allow (closure)
' runtime-configurable update behavior without subclassing,
' perfectly complementing the zero-branch approach of stdlib/Aida 4.
'
' The Flip() method handles:
'   - Frame timing measurements
'   - Texture updates from modified Pixmap data
'   - Drawing the resulting Image to the Canvas
'   - FPS history updates for moving average calculation
'
' TODO: 
'	Shader for the agnostic canvas renderer (must be
'	a canvas mojo-alike).
'
' Note:
'	No, isn't an interface. Because with an interface, you
'	need to implement the classes with the interface. And I
'	don't want change the Mojo stuff in that way.
'	My simple goal was just to provide a class that contains a Pixmap, 
'	an Image and its Texture, in order to draw an image on the pixmap 
'	and, eventually, use any system to display the pixmap. 
'	So since I didn't want to create an interface, 
'	I ended up with a wrapper, and it's now a part of stdlib.

'==============================================================

Class FrameBuffer<C,I,T>

	' Constructor for standalone buffer (without canvas specified yet)
	Method New( 
		width:Int, height:Int, 
		cls:Color=Null, 
		pixelFormat:PixelFormat=PixelFormat.RGBA8 )
		
		' Initialize all three buffers
		_frontBuffer = New Buffer( width, height, cls, pixelFormat )
		_backBuffer = New Buffer( width, height, cls, pixelFormat )
		_pendingBuffer = New Buffer( width, height, cls, pixelFormat )
		
		_width = width
		_height = height
		_clearColor = cls=Null ? Color.Black Else cls
		_pixelFormat = pixelFormat
		
		' Initialize active buffer to the pending buffer
		_activeBuffer = _pendingBuffer
		
		' Initialize mini timer
		_lastUpdateTime = Millisecs()
	End

	' Constructor with canvas specification for immediate rendering
	Method New( 
		canvas:C, 
		width:Int, height:Int, 
		cls:Color=Null, 
		pixelFormat:PixelFormat=PixelFormat.RGBA8  )
	
		' The canvas of the C type (agnostic canvas wrapped by CanvasWrapper)
		_f = canvas
		
		' Create the canvas wrapper to provide adapter functionality
		_canvasWrapper = New CanvasWrapper<C,I,T>(canvas)
		
		' Initialize all three buffers
		_frontBuffer = New Buffer( width, height, cls, pixelFormat )
		_backBuffer = New Buffer( width, height, cls, pixelFormat )
		_pendingBuffer = New Buffer( width, height, cls, pixelFormat )
		
		_width = width
		_height = height
		_clearColor = cls=Null ? Color.Black Else cls
		_pixelFormat = pixelFormat
		
		' Initialize active buffer to the pending buffer
		_activeBuffer = _pendingBuffer
		
		' Initialize mini timer
		_lastUpdateTime = Millisecs()
	End	

	Property Name:String()
		Return _name 
	Setter( name:String )
	End 
	
	' Access to rendering target
	
	Property FrontBuffer:C()
		Return _f
	Setter(canvas:C)
		_f = canvas
		' Update wrapper if canvas changes
		If _canvasWrapper<>Null Then _canvasWrapper = New CanvasWrapper<C,I,T>(canvas)
	End 

	Property Wrapper:CanvasWrapper<C,I,T>()
		Return _canvasWrapper
	End
	
	' Direct buffer access for pixel operations
	
	Property Data:Buffer()
		Return _activeBuffer
	End
	
	Property Width:Int()
		Return _width
	End
	
	Property Height:Int()
		Return _height
	End
	
	' Transformation properties for rendering

	Property Position:Vec2f()
		Return _position
	Setter(position:Vec2f)
		_position = position
	End

	Property Rotation:Float()
		Return _angle
	Setter(rotation:Float)
		_angle = rotation
	End

	Property Scale:Vec2f()
		Return _scale
	Setter(scale:Vec2f)
		_scale = scale
	End
	
	' Performance tracking

	Property UpdatedFrames:Int()
		Return _updatedFrames
	End

	Property RenderedFrames:Int()
		Return _renderedFrames
	End
	
	' Core update mechanism using function delegation (and isn't a derivated class mecanism! )
	
	Property Update:Void()() Virtual
		
		' Check if enough time has elapsed since last update
		Local currentTime:Int = Millisecs()
		Local elapsed:Int = currentTime - _lastUpdateTime
		
		' Only update content if enough time has passed based on SwapInterval
		If elapsed >= _swapLaps
			
			_startTime = Millisecs()
			
			If _autoClear Cls()
			
			' Call the update delegate if it exists
			If _update_<>Null _update_()
			
			_updatedFrames += 1
			
			_lastUpdateTime = currentTime  ' Reset timer
			_needsRendering = True  ' Mark that we have new content to render
		End
		
		Return _update_ ' Return the delegate
		
	Setter(update:Void())
		
		_update_ = update
	End 
	
	' Performance metrics

    Property FPS:Int()
	    
		Local totalTime:Float = 0.0
           
		For Local i:Int = 0 Until _frameCount
			totalTime += _frameTimeHistory[i]
		Next
   
		Return 1000.0 / (totalTime / _frameCount)
	End

	' Performance metrics with stable FPS display
	Property FPS_Display:Int()
		' Check if it's time to update the displayed FPS value
		Local currentTime:Int = Millisecs()
		If currentTime - _lastFpsDisplayUpdate >= _fpsDisplayUpdateInterval
			' Update the display value with the current actual FPS
			_fpsDisplayValue = FPS
			_lastFpsDisplayUpdate = currentTime
		End
		
		' Return the cached display value
		Return _fpsDisplayValue
	End

	Property FPS_Realtime:Int()
		Return 1000.0 / _frameDuration
	End 

	Property FPS_DisplayInterval:Int()
		' How often (in milliseconds) to update the FPS display
		Return _fpsDisplayUpdateInterval
	Setter(value:Int)
		' Ensure reasonable interval (100-2000ms)
		_fpsDisplayUpdateInterval = Clamp(value, 100, 2000)
	End

	' Synchronization control

	' Control buffer swap synchronization
	' Represents frames per second (FPS)
	Property SwapInterval:Int()
		' Convert internal milliseconds value back to FPS
		Return 1000 / _swapLaps
	Setter(fps:Int)
		' Ensure at least 1 FPS
		Local targetFps:Int = Max(1, fps)  ' Ensure interval is at least 1ms
		
		' Convert FPS to milliseconds between updates
		_swapLaps = 1000 / targetFps
	End
	
	' Configure automatic buffer clearing
	Property ClearEnabled:Bool()
		Return _autoClear
	Setter(clear:Bool)
		_autoClear = clear
	End 

	' Core rendering function
	' (rotates and transfers buffers)
	Method Flip() Virtual 
		' Always measure the time for performance tracking
		_endTime = Millisecs() - _startTime
		_frameDuration = _endTime
		
		' Always update the texture of the active buffer
		_activeBuffer._t.PastePixmap( _activeBuffer._p, _activeBuffer._position.x, _activeBuffer._position.y )
		_activeBuffer._i.Image.SetTexture( 0, _activeBuffer._t.Texture )
		
		' Always display the front buffer on the canvas (if available)
		If _f <> Null 
			_f.DrawImage( _frontBuffer._i, _position.x, _position.y, _angle, _scale.x, _scale.y )
		Else
			RuntimeError( "Error: canvas not specified" )
		End 
		
		' Only rotate buffers if we have new content to display
		If _needsRendering
			' Rotate the buffers:
			' Front buffer becomes pending buffer (ready for drawing)
			' Back buffer becomes front buffer (displayed next frame)
			' Pending buffer becomes back buffer (queued for display)
			Local temp:Buffer = _frontBuffer
			_frontBuffer = _backBuffer
			_backBuffer = _activeBuffer
			_activeBuffer = temp  ' This is now our new drawing surface
			
			' Reset the flag - we've now rendered the latest content
			_needsRendering = False
		End
		
		' Always track performance metrics
		_renderedFrames += 1
		_frameTimeHistory[_historyIndex] = _frameDuration
		_historyIndex = (_historyIndex + 1) Mod _frameTimeHistory.Length
		_frameCount = Min(_frameCount + 1, _frameTimeHistory.Length)
	End

	' Buffer operations
	
	' Clear the buffer with optional color override
	Method Cls(cls:Color=Null)
		If cls <> Null 
			_activeBuffer._p.Clear(cls)
		Else
			_activeBuffer._p.Clear(_clearColor)
		End
	End

	' Canvas' scissor direct access

	Method SetScissor:Void(x:Int, y:Int, width:Int, height:Int)
		
		' Clamp values to valid range
		x = Max(0, Min(x, _width))
		y = Max(0, Min(y, _height))
		width = Max(0, Min(width, _width - x))
		height = Max(0, Min(height, _height - y))
		
		' Apply scissor to canvas
		_f.Scissor = New Recti(x, y, x + width, y + height)
		
		_scissorActive = True
	End

	Method ResetScissor:Void()
		
		_f.Scissor = New Recti(0, 0, _width, _height)
		_scissorActive = False
	End
	
	' Screen and coordinates

	'Set the design resolution this framebuffer was created for
	Method RestoreResolution:Void(width:Int, height:Int)
		' width:    Original design width in pixels
		' height:   Original design height in pixels
		_designWidth = width
		_designHeight = height
	End

	Method AdaptToResolution:Void(targetWidth:Int, targetHeight:Int, mode:ResolutionMode = ResolutionMode.Fit)
		_resolutionMode = mode
		
		Local sourceRatio:Float = Float(_width) / Float(_height)
		Local targetRatio:Float = Float(targetWidth) / Float(targetHeight)
		
		Local scale:Vec2f = New Vec2f(1, 1)
		Local position:Vec2f = New Vec2f(0, 0)
		
		Select mode
			Case ResolutionMode.Stretch
				' Simple stretching to fill target
				scale.x = Float(targetWidth) / Float(_width)
				scale.y = Float(targetHeight) / Float(_height)
				
			Case ResolutionMode.Fit
				' Maintain aspect ratio, fit within target
				Local scaleFactor:Float = Min(Float(targetWidth) / Float(_width), Float(targetHeight) / Float(_height))
				scale.x = scaleFactor
				scale.y = scaleFactor
				
				' Center in target area
				position.x = (targetWidth - (_width * scaleFactor)) * 0.5
				position.y = (targetHeight - (_height * scaleFactor)) * 0.5
				
			Case ResolutionMode.Fill
				' Maintain aspect ratio, fill target (may crop)
				Local scaleFactor:Float = Max(Float(targetWidth) / Float(_width), Float(targetHeight) / Float(_height))
				scale.x = scaleFactor
				scale.y = scaleFactor
				
				' Center in target area (negative positions crop the image)
				position.x = (targetWidth - (_width * scaleFactor)) * 0.5
				position.y = (targetHeight - (_height * scaleFactor)) * 0.5
				
			Case ResolutionMode.PixelPerfect
				' Use integer scaling factor only
				Local intScaleX:Int = Max(1, targetWidth / _width)
				Local intScaleY:Int = Max(1, targetHeight / _height)
				Local intScale:Int = Min(intScaleX, intScaleY)
				
				scale.x = intScale
				scale.y = intScale
				
				' Center with integer positions only
				position.x = (targetWidth - (_width * intScale)) / 2
				position.y = (targetHeight - (_height * intScale)) / 2
		End
		
		' Store calculated values
		_scale = scale
		_position = position
		
		' Update target rect for reference
		_targetRect = New Recti(
			Int(_position.x), 
			Int(_position.y), 
			Int(_position.x + _width * _scale.x), 
			Int(_position.y + _height * _scale.y))
	End

	Method ScreenToBuffer:Vec2f(screenX:Float, screenY:Float)
		' Adjust for position offset
		screenX -= _position.x
		screenY -= _position.y
		
		' Scale from screen to buffer coordinates
		Return New Vec2f(
			screenX / _scale.x,
			screenY / _scale.y)
	End

	Method BufferToScreen:Vec2f(bufferX:Float, bufferY:Float)
		Return New Vec2f(
			bufferX * _scale.x + _position.x,
			bufferY * _scale.y + _position.y)
	End

	' Buffer data operations
	
	Method CopyPixmap(target:Pixmap Ptr)
		target[0] = _activeBuffer._p.Copy()
	End
	
	Method CopyPixmap:Pixmap()
		Return _activeBuffer._p.Copy()
	End
	
	' Theoretical performance limit

	Property MaxTheoreticalFPS:Float()

		' Calculate theoretical maximum framerate based on buffer size
		' with the Aida 4's pixmap's Draw API.

		Local pixelsPerFrame:Float = _activeBuffer._p.Width * _activeBuffer._p.Height
		Local pixelsPerSecond:Float = 22222222.0 	' Typical number of 
													' pixel per second 
													' for the stdlib's Pixmap       
		Return pixelsPerSecond / pixelsPerFrame
	End

	'Very experimental, copy a framebuffer into another one of the same type.
	Method DrawRegion(x:Int, y:Int, width:Int, height:Int, renderer:Void(buffer:FrameBuffer<C,I,T>, x:Int, y:Int, w:Int, h:Int))
		renderer(Self, x, y, width, height)
	End
	
	Private 

	' Nested Buffer class for resource embbeding
	Class Buffer

		Method New( 
			width:Int, height:Int, 
			cls:Color=Null, 
			pixelFormat:PixelFormat=PixelFormat.RGBA8 )
			
			_p = New Pixmap(width, height)
			If cls <> Null _p.Clear(cls)
			
			' Create texture wrapper instead of direct texture
			_t = New TextureWrapper<T>(New T(width, height, pixelFormat, TextureFlags.Dynamic))

			' Create base image then wrap it
			_i=New ImageWrapperMojo(width, height, pixelFormat)
			_i.Image.Texture = _t.Texture

		End
		
		' Access to buffer components
	
		Property Image:ImageWrapper<C,I,T>()
			Return _i 
		End 
		
		Property Pixmap:Pixmap()
			Return _p
		End 
		
		Property Texture:TextureWrapper<T>()
			Return _t
		End 
		
		' Position within buffer (different from FrameBuffer position)
		Property Position:Vec2i()
			Return _position
		Setter(position:Vec2i)
			_position = position
		End
		
		Private 
		
		Field _p:Pixmap							' CPU-side pixel data, drawable with the stdlib's Aida 4's Draw Api
		Field _i:ImageWrapper<C,I,T>			' Drawable image
		Field _t:TextureWrapper<T>				' GPU texture wrapper (because we run over SDL2, not MS-DOS^^ )
		
		Field _position:Vec2i = New Vec2i(0, 0)	' Position of the drawn buffer on the canvas.
	End 

	Field _name:String 							' Framebuffer optional name

	Field _f:C									' Front buffer target (where we display)
	Field _canvasWrapper:CanvasWrapper<C,I,T>  	' The wrapper for the canvas
	
	' Triple-buffer implementation fields
	Field _frontBuffer:Buffer					' Currently being displayed
	Field _backBuffer:Buffer					' Ready for next display
	Field _pendingBuffer:Buffer					' Available for drawing
	Field _activeBuffer:Buffer					' Currently active buffer for drawing (points to pending)
	
	Field _width:Int 
	Field _height:Int
	Field _pixelFormat:PixelFormat = PixelFormat.RGBA8
	
	Field _update_:Void()		' Update's closure
	Field _updatedFrames:Int = 0
	Field _renderedFrames:Int = 0
	
	Field _position:Vec2f = New Vec2f(0, 0)
	Field _angle:Float = 0.0
	Field _scale:Vec2f = New Vec2f(1, 1)

	Field _swapLaps:Int = 1     ' Default interval of 1ms between updates
	Field _autoClear:Bool = True
	Field _clearColor:Color = Color.Black
	Field _canRender:Bool = True
	
	' FPS realtime
	Field _fps:Int
	
	' FPS display
	Field _fpsDisplayValue:Int = 60         	' The currently displayed FPS value
	Field _fpsDisplayUpdateInterval:Int = 500 	' Update interval in milliseconds
	Field _lastFpsDisplayUpdate:Int = 0     	' When the display was last updated

	Field _frameDuration:Int
	Field _startTime:Int
	Field _endTime:Int

	Field _frameTimeHistory:Float[] = New Float[30]
	Field _historyIndex:Int = 0
	Field _frameCount:Int = 0
	
	' Internal mini timer implementation
	Field _lastUpdateTime:Int    ' Last time update was called
	Field _needsRendering:Bool = True ' Flag to track if we have new content to display

	' Resolution management
	Field _designWidth:Int            ' Original width
	Field _designHeight:Int           ' Original height
	Field _resolutionMode:ResolutionMode = ResolutionMode.Fit
	Field _targetRect:Recti = New Recti(0, 0, 0, 0)  ' Calculated display area
	
	' Helper about drawing on canvas
	Field _scissorActive:Bool = False
End
