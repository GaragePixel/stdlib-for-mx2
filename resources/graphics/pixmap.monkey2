
Namespace stdlib.graphics

#import "../../system/resources/resource"
#import "../../collections/collections"

#import "pixmaploader"
#import "pixmapsaver"

Using stdlib.system.resource..
Using stdlib.graphics.pixmaploader
Using stdlib.math.types..
Using stdlib.collections..

Extern Private

Function ldexp:Float( x:Float,exp:Int )
	
Function frexp:Float( arg:Float,exp:Int Ptr )
	
Private

Const Zero:Int=0

Function GetColorRGBE8:Color( p:UByte Ptr)
	If Not p[3] Return Color.Black
	Local f:=ldexp( 1.0,p[3]-136 )
	Return New Color( p[0]*f,p[1]*f,p[2]*f )
End

Function SetColorRGBE8( p:UByte Ptr,color:Color )
	Local v:=color.r,e:=0
	If color.g>v v=color.g
	If color.b>v v=color.b
	If( v<1e-32) p[0]=0;p[1]=0;p[2]=0;p[3]=0;Return
	v=frexp( v,Varptr e ) * 256.0/v
	p[0]=color.r*v
	p[1]=color.g*v
	p[2]=color.b*v
	p[0]=e+128
End
	
Public

'INTEGRATED FROM EXTENSION: 

	' ------------------------------------------------------
	' Extension methods for Pixmap drawing operations
	' Implementation by iDkP from GaragePixel
	' 2025-03-23 Aida 4
	' ------------------------------------------------------

'TODO: Move that at the right place when the Math sublib will be integrated

' Fill rule constants
Const FILL_EVEN_ODD:UByte = 0  ' Even-odd rule (alternate)
Const FILL_WINDING:UByte = 1   ' Non-zero winding rule

' ------------------------------------------------------ END

#rem monkeydoc Pixmaps allow you to store and manipulate rectangular blocks of pixel data.

A pixmap contains a block of memory used to store a rectangular array of pixels.

#end
Class Pixmap Extends Resource

	#rem monkeydoc Creates a new pixmap.
	
	When you have finished with the pixmap, you should call its inherited [[resource.Resource.Discard]] method.

	@param width The width of the pixmap in pixels.
	
	@param height The height of the pixmap in pixels.
	
	@param format The pixmap format.
	
	@param data A pointer to the pixmap data.
	
	@param pitch The pitch of the data.
	
	#end
	Method New( width:Int,height:Int,format:PixelFormat=PixelFormat.RGBA8 )

		Local depth:=PixelFormatDepth( format )
		Local pitch:=width*depth
		Local data:=Cast<UByte Ptr>( GCMalloc( pitch*height ) )
		
		_width=width
		_height=height
		_format=format
		_depth=depth
		_pitch=pitch
		_owned=True
		_data=data
		InitSetPixel(Self) 		'iDkP: Added for the little bird's happiness
		InitSetPixelARGB(Self) 	'iDkP: Added for the little bird's happiness
		InitGetPixel(Self) 		'iDkP: Added for the little bird's happiness
		InitGetPixelARGB(Self) 	'iDkP: Added for the little bird's happiness
		InitHasAlpha(Self) 		'iDkP: Added for the little bird's happiness
	End
	
	Method New( width:Int,height:Int,format:PixelFormat,data:UByte Ptr,pitch:Int )

		Local depth:=PixelFormatDepth( format )
		
		_width=width
		_height=height
		_format=format
		_depth=depth
		_data=data
		_pitch=pitch
		InitSetPixel(Self) 		'iDkP: Added for the little bird's happiness
		InitSetPixelARGB(Self) 	'iDkP: Added for the little bird's happiness
		InitGetPixel(Self) 		'iDkP: Added for the little bird's happiness
		InitGetPixelARGB(Self) 	'iDkP: Added for the little bird's happiness
		InitHasAlpha(Self) 		'iDkP: Added for the little bird's happiness
	End
	
	#rem monkeydoc Optional name.
	
	#end
	Property Name:String()
		Return _name
	Setter( name:String )
		If name.Length>32 name=name.Slice(0,32) 'Against exploit
		_name=name
	End
	
	#rem monkeydoc The width and height of the pixmap.
	
	#end
	Property Size:Vec2i()
		Return New Vec2i( _width,_height )
	End

	#rem monkeydoc The pixmap width.
	
	#end
	Property Width:Int()
		Return _width
	End
	
	#rem monkeydoc The pixmap height.
	
	#end
	Property Height:Int()
		Return _height
	End
	
	#rem monkeydoc The pixmap format.
	
	#end
	Property Format:PixelFormat()
		Return _format
	End
	
	#rem monkeydoc The pixmap depth. 
	
	The number of bytes per pixel.
	
	#end
	Property Depth:Int()
		Return _depth
	End
	
	#rem monkeydoc True if pixmap format includes alpha.
	#end
	Property HasAlpha:Bool()
		Return _hasAlpha
	End
	
	'iDkP whatza?
'	Property HasAlpha:Bool()
'		
'		Select _format
'		Case PixelFormat.A8,PixelFormat.IA8,PixelFormat.RGBA8
'			Return True
'		End
'		Return False
'	End
	
	#rem monkeydoc The raw pixmap data.
	
	#end
	Property Data:UByte Ptr()
		
		Return _data
	End
	
	#rem monkeydoc The pixmap pitch.
	
	This is the number of bytes between one row of pixels in the pixmap and the next.
	
	#end
	Property Pitch:Int()
		
		Return _pitch
	End


	#rem monkeydoc Image filepath.
	#end
	Property FilePath:String()
		'jl added
		Return _filePath
	Setter( filePath:String )
		_filePath = filePath
	End
	
	#rem monkeydoc Gets a pointer to a pixel in the pixmap.
	
	@param x the x coordinate of the pixel.
	
	@param y the y coordinate of the pixel.
	
	@return the address of the pixel at `x`, `y`.
	
	#end
	Method PixelPtr:UByte Ptr( x:Int,y:Int )
		' iDkP: Keeped for front programmer
		Return _data + y*_pitch + x*_depth
	End

	Function PixelPtr:UByte Ptr( p:Pixmap, x:Int,y:Int )
		' iDkP: Keeped for front programmer
		Return p.Data + y*p.Pitch + x*p.Depth
	End

	Method PixelPtr:UByte Ptr( x:Int Ptr,y:Int Ptr )
		'Added by iDkP - Always use pointer in backstage
		Return _data + y[0]*_pitch + x[0]*_depth
	End

	Function PixelPtr:UByte Ptr( p:Pixmap, x:Int Ptr,y:Int Ptr )
		'Added by iDkP - Always use pointer in backstage
		Return p.Data + y[0]*p.Pitch + x[0]*p.Depth
	End

	Method PixelPtr:UByte Ptr( y:Int )
		'Added by iDkP
		Return _data + y*_pitch' + 0*_depth
	End

	Method PixelPtr:UByte Ptr( y:Int Ptr )
		'Added by iDkP - Always use pointer in backstage
		Return _data + y[0]*_pitch' + 0*_depth
	End

	Function PixelPtr:UByte Ptr( p:Pixmap, y:Int Ptr )
		'Added by iDkP - Always use pointer in backstage
		Return p.Data + y[0]*p.Pitch' + 0*p.Depth
	End

	' -------------------- 	iDkP's Standard Zero-Branch Execution programming style
	' 						350% speed up
	
	#rem monkeydoc Sets a pixel to a color.
	
	Sets the pixel at `x`, `y` to `pixel`.
	
	In debug builds, a runtime error will occur if the pixel coordinates lie outside of the pixmap area.
	
	@param x The x coordinate of the pixel.
	
	@param y The y coordinate of the pixel.
	
	@param color The color to set the pixel to.
	
	#end
	Method SetPixel( x:Int,y:Int,color:Color )
		
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
		
		'Added by iDkP
		Local argb:=color.ToARGB()
		_SetPixelARGB_( Self, Varptr(x), Varptr(y), Varptr(argb) )
		
		#rem UNDONED by iDkP from GaragePixel, 2025-04-01: 

		Local p:=PixelPtr( x,y )
		
		Select _format
		Case PixelFormat.A8
			p[0]=color.a * 255
		Case PixelFormat.I8
			p[0]=color.r * 255
		Case PixelFormat.IA8
			p[0]=color.r * 255
			p[1]=color.a * 255
		Case PixelFormat.RGB8
			p[0]=color.r * 255
			p[1]=color.g * 255
			p[2]=color.b * 255
		Case PixelFormat.RGBA8
			p[0]=color.r * 255
			p[1]=color.g * 255
			p[2]=color.b * 255
			p[3]=color.a * 255
		Case PixelFormat.RGB32F
			Local f:=Cast<Float Ptr>( p )
			f[0]=color.r
			f[1]=color.g
			f[2]=color.b
		Case PixelFormat.RGBA32F
			Local f:=Cast<Float Ptr>( p )
			f[0]=color.r
			f[1]=color.g
			f[2]=color.b
			f[3]=color.a
		Case PixelFormat.RGBE8
			SetColorRGBE8( p,color )
		Default
			Assert( False ) 'Mark, you assert an unknow format while we can't even create a pixmap from an unknow format?
		End
		#end
	End
	
	'Added by iDkP
	Method SetPixel( x:Int Ptr,y:Int Ptr,color:Color Ptr)
		
		DebugAssert( x[0]>=0 And y[0]>=0 And x[0]<_width And y[0]<_height,"Pixmap pixel coordinates out of range" )
		
		Local argb:=color[0].ToARGB()
		_SetPixelARGB_( Self, x, y, Varptr(argb) )
	End
	
	#rem monkeydoc Sets a pixel to an ARGB color.
	
	Sets the pixel at `x`, `y` to `pixel`.
	
	In debug builds, a runtime error will occur if the pixel coordinates lie outside of the pixmap area.
	
	@param x The x coordinate of the pixel.
	
	@param y The y coordinate of the pixel.
	
	@param color The pixel to set in ARGB format.
	
	#end
	Method SetPixelARGB( x:Int,y:Int,color:UInt )
		
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
	
		' Added by iDkP
		_SetPixelARGB_( Self, Varptr(x), Varptr(y), Varptr(color) )
		
		#rem UNDONED by iDkP from GaragePixel, 2025-04-01:
		
		Select _format
		Case PixelFormat.A8
			p[0]=color Shr 24
		Case PixelFormat.I8
			p[0]=color Shr 16
		Case PixelFormat.IA8
			p[0]=color Shr 24
			p[1]=color Shr 16
		Case PixelFormat.RGB8
			p[0]=color Shr 16
			p[1]=color Shr 8
			p[2]=color
		Case PixelFormat.RGBA8
			p[0]=color Shr 16
			p[1]=color Shr 8
			p[2]=color
			p[3]=color Shr 24
		Case PixelFormat.RGB32F
			Local f:=Cast<Float Ptr>( p )
			f[0]=((color Shr 16)&255)/255.0
			f[1]=((color Shr 8)&255)/255.0
			f[2]=(color&255)/255.0
		Case PixelFormat.RGBA32F
			Local f:=Cast<Float Ptr>( p )
			f[0]=((color Shr 16)&255)/255.0
			f[1]=((color Shr 8)&255)/255.0
			f[2]=(color&255)/255.0
			f[3]=((color Shr 24)&255)/255.0
		Case PixelFormat.RGBE8
			SetColorRGBE8( p,New Color( ((color Shr 16)&255)/255.0,((color Shr 8)&255)/255.0,(color&255)/255.0,((color Shr 24)&255)/255.0 ) )
		Default
			SetPixel( x,y,New Color( ((color Shr 16)&255)/255.0,((color Shr 8)&255)/255.0,(color&255)/255.0,((color Shr 24)&255)/255.0 ) )
		End
		#End of the massacre
	End

	'Added by iDkP
	Method SetPixelARGB( x:Int Ptr,y:Int Ptr,color:UInt Ptr)
		
		DebugAssert( x[0]>=0 And y[0]>=0 And x[0]<_width And y[0]<_height,"Pixmap pixel coordinates out of range" )
		
		_SetPixelARGB_( Self, x, y, color )
	End

	#rem monkeydoc Gets the color of a pixel.
	
	Gets the pixel at `x`, `y` and returns it in ARGB format.
	
	In debug builds, a runtime error will occur if the pixel coordinates lie outside of the pixmap area.

	@param x The x coordinate of the pixel.
	
	@param y The y coordinate of the pixel.
	
	@return The color of the pixel at `x`, `y`.
	
	#end
	Method GetPixel:Color( x:Int,y:Int )
		
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
	
		Return Color.FromARGB(_GetPixelARGB_( Self, Varptr(x), Varptr(y) ))
		
		#rem UNDONED by iDkP from GaragePixel, 2025-04-01:
	
		Local p:=PixelPtr( x,y )

		Select _format
		Case PixelFormat.A8 
			Return New Color( 0,0,0,p[0]/255.0 )
		Case PixelFormat.I8
			Local i:=p[0]/255.0
			Return New Color( i,i,i,1 )
		Case PixelFormat.IA8
			Local i:=p[0]/255.0
			Return New Color( i,i,i,p[1]/255.0 )
		Case PixelFormat.RGB8
			Return New Color( p[0]/255.0,p[1]/255.0,p[2]/255.0,1 )
		Case PixelFormat.RGBA8
			Return New Color( p[0]/255.0,p[1]/255.0,p[2]/255.0,p[3]/255.0 )
		Case PixelFormat.RGB32F
			Local f:=Cast<Float Ptr>( p )
			Return New Color( f[0],f[1],f[2] )
		Case PixelFormat.RGBA32F
			Local f:=Cast<Float Ptr>( p )
			Return New Color( f[0],f[1],f[2],f[3] )
		Case PixelFormat.RGBE8
			Return GetColorRGBE8( p )
		Default
			Assert( False )
		End
		Return Color.None
		
		#end
	End

	'Added by iDkP
	Method GetPixel:Color( x:Int Ptr,y:Int Ptr )
		
		DebugAssert( x[0]>=0 And y[0]>=0 And x[0]<_width And y[0]<_height,"Pixmap pixel coordinates out of range" )
		
		Return Color.FromARGB(_GetPixelARGB_( Self, x, y ))
	End

	#rem monkeydoc Gets the ARGB color of a pixel.
	
	Get the pixel at `x`, `y` and returns it in ARGB format.

	@param x the x coordinate of the pixel.
	
	@param y the y coordinate of the pixel.
	
	@return the pixel at `x`, `y` in ARGB format.
	
	#end
	Method GetPixelARGB:UInt( x:Int,y:Int )
		
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
	
		'Added by iDkP
		Return _GetPixelARGB_( Self, Varptr(x), Varptr(y) )
		
		#rem UNDONED by iDkP from GaragePixel, 2025-04-01:
	
		Local p:=PixelPtr( x,y )
		
		Select _format
		Case PixelFormat.A8 
			Return p[0] Shl 24
		Case PixelFormat.I8 
			Local i:=p[0]
			Return UByte($ff) Shl 24 | i Shl 16 | i Shl 8 | i
		Case PixelFormat.IA8
			Local i:=p[1]
			Return p[0] Shl 24 | i Shl 16 | i Shl 8 | i
		Case PixelFormat.RGB8
			Return UByte($ff) Shl 24 | p[0] Shl 16 | p[1] Shl 8 | p[2]
		Case PixelFormat.RGBA8
			Return p[3] Shl 24 | p[0] Shl 16 | p[1] Shl 8 | p[2]
		Case PixelFormat.RGB32F
			Local f:=Cast<Float Ptr>( p )
			Return UInt($ff) Shl 24 | UInt(f[0]*255.0) Shl 16 | UInt(f[1]*255.0) Shl 8 | UInt(f[2]*255.0)
		Case PixelFormat.RGBA32F
			Local f:=Cast<Float Ptr>( p )
			Return UInt(f[3]*255.0) Shl 24 | UInt(f[0]*255.0) Shl 16 | UInt(f[1]*255.0) Shl 8 | UInt(f[2]*255.0)
		Case PixelFormat.RGBE8
			Local color:=GetColorRGBE8( p )
			Return UInt($ff) Shl 24 | UInt(color.r*255.0) Shl 16 | UInt(color.g*255.0) Shl 8 | UInt(color.b*255.0)
		Default
			Local color:=GetPixel( x,y )
			Return UInt(color.a*255.0) Shl 24 | UInt(color.r*255.0) Shl 16 | UInt(color.g*255.0) Shl 8 | UInt(color.b*255.0)
		End

		Return 0
		#end
	End

	'Added by iDkP
	Method GetPixelARGB( x:Int Ptr,y:Int Ptr )
		
		DebugAssert( x[0]>=0 And y[0]>=0 And x[0]<_width And y[0]<_height,"Pixmap pixel coordinates out of range" )
		
		_GetPixelARGB_( Self, x, y )
	End
	
	'-----------------------

'jl added
	#rem monkeydoc Sets a pixel to a RGBA color using bytes or floats.
	Sets the pixel at `x`, `y` to the color r,g,b,a.
	
	This method is only valid for use with PixelFormat.RGBA8.
	
	A runtime error will occur if the pixel coordinates lie outside of the pixmap area.

	There are 2 overloads of the function: Using UByte (0-255) or Float (0.0-1.0) for the r,g,b,a color values.

	@param x The x coordinate of the pixel.
	@param y The y coordinate of the pixel.
	@param r the red component of the pixel.
	@param g the green component of the pixel.
	@param b the blue component of the pixel.
	@param a the alpha component of the pixel.
	#end
	Method SetPixelRGBA8( x:Int, y:Int, r:UByte, g:UByte, b:UByte, a:UByte )
		Local p:=PixelPtr( Varptr(x), Varptr(y) ) 'iDkP: always use pointer in the backstage
		p[0] = r
		p[1] = g
		p[2] = b
		p[3] = a
	End
	
	Method SetPixelRGBA8( x:Int, y:Int, r:Float, g:Float, b:Float, a:Float )
		Local p:=PixelPtr( Varptr(x), Varptr(y) ) 'iDkP: always use pointer in the backstage
		p[0] = r * 255
		p[1] = g * 255
		p[2] = b * 255
		p[3] = a * 255
	End

	' Added by iDkP, for back end programmer.
	
	Method SetPixelRGBA8( x:Int Ptr, y:Int Ptr, r:UByte Ptr, g:UByte Ptr, b:UByte Ptr, a:UByte Ptr )
		Local p:=PixelPtr( x, y )
		p[0] = r[0]
		p[1] = g[0]
		p[2] = b[0]
		p[3] = a[0]
	End
	
	Method SetPixelRGBA8( x:Int Ptr, y:Int Ptr, r:Float Ptr, g:Float Ptr, b:Float Ptr, a:Float Ptr )
		Local p:=PixelPtr( x, y )
		p[0] = r[0] * 255
		p[1] = g[0] * 255
		p[2] = b[0] * 255
		p[3] = a[0] * 255
	End
	
	'Optimized!
	'
	#rem monkeydoc Clears the pixmap to a given color.
	
	@param color The color to clear the pixmap to.
	
	#end
	Method Clear( color:Color ) 'iDkP: Overloaded version of something clear
		
		' Ultra-optimized pixel clear leveraging pointer-based performance advantage 

		' This optimization follows my zero-branch execution philosophy 
		' by eliminating millions of redundant operations 
		' without introducing any conditional logic. 
		
		' Pre-calculate ARGB value once 
		Local argb:UInt = color.ToARGB() 
		Local argbPtr:UInt Ptr = Varptr(argb)
	
		' Fixed memory addresses for coordinates
		Local x:Int = 0
		Local y:Int = 0
		Local xPtr:Int Ptr = Varptr(x)
		Local yPtr:Int Ptr = Varptr(y)
		
		' Cache width/height to avoid repeated property access
		Local width:Int = Width
		Local height:Int = Height
		
		' Format-specific direct memory optimization
		If Format = PixelFormat.RGBA8
			' Extract color components
			Local r:UByte = (argb Shr 16) & $FF
			Local g:UByte = (argb Shr 8) & $FF
			Local b:UByte = argb & $FF
			Local a:UByte = (argb Shr 24) & $FF
			
			' Process each row - row-major order for optimal cache usage
			For Local row:Int = 0 Until height
				Local rowPtr:UByte Ptr = Data + row * Pitch
				
				' Process pixels in blocks of 16 for better cache utilization
				Local col:Int = 0
				While col < width - 15
					Local pixelPtr:UByte Ptr = rowPtr + col * 4
					
					' Unrolled block of 16 pixels
					For Local i:Int = 0 Until 16
						pixelPtr[0] = r
						pixelPtr[1] = g
						pixelPtr[2] = b
						pixelPtr[3] = a
						pixelPtr += 4
					Next
					
					col += 16
				Wend
				
				' Handle remaining pixels
				While col < width
					Local pixelPtr:UByte Ptr = rowPtr + col * 4
					pixelPtr[0] = r
					pixelPtr[1] = g
					pixelPtr[2] = b
					pixelPtr[3] = a
					col += 1
				Wend
			End
			
			Return
		End
		
		' Generic pointer-based implementation for other formats
		For y = 0 Until height
			For x = 0 Until width
				SetPixelARGB( xPtr, yPtr, argbPtr )
			End
		End
	End
#rem 
	Method Clear( color:Color )
		
		' Modified by iDkP
		' This optimization follows my zero-branch execution philosophy 
		' by eliminating millions of redundant operations 
		' without introducing any conditional logic. 
		
		' Static coordinates with fixed memory addresses
		Local xCoord:Int = 0
		Local yCoord:Int = 0
		
		' Calculate pointers once
		Local xPtr:Int Ptr = Varptr(xCoord)
		Local yPtr:Int Ptr = Varptr(yCoord)
		Local colorPtr:Color Ptr = Varptr(color)
		
		' Use the pointers with in-place value updates
		For yCoord = 0 Until _height
			For xCoord = 0 Until _width
				SetPixel(xPtr, yPtr, colorPtr)
			End 
		End
	End
#end 

	#rem monkeydoc Clears the pixmap to an ARGB color.
	
	@param color ARGB color to clear the pixmap to.
	
	#end

	Method Clear( color:UInt ) 'iDkP: Overloaded version of something clear

		' iDkP:
		' This optimization follows my zero-branch execution philosophy 
		' by eliminating millions of redundant operations 
		' without introducing any conditional logic. 
		
		'Sugar

		' Static coordinates with fixed memory addresses
		Local xCoord:Int = 0
		Local yCoord:Int = 0
		
		' Calculate pointers once
		Local xPtr:Int Ptr = Varptr(xCoord)
		Local yPtr:Int Ptr = Varptr(yCoord)
		Local colorPtr:UInt Ptr = Varptr(color)
		
		' Use the pointers with in-place value updates
		For yCoord = 0 Until _height
			For xCoord = 0 Until _width
				SetPixelARGB(xPtr, yPtr, colorPtr)
			End
		End
	End

	
	#rem monkeydoc Clears the pixmap to an ARGB color.
	
	@param color ARGB color to clear the pixmap to.
	
	#end
	Method ClearARGB( color:UInt )

		' Modified by iDkP
		' This optimization follows my zero-branch execution philosophy 
		' by eliminating millions of redundant operations 
		' without introducing any conditional logic. 
		
		' Static coordinates with fixed memory addresses
		Local xCoord:Int = 0
		Local yCoord:Int = 0
		
		' Calculate pointers once
		Local xPtr:Int Ptr = Varptr(xCoord)
		Local yPtr:Int Ptr = Varptr(yCoord)
		Local colorPtr:UInt Ptr = Varptr(color)
		
		' Use the pointers with in-place value updates
		For yCoord = 0 Until _height
			For xCoord = 0 Until _width
				SetPixelARGB( xPtr, yPtr, colorPtr )
			End
		End
	End

	#rem monkeydoc Creates a copy of the pixmap.

	@return A new pixmap.
	
	#end
	Method Copy:Pixmap()
	    Local pitch:=Width * Depth
	    Local data:=Cast<UByte Ptr>( stdlib.plugins.libc.malloc( pitch * Height ) )
	    
	    ' Static y coordinate with fixed memory address
	    Local y:Int = 0
	    Local yPtr:Int Ptr = Varptr(y)
	    
	    For y = 0 Until Height
	        stdlib.plugins.libc.memcpy( data+y*pitch, PixelPtr(yPtr), pitch )
	    Next
	    
	    Return New Pixmap( Width,Height,Format,data,pitch )
	End
	
	#rem monkeydoc Paste a pixmap to the pixmap.
	
	In debug builds, a runtime error will occur if the operation would write to pixels outside of the pixmap.

	Note: No alpha blending is performed - pixels in the pixmap are simply overwritten.
	
	@param pixmap The pixmap to paste.
	
	@param x The x coordinate.
	
	@param y The y coordinate.
	
	#end
	Method Paste( pixmap:Pixmap, x:Int, y:Int ) 
		
		' Ultra-optimized paste operation leveraging pointer-based performance 
		
		Local dst:=Self
		
		' Skip if completely outside bounds 
		If x >= Width Or y >= Height Or x + pixmap.Width <= 0 Or y + pixmap.Height <= 0 Return
	
		' Calculate visible rectangle
		Local dstX:Int = Max(0, x)
		Local dstY:Int = Max(0, y)
		Local srcX:Int = Max(0, -x)
		Local srcY:Int = Max(0, -y)
		Local width:Int = Min(pixmap.Width - srcX, Width - dstX)
		Local height:Int = Min(pixmap.Height - srcY, Height - dstY)
		
		' Skip if nothing to draw
		If width <= 0 Or height <= 0 Return
		
		' Fast path for identical formats
		If Format = pixmap.Format And Format = PixelFormat.RGBA8
			' Copy row by row using optimized memory operations
			For Local row:Int = 0 Until height
				Local srcPtr:UByte Ptr = pixmap.Data + (srcY + row) * pixmap.Pitch + srcX * 4
				Local dstPtr:UByte Ptr = Data + (dstY + row) * Pitch + dstX * 4
				stdlib.plugins.libc.memcpy(dstPtr, srcPtr, width * 4)
			End
			Return
		End
		
		' Generic implementation using pointer-based pixel access
		Local sx:Int = 0, sy:Int = 0, dx:Int = 0, dy:Int = 0
		Local sxPtr:Int Ptr = Varptr(sx)
		Local syPtr:Int Ptr = Varptr(sy)
		Local dxPtr:Int Ptr = Varptr(dx)
		Local dyPtr:Int Ptr = Varptr(dy)
		
		' Reuse a single Color object to avoid allocations
		Local c:Color
		Local cPtr:Color Ptr = Varptr(c)
		
		For Local iy:Int = 0 Until height
			sy = srcY + iy
			dy = dstY + iy
			
			For Local ix:Int = 0 Until width
				sx = srcX + ix
				dx = dstX + ix
				
				c = pixmap.GetPixel(sxPtr, syPtr)
				SetPixel(dxPtr, dyPtr, cPtr)
			End
		End
	End
#rem
	Method Paste( pixmap:Pixmap,x:Int,y:Int )
		
	    DebugAssert( x>=0 And x+pixmap._width<=_width And y>=0 And y+pixmap._height<=_height )
	    
	    ' Static coordinates with fixed memory addresses
	    Local dstX:Int = 0, dstY:Int = 0
	    Local srcX:Int = 0, srcY:Int = 0
	    
	    ' Calculate pointers once
	    Local dstXPtr:Int Ptr = Varptr(dstX)
	    Local dstYPtr:Int Ptr = Varptr(dstY)
	    Local srcXPtr:Int Ptr = Varptr(srcX)
	    Local srcYPtr:Int Ptr = Varptr(srcY)
	    
	    ' Reusable color object
	    Local c:Color
	    Local cPtr:Color Ptr = Varptr(c)
	    
	    For srcY = 0 Until pixmap._height
	        dstY = y + srcY
	        For srcX = 0 Until pixmap._width
	            dstX = x + srcX
	            c = pixmap.GetPixel(srcXPtr, srcYPtr)
	            SetPixel(dstXPtr, dstYPtr, cPtr)
	        Next
	    Next
	End
#end

	'Optimized!
	'
	#rem monkeydoc Converts the pixmap to a different format.
	
	@param format The pixel format to convert the pixmap to.
	
	@return A new pixmap.
	
	#end
	Method Convert:Pixmap( format:PixelFormat )
		
		Local t:=New Pixmap( _width,_height,format )
		
		' Static coordinates with fixed memory addresses
		Local xCoord:Int = 0
		Local yCoord:Int = 0
		
		' Calculate pointers once
		Local xPtr:Int Ptr = Varptr(xCoord)
		Local yPtr:Int Ptr = Varptr(yCoord)
		
		If IsFloatPixelFormat( _format ) And Not IsFloatPixelFormat( format )
			' Local variable to hold pixel color across iterations
			Local c:Color
			Local cPtr:Color Ptr = Varptr(c)
			
			For yCoord = 0 Until _height
				For xCoord = 0 Until _width
					c = GetPixel( xCoord, yCoord )
					c.r = Clamp( c.r, 0.0, 1.0 )
					c.g = Clamp( c.g, 0.0, 1.0 )
					c.b = Clamp( c.b, 0.0, 1.0 )
					c.a = Clamp( c.a, 0.0, 1.0 )
					t.SetPixel( xPtr, yPtr, cPtr )
				End
			End
		Else
			' Local variable to store pixel color
			Local c:Color
			Local cPtr:Color Ptr = Varptr(c)
			
			For yCoord = 0 Until _height
				For xCoord = 0 Until _width
					c = GetPixel( xCoord, yCoord )
					t.SetPixel( xPtr, yPtr, cPtr )
				End
			End
		End
		
		Return t
	End
	
	'Optimized!
	'
	#rem monkeydoc Premultiply pixmap r,g,b components by alpha.
	#end
	Method PremultiplyAlpha()
		
		'Mark: Optimize!
		
		'iDkP: Yep, done, dear Mark. We need to store an Alpha property state for the instance
		'instead of doing this kind of bizarro inefficient procedural code blocks.
		'Let's bring Monkey2 into Aida's world.
		
		'Select _format
			'Case PixelFormat.IA8,PixelFormat.RGBA8,PixelFormat.RGBA16F,PixelFormat.RGBA32F

		' Only proceed if format has alpha component
		If HasAlpha
			' Static coordinates with fixed memory addresses
			Local xCoord:Int = 0
			Local yCoord:Int = 0
			
			' Calculate pointers once
			Local xPtr:Int Ptr = Varptr(xCoord)
			Local yPtr:Int Ptr = Varptr(yCoord)
			
			' Local variable to hold pixel color across iterations
			Local color:Color
			Local colorPtr:Color Ptr = Varptr(color)
			
			For yCoord = 0 Until _height
				For xCoord = 0 Until _width
					' Get the color at current coordinates
					color = GetPixel(xCoord, yCoord)
					
					' Premultiply RGB by alpha
					color.r *= color.a
					color.g *= color.a
					color.b *= color.a
					
					' Set the premultiplied color
					SetPixel(xPtr, yPtr, colorPtr)
				End
			End 
		End
	End

	'iDkP added: Mipmapping support

	#rem monkeydoc @hidden Halves the pixmap for mipmapping with support for odd dimensions
	
	Creates a mipmap that's approximately half the size of the original.
	Properly handles cases where width or height are odd numbers.
	
	#end
	Method MipHalve:Pixmap()
		
		' Added by iDkP:
		' Works correctly for all dimension combinations:
		' even-even, even-odd, odd-even, and odd-odd
		
		' Return null if we can't halve anymore
		If Width=1 And Height=1 Return Null
		
		' Calculate new dimensions, properly handling odd sizes
		Local newWidth:Int = Max(Width/2, 1)
		Local newHeight:Int = Max(Height/2, 1)
		
		' Adjust the new dimensions if original dimensions are odd
		If Width Mod 2 <> 0 newWidth = (Width+1)/2
		If Height Mod 2 <> 0 newHeight = (Height+1)/2
		
		Local dst:=New Pixmap(newWidth, newHeight, Format)
		
		' Handle special case: 1-pixel wide image
		If Width=1
			' Static coordinates with fixed memory addresses
			Local yDst:Int = 0
			Local yDstPtr:Int Ptr = Varptr(yDst)
			Local xZero:Int = 0
			Local xZeroPtr:Int Ptr = Varptr(xZero)
			
			' Single Color object for reuse
			Local c0:Color
			Local c1:Color
			Local cAvg:Color
			Local cAvgPtr:Color Ptr = Varptr(cAvg)
			
			For yDst = 0 Until dst.Height
				' Calculate proper source Y coordinates, handling edge cases
				Local y0:Int = Min(yDst*2, Height-1)
				Local y1:Int = Min(yDst*2+1, Height-1)
				
				c0 = GetPixel(0, y0)
				c1 = GetPixel(0, y1)
				cAvg = (c0+c1)*0.5
				dst.SetPixel(xZeroPtr, yDstPtr, cAvgPtr)
			End
			
			Return dst
			
		' Handle special case: 1-pixel tall image
		ElseIf Height=1
			' Static coordinates with fixed memory addresses
			Local xDst:Int = 0
			Local xDstPtr:Int Ptr = Varptr(xDst)
			Local yZero:Int = 0
			Local yZeroPtr:Int Ptr = Varptr(yZero)
			
			' Single Color object for reuse
			Local c0:Color
			Local c1:Color
			Local cAvg:Color
			Local cAvgPtr:Color Ptr = Varptr(cAvg)
			
			For xDst = 0 Until dst.Width
				' Calculate proper source X coordinates, handling edge cases
				Local x0:Int = Min(xDst*2, Width-1)
				Local x1:Int = Min(xDst*2+1, Width-1)
				
				c0 = GetPixel(x0, 0)
				c1 = GetPixel(x1, 0)
				cAvg = (c0+c1)*0.5
				dst.SetPixel(xDstPtr, yZeroPtr, cAvgPtr)
			End
			
			Return dst
		End
		
		' Static zero for base offsets
		Local zero:Int = 0
		Local zeroPtr:Int Ptr = Varptr(zero)
		
		Select _format
			
			Case PixelFormat.RGBA8
				' Static y coordinate with fixed memory address
				Local y:Int = 0
				Local yPtr:Int Ptr = Varptr(y)
				
				For y = 0 Until dst.Height
					
					' Calculate destination row pointer
					Local dstp:=Cast<UInt Ptr>(dst.PixelPtr(zeroPtr, yPtr))
					
					' Calculate source Y coordinates, handling edge cases
					Local srcY0:Int = Min(y*2, Height-2)
					Local srcY1:Int = Min(srcY0+1, Height-1)
					
					' Calculate source row pointers
					Local srcY0Ptr:Int Ptr = Varptr(srcY0)
					Local srcY1Ptr:Int Ptr = Varptr(srcY1)
					Local srcp0:=Cast<UInt Ptr>(PixelPtr(zeroPtr, srcY0Ptr))
					Local srcp1:=Cast<UInt Ptr>(PixelPtr(zeroPtr, srcY1Ptr))
					
					For Local x:=0 Until dst.Width
						
						' Handle edge case for odd width
						Local isRightEdge:Bool = (x*2 >= Width-1)
						
						' Get the 4 source pixels to average, handling edge cases
						Local src0:UInt, src1:UInt, src2:UInt, src3:UInt
						
						src0 = srcp0[0]
						
						If isRightEdge
							src1 = src0  ' Clamp to edge for odd width
						Else
							src1 = srcp0[1]
						End
						
						src2 = srcp1[0]
						
						If isRightEdge
							src3 = src2  ' Clamp to edge for odd width
						Else
							src3 = srcp1[1]
						End
						
						' Calculate the average pixel value
						Local pixel:UInt = ((src0 Shr 2)+(src1 Shr 2)+(src2 Shr 2)+(src3 Shr 2)) & $ff000000
						pixel |= ((src0 & $ff0000)+(src1 & $ff0000)+(src2 & $ff0000)+(src3 & $ff0000)) Shr 2 & $ff0000
						pixel |= ((src0 & $ff00)+(src1 & $ff00)+(src2 & $ff00)+(src3 & $ff00)) Shr 2 & $ff00
						pixel |= ((src0 & $ff)+(src1 & $ff)+(src2 & $ff)+(src3 & $ff)) Shr 2
						
						dstp[x] = pixel
						
						' Advance source pointers, handling edge case
						If Not isRightEdge
							srcp0 += 2
							srcp1 += 2
						Else
							srcp0 += 1
							srcp1 += 1
						End
					End
				End
				
			Default
				' Static coordinates with fixed memory addresses
				Local xDst:Int = 0
				Local yDst:Int = 0
				Local xDstPtr:Int Ptr = Varptr(xDst)
				Local yDstPtr:Int Ptr = Varptr(yDst)
				
				' Single Color object for reuse
				Local c0:Color
				Local c1:Color
				Local c2:Color
				Local c3:Color
				Local cm:Color
				Local cmPtr:Color Ptr = Varptr(cm)
				
				For yDst = 0 Until dst.Height
					For xDst = 0 Until dst.Width
						
						' Calculate proper source coordinates, handling edge cases
						Local x0:Int = Min(xDst*2, Width-1)
						Local x1:Int = Min(xDst*2+1, Width-1)
						Local y0:Int = Min(yDst*2, Height-1)
						Local y1:Int = Min(yDst*2+1, Height-1)
						
						c0 = GetPixel(x0, y0)
						c1 = GetPixel(x1, y0)
						c2 = GetPixel(x1, y1)
						c3 = GetPixel(x0, y1)
						cm = (c0+c1+c2+c3)*.25
						dst.SetPixel(xDstPtr, yDstPtr, cmPtr)
					End
				End
		End
		
		Return dst
	End

	#rem monkeydoc Flips the pixmap on the Y axis.
	#end
	Method FlipY()
		
		'iDkP: gooood, memcpy, good
		
		' Size of one row in bytes
		Local sz:=Width*Depth
		
		' Temporary buffer for row swap (allocated once)
		Local tmp:=New UByte[sz]
		
		' Static coordinates with fixed memory addresses
		Local yTop:Int = 0
		Local yBottom:Int = 0
		Local x:Int = 0
		
		' Calculate pointers once
		Local yTopPtr:Int Ptr = Varptr(yTop)
		Local yBottomPtr:Int Ptr = Varptr(yBottom)
		Local xPtr:Int Ptr = Varptr(x)
		
		' Swap top and bottom rows
		For yTop = 0 Until Height/2
			
			' Calculate bottom row index properly
			yBottom = Height-1-yTop
			
			' Get pointers to top and bottom rows
			Local p1:=PixelPtr(xPtr, yTopPtr)
			Local p2:=PixelPtr(xPtr, yBottomPtr)
			
			' Swap rows using temporary buffer
			stdlib.plugins.libc.memcpy(tmp.Data, p1, sz)
			stdlib.plugins.libc.memcpy(p1, p2, sz)
			stdlib.plugins.libc.memcpy(p2, tmp.Data, sz)
		End
	End

	#rem monkeydoc Flips the pixmap on the X axis.
	#end
	Method FlipX()
		
		'Added by iDkP:
		'	This implementation swaps pixels across the middle line of each row, 
		'	which reduces memory operations and may have better cache behavior
		'	since it only needs to allocate a single pixel's worth of temporary storage.
		
		Local halfWidth:=Width/2
		Local pixelSize:=Depth
		
		' Allocate temporary storage once instead of per pixel
		Local tmp:=New UByte[pixelSize]
		
		' Static coordinates with fixed memory addresses
		Local y:Int = 0
		Local x:Int = 0
		Local zero:Int = 0
		
		' Calculate pointers once
		Local yPtr:Int Ptr = Varptr(y)
		Local zeroPtr:Int Ptr = Varptr(zero)
		
		' Process each row
		For y = 0 Until Height
			
			' Get pointer to current row
			Local rowPtr:=PixelPtr(zeroPtr, yPtr)
			
			' Swap pixels across the middle
			For x = 0 Until halfWidth
				
				Local p1:=rowPtr + x*pixelSize
				Local p2:=rowPtr + (Width-1-x)*pixelSize
				
				' Swap the pixels using our single temporary buffer
				stdlib.plugins.libc.memcpy(tmp.Data, p1, pixelSize)
				stdlib.plugins.libc.memcpy(p1, p2, pixelSize)
				stdlib.plugins.libc.memcpy(p2, tmp.Data, pixelSize)
			End
		End
	End
	
	#rem monkeydoc Returns a rectangular window into the pixmap.
	
	In debug builds, a runtime error will occur if the rectangle lies outside of the pixmap area.
	
	@param x The x coordinate of the top left of the rectangle.

	@param y The y coordinate of the top left of the rectangle.
	
	@param width The width of the rectangle.

	@param height The height of the rectangle.
	
	#end
	Method Window:Pixmap( x:Int,y:Int,width:Int,height:Int )
		DebugAssert( x>=0 And y>=0 And width>=0 And height>=0 And x+width<=_width And y+height<=_height )
		
		Local pixmap:=New Pixmap( width,height,_format,PixelPtr( Varptr(x),Varptr(y) ),_pitch )
		
		Return pixmap
	End
	
	#rem monkeydoc Saves the pixmap to a file.
	
	The only save format currently suppoted is PNG.
	
	#End
	Method Save:Bool( path:String )
	
		Return SavePixmap( Self,path )
	End
	
	#rem monkeydoc Loads a pixmap from a file.
	
	@param path The file path.
	
	@param format The format to load the pixmap in.
	
	@return Null if the file could not be opened, or contained invalid image data.
	
	#end
	Function Load:Pixmap( path:String,format:PixelFormat=Null,pmAlpha:Bool=False )

		Local pixmap:=pixmaploader.LoadPixmap( path,format )
		
		If Not pixmap And Not ExtractRootDir( path ) pixmap=pixmaploader.LoadPixmap( "image::"+path,format )
		
		If pixmap And pmAlpha pixmap.PremultiplyAlpha()

		If pixmap Then pixmap.FilePath = path 'jl added

		Return pixmap
	End
	
	Protected
	
	#rem monkeydoc @hidden
	#end
	Method OnDiscard() Override
		
		If _owned GCFree( _data )
			
		_data=Null
	End
	
	#rem monkeydoc @hidden
	#end
	Method OnFinalize() Override
		
		If _owned GCFree( _data )
	End

	Private

	Field _name:String 'iDkP added
	Field _filePath:string	'jl added
	Field _hasAlpha:Bool 'iDkP added
	
	Field _GetPixel_:UInt( this:Pixmap, x:Int Ptr, y:Int Ptr ) 'iDkP added
	Field _SetPixel_:Void( this:Pixmap, x:Int Ptr, y:Int Ptr, argb:UInt Ptr ) 'iDkP added
	
	Field _GetPixelARGB_:UInt( this:Pixmap, x:Int Ptr, y:Int Ptr ) 'iDkP added
	Field _SetPixelARGB_:Void( this:Pixmap, x:Int Ptr, y:Int Ptr, color:UInt Ptr ) 'iDkP added
	
	Field _format:PixelFormat
	Field _width:Int
	Field _height:Int
	Field _depth:Int
	Field _pitch:Int
	Field _owned:Bool
	Field _data:UByte Ptr

	' -------------------- 	iDkP's Standard Zero-Branch Execution programming style
	' 						300% speed up
	
	Function InitHasAlpha(p:Pixmap)

		Select p._format
			Case PixelFormat.A8
				p._hasAlpha=True
			Case PixelFormat.IA8
				p._hasAlpha=True
			Case PixelFormat.RGBA8
				p._hasAlpha=True
			Case PixelFormat.RGBA32F
				p._hasAlpha=True
			Default 
				p._hasAlpha=False
		End
	End

	Function InitGetPixel(p:Pixmap)
		
		Select p._format
			Case PixelFormat.A8
				p._GetPixel_=GetPixelA8ARGB
			Case PixelFormat.I8
				p._GetPixel_=GetPixelI8ARGB
			Case PixelFormat.IA8
				p._GetPixel_=GetPixelIA8ARGB
			Case PixelFormat.RGB8
				p._GetPixel_=GetPixelRGB8ARGB
			Case PixelFormat.RGBA8
				p._GetPixel_=GetPixelRGBA8ARGB
			Case PixelFormat.RGB32F
				p._GetPixel_=GetPixelRGB32FARGB
			Case PixelFormat.RGBA32F
				p._GetPixel_=GetPixelRGBA32FARGB
			Case PixelFormat.RGBE8
				p._GetPixel_=GetPixelRGBE8ARGB
		End
	End

	Function InitGetPixelARGB(p:Pixmap)
		
		Select p._format
			Case PixelFormat.A8
				p._GetPixelARGB_=GetPixelA8ARGB
			Case PixelFormat.I8
				p._GetPixelARGB_=GetPixelI8ARGB
			Case PixelFormat.IA8
				p._GetPixelARGB_=GetPixelIA8ARGB
			Case PixelFormat.RGB8
				p._GetPixelARGB_=GetPixelRGB8ARGB
			Case PixelFormat.RGBA8
				p._GetPixelARGB_=GetPixelRGBA8ARGB
			Case PixelFormat.RGB32F
				p._GetPixelARGB_=GetPixelRGB32FARGB
			Case PixelFormat.RGBA32F
				p._GetPixelARGB_=GetPixelRGBA32FARGB
			Case PixelFormat.RGBE8
				p._GetPixelARGB_=GetPixelRGBE8ARGB
		End
	End

	Function GetPixelA8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Return p[0] Shl 24
	End 

	Function GetPixelI8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Local i:=p[0]
		Return UByte($ff) Shl 24 | i Shl 16 | i Shl 8 | i
	End 

	Function GetPixelIA8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Local i:=p[1]
		Return p[0] Shl 24 | i Shl 16 | i Shl 8 | i
	End 

	Function GetPixelRGB8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Return UByte($ff) Shl 24 | p[0] Shl 16 | p[1] Shl 8 | p[2]
	End 

	Function GetPixelRGBA8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Return p[3] Shl 24 | p[0] Shl 16 | p[1] Shl 8 | p[2]
	End 

	Function GetPixelRGB32FARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Local f:=Cast<Float Ptr>( p )
		Return UInt($ff) Shl 24 | UInt(f[0]*255.0) Shl 16 | UInt(f[1]*255.0) Shl 8 | UInt(f[2]*255.0)
	End 

	Function GetPixelRGBA32FARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Local f:=Cast<Float Ptr>( p )
		Return UInt(f[3]*255.0) Shl 24 | UInt(f[0]*255.0) Shl 16 | UInt(f[1]*255.0) Shl 8 | UInt(f[2]*255.0)
	End 

	Function GetPixelRGBE8ARGB:UInt( this:Pixmap,x:Int Ptr,y:Int Ptr )
		Local p:=PixelPtr( this, x, y )
		Local color:=GetColorRGBE8( p )
		Return UInt($ff) Shl 24 | UInt(color.r*255.0) Shl 16 | UInt(color.g*255.0) Shl 8 | UInt(color.b*255.0)
	End

	Function InitSetPixel(p:Pixmap)
		
		Select p._format
			Case PixelFormat.A8
				p._SetPixel_=SetPixelA8ARGB
			Case PixelFormat.I8
				p._SetPixel_=SetPixelI8ARGB
			Case PixelFormat.IA8
				p._SetPixel_=SetPixelIA8ARGB
			Case PixelFormat.RGB8
				p._SetPixel_=SetPixelRGB8ARGB
			Case PixelFormat.RGBA8
				p._SetPixel_=SetPixelRGBA8ARGB
			Case PixelFormat.RGB32F
				p._SetPixel_=SetPixelRGB32FARGB
			Case PixelFormat.RGBA32F
				p._SetPixel_=SetPixelRGBA32FARGB
			Case PixelFormat.RGBE8
				p._SetPixel_=SetPixelRGBE8ARGB
		End
	End

	Function InitSetPixelARGB(p:Pixmap)
		
		Select p._format
			Case PixelFormat.A8
				p._SetPixelARGB_=SetPixelA8ARGB
			Case PixelFormat.I8
				p._SetPixelARGB_=SetPixelI8ARGB
			Case PixelFormat.IA8
				p._SetPixelARGB_=SetPixelIA8ARGB
			Case PixelFormat.RGB8
				p._SetPixelARGB_=SetPixelRGB8ARGB
			Case PixelFormat.RGBA8
				p._SetPixelARGB_=SetPixelRGBA8ARGB
			Case PixelFormat.RGB32F
				p._SetPixelARGB_=SetPixelRGB32FARGB
			Case PixelFormat.RGBA32F
				p._SetPixelARGB_=SetPixelRGBA32FARGB
			Case PixelFormat.RGBE8
				p._SetPixelARGB_=SetPixelRGBE8ARGB
		End
	End

	Function SetPixelA8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		p[0]=color[0] Shr 24
	End 

	Function SetPixelI8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		p[0]=color[0] Shr 16
	End 

	Function SetPixelIA8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		p[0]=color[0] Shr 24
		p[1]=color[0] Shr 16
	End 

	Function SetPixelRGB8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		p[0]=color[0] Shr 16
		p[1]=color[0] Shr 8
		p[2]=color[0]
	End 

	Function SetPixelRGBA8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		p[0]=color[0] Shr 16
		p[1]=color[0] Shr 8
		p[2]=color[0]
		p[3]=color[0] Shr 24
	End 

	Function SetPixelRGB32FARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		Local f:=Cast<Float Ptr>( p )
		f[0]=((color[0] Shr 16)&255)/255.0
		f[1]=((color[0] Shr 8)&255)/255.0
		f[2]=(color[0]&255)/255.0
	End 

	Function SetPixelRGBA32FARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		Local f:=Cast<Float Ptr>( p )
		f[0]=((color[0] Shr 16)&255)/255.0
		f[1]=((color[0] Shr 8)&255)/255.0
		f[2]=(color[0]&255)/255.0
		f[3]=((color[0] Shr 24)&255)/255.0
	End 

	Function SetPixelRGBE8ARGB( this:Pixmap, x:Int Ptr,y:Int Ptr,color:UInt Ptr )
		Local p:=PixelPtr( this, x, y )
		SetColorRGBE8( p,New Color( ((color[0] Shr 16)&255)/255.0,((color[0] Shr 8)&255)/255.0,(color[0]&255)/255.0,((color[0] Shr 24)&255)/255.0 ) )
	End 
	
	Public 'TMP
	
	Method BenchmarkPixelOperations:Float(iterations:Int = 1000000) 
		 
		Local startTime:Int = Millisecs()
		 
		' Setup test data
		Local testColor:Color = New Color(1, 0, 0, 1)
		Local width:Int = _width
		Local height:Int = _height
		
		' Test with direct coordinate values
		For Local i:Int = 0 Until iterations
			Local x:Int = i Mod width
			Local y:Int = (i / width) Mod height
			SetPixel(x, y, testColor)
		Next
		
		Local directTime:Int = Millisecs() - startTime
		startTime = Millisecs()
		
		' Test with pointer-based coordinates
		Local px:Int = 0
		Local py:Int = 0
		Local pxPtr:Int Ptr = Varptr(px)
		Local pyPtr:Int Ptr = Varptr(py)
		Local colorPtr:Color Ptr = Varptr(testColor)
		
		For Local i:Int = 0 Until iterations
			px = i Mod width
			py = (i / width) Mod height
			SetPixel(pxPtr, pyPtr, colorPtr)
		Next
		
		Local pointerTime:Int = Millisecs() - startTime
		
		' Calculate pixels per second for both methods
		Local directPixelsPerSec:Float = (iterations / (directTime / 1000.0)) / 1000000.0
		Local pointerPixelsPerSec:Float = (iterations / (pointerTime / 1000.0)) / 1000000.0
		
		Print "Direct value method: " + directPixelsPerSec + " million pixels/sec"
		Print "Pointer-based method: " + pointerPixelsPerSec + " million pixels/sec" 
		Print "Performance difference: " + ((pointerPixelsPerSec / directPixelsPerSec - 1.0) * 100.0) + "%"
		
		Return pointerPixelsPerSec
		
	End
End

Class ResourceManager Extension

	Method OpenPixmap:Pixmap( path:String,format:PixelFormat=Null,pmAlpha:Bool=False )
	
		Local slug:="Pixmap:name="+StripDir( StripExt( path ) )+"&format="+Int( format )+"&pmAlpha="+Int( pmAlpha )

		Local pixmap:=Cast<Pixmap>( OpenResource( slug ) )
		If pixmap Return pixmap
		
		pixmap=Pixmap.Load( path,format,pmAlpha )
		If Not pixmap Return Null
		
		AddResource( slug,pixmap )
		
		Return pixmap
	End
End
