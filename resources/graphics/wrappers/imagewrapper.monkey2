
Namespace stdlib.graphics

'==============================================================
' Image Wrapper - Low-level Graphics Resource Abstraction
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Abstraction layer around Image objects that enables swapping 
' underlying image implementation without code changes
' Uses closures for customizable behavior without inheritance
' Integrates smoothly with FrameBuffer triple-buffer system
'==============================================================

Class ImageWrapper<C,I,T>

	Method New(		
			width:Int, height:Int,
			pixelFormat:PixelFormat=PixelFormat.RGBA8 )
		
		_image = New I(width,height,pixelFormat,TextureFlags.Dynamic)
		InitializeHandlers()
	End
	
	' Core image properties with delegated implementation
	Property Width:Int()
		If _widthHandler<>Null Return _widthHandler()
		Return 0  ' Default fallback
	End
	
	Property Height:Int()
		If _heightHandler<>Null Return _heightHandler()
		Return 0  ' Default fallback
	End
	
	' Image handle positioning with fluent interface
	Method Handle:ImageWrapper(x:Float, y:Float)
		If _handleHandler<>Null _handleHandler(x, y)
		Return Self
	End
	
	' Direct access to the wrapped image
	Property Image:I()
		Return _image
	End
	
	' Handler management for customizing behavior
	Method SetWidthHandler:Void(handler:Int())
		_widthHandler = handler
	End
	
	Method SetHeightHandler:Void(handler:Int())
		_heightHandler = handler
	End
	
	Method SetHandleHandler:Void(handler:Void(x:Float, y:Float))
		_handleHandler = handler
	End
	
	Protected
	
	' Initialize the default handlers for standard Image properties
	Method InitializeHandlers:Void()
		
		' These implementations assume the wrapped image has compatible properties
		' For Mojo's Image class, these work directly
		
		SetWidthHandler(Lambda:Int()
			Return _image.Width
		End)
		
		SetHeightHandler(Lambda:Int()
			Return _image.Height
		End)
		
		SetHandleHandler(Lambda:Void(x:Float, y:Float)
			_image.Handle = New Vec2f(x, y)
		End)
	End

	' Buffer pool management for reusing resources
	Method GetBufferFromPool:ImageBuffer<C,I,T>(width:Int, height:Int, format:PixelFormat)
		' Find suitable buffer or create new one
		For Local i:Int = 0 Until _buffers.Length
			Local buffer:= _buffers[i]
			If buffer.Width >= width And buffer.Height >= height And buffer.Format = format
				_buffers.Erase(i)
				Return buffer
			End
		End
		
		' Create new buffer if none found
		Return New ImageBuffer<C,I,T>(width, height, format)
	End
	
	Method ReturnBufferToPool(buffer:ImageBuffer<C,I,T>)
		' Only keep a reasonable number of buffers
		If _buffers.Length < MAX_POOLED_BUFFERS Then _buffers.Push(buffer)
	End

	Public 

	' Integrated Class Image Extension 'About Drawing agnostically an image on a pixmap 
	'
	' iDkP from GaragePixel
	' 2025-01-16
	' Adapted from ImageWrapper since 2025-03-31
	'
	' Proposed and discuted in the Discord server by iDkP: 
	' https://discord.com/channels/796336780302876683/870267572812128298/1329307346895110205
	'
	' 	— « Thanks @doumdoum for giving a kick to this idea^^ 
	' 		I had more or less given up and used custom drawing routines on pixmaps. 
	' 		But the basic idea was to produce a pixmap by drawing with mojo functions 
	' 		to take advantage of the acceleration, while freeing the VRam from the texture, 
	' 		keeping it in RAM to use it in the context of a "retro programmed" engine 
	' 		or other ideas. »
	'
	' This method extends Mojo's Image with methods to create Pixmaps from image content,
	' allowing for efficient zero-copy pipeline integration between the rendering
	' system and the pixmap drawing API. This enables seamless transfer from
	' GPU-accelerated images to CPU-manipulable pixel data.
	
	'Class ImageWrapper<C,I,T> Extension 'About extracting pixmap data from images
	'#Rem

	' Extract image data to pixmap with optimized paths
	Method FromImage:Pixmap(rect:Recti=Null, dstx:Int=0, dsty:Int=0, convertPixelFormat:Bool=False)
		' Get image dimensions
		Local width:Int = Width
		Local height:Int = Height
		
		' Use full rect if not specified
		If rect = Null Then rect = New Recti(0, 0, width, height)
		
		' Validate extraction region
		rect = ValidateRect(rect, width, height)
		
		' Select optimal format
		Local format:PixelFormat = PixelFormat.RGBA8
		
		' Early exit with empty pixmap for invalid regions
		If rect.Width <= 0 Or rect.Height <= 0
			Return New Pixmap(1, 1, format)
		End
		
		' Get or create buffer from pool
		Local buffer:ImageBuffer<C,I,T> = GetBufferFromPool(width, height, format)
		
		' Extract image data using buffer
		Local resultPixmap:Pixmap
		
		' Draw to intermediate buffer
		buffer.Clear(Color.None)
		buffer.Canvas.DrawImage(Self, dstx, dsty)
		
		' Use the adapter pattern with CopyPixels handler
		' This eliminates the need for direct Canvas access
		buffer.Canvas.Canvas.Flush() ' Still need to flush the canvas
		
		' Extract region to pixmap using the adapter
		resultPixmap = New Pixmap(rect.Width, rect.Height, format)
		buffer.Canvas.CopyPixels(rect, resultPixmap)
			
		' Convert format if requested
		If convertPixelFormat And Self.Image.Texture.Format <> format
			resultPixmap = resultPixmap.Convert(Self.Image.Texture.Format)
		End

		' Return buffer to pool
		ReturnBufferToPool(buffer)
		
		Return resultPixmap
	End
	
	Private 
	
	' Helper method to validate and adjust extraction rectangle
	Method ValidateRect:Recti(rect:Recti, width:Int, height:Int)
		Local x0:Int = Max(0, rect.Left)
		Local y0:Int = Max(0, rect.Top)
		Local x1:Int = Min(width, rect.Right)
		Local y1:Int = Min(height, rect.Bottom)
		
		Return New Recti(x0, y0, x1, y1)
	End

	Private
	
	' The wrapped image instance
	Field _image:I
	
	' Property and operation handlers
	Field _widthHandler:Int()
	Field _heightHandler:Int()
	Field _handleHandler:Void(x:Float, y:Float)

	' For the Buffer pool management
	
	Global _buffers:Stack<ImageBuffer<C,I,T>> = New Stack<ImageBuffer<C,I,T>>
	Const MAX_POOLED_BUFFERS:Int = 5
End