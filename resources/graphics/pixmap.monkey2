
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

' Bayer dithering matrix (8x8)
Global BayerMatrix:=New Float[](
	0.0/64.0, 32.0/64.0, 8.0/64.0, 40.0/64.0, 2.0/64.0, 34.0/64.0, 10.0/64.0, 42.0/64.0,
	48.0/64.0, 16.0/64.0, 56.0/64.0, 24.0/64.0, 50.0/64.0, 18.0/64.0, 58.0/64.0, 26.0/64.0,
	12.0/64.0, 44.0/64.0, 4.0/64.0, 36.0/64.0, 14.0/64.0, 46.0/64.0, 6.0/64.0, 38.0/64.0,
	60.0/64.0, 28.0/64.0, 52.0/64.0, 20.0/64.0, 62.0/64.0, 30.0/64.0, 54.0/64.0, 22.0/64.0,
	3.0/64.0, 35.0/64.0, 11.0/64.0, 43.0/64.0, 1.0/64.0, 33.0/64.0, 9.0/64.0, 41.0/64.0,
	51.0/64.0, 19.0/64.0, 59.0/64.0, 27.0/64.0, 49.0/64.0, 17.0/64.0, 57.0/64.0, 25.0/64.0,
	15.0/64.0, 47.0/64.0, 7.0/64.0, 39.0/64.0, 13.0/64.0, 45.0/64.0, 5.0/64.0, 37.0/64.0,
	63.0/64.0, 31.0/64.0, 55.0/64.0, 23.0/64.0, 61.0/64.0, 29.0/64.0, 53.0/64.0, 21.0/64.0)

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
	
'		Print "New pixmap1, width="+width+", height="+height

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
	End
	
	Method New( width:Int,height:Int,format:PixelFormat,data:UByte Ptr,pitch:Int )
	
'		Print "New pixmap2, width="+width+", height="+height

		Local depth:=PixelFormatDepth( format )
		
		_width=width
		_height=height
		_format=format
		_depth=depth
		_data=data
		_pitch=pitch
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
		
		Select _format
		Case PixelFormat.A8,PixelFormat.IA8,PixelFormat.RGBA8
			Return True
		End
		Return False
	End
	
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
	
	#rem monkeydoc Gets a pointer to a pixel in the pixmap.
	
	@param x the x coordinate of the pixel.
	
	@param y the y coordinate of the pixel.
	
	@return the address of the pixel at `x`, `y`.
	
	#end
	Method PixelPtr:UByte Ptr( x:Int,y:Int )
		
		Return _data + y*_pitch + x*_depth
	End
	
	#rem monkeydoc Sets a pixel to a color.
	
	Sets the pixel at `x`, `y` to `pixel`.
	
	In debug builds, a runtime error will occur if the pixel coordinates lie outside of the pixmap area.
	
	@param x The x coordinate of the pixel.
	
	@param y The y coordinate of the pixel.
	
	@param color The color to set the pixel to.
	
	#end
	Method SetPixel( x:Int,y:Int,color:Color )
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
		
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
			Assert( False )
		End
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
	
		Local p:=PixelPtr( x,y )
		
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
	End

	#rem monkeydoc Gets the ARGB color of a pixel.
	
	Get the pixel at `x`, `y` and returns it in ARGB format.

	@param x the x coordinate of the pixel.
	
	@param y the y coordinate of the pixel.
	
	@return the pixel at `x`, `y` in ARGB format.
	
	#end
	Method GetPixelARGB:UInt( x:Int,y:Int )
		DebugAssert( x>=0 And y>=0 And x<_width And y<_height,"Pixmap pixel coordinates out of range" )
	
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
	End
	
	'Optimize!
	'
	#rem monkeydoc Clears the pixmap to a given color.
	
	@param color The color to clear the pixmap to.
	
	#end
	Method Clear( color:Color )

		For Local y:=0 Until _height
			For Local x:=0 Until _width
				SetPixel( x,y,color )
			Next
		Next
	End
	
	#rem monkeydoc Clears the pixmap to an ARGB color.
	
	@param color ARGB color to clear the pixmap to.
	
	#end
	Method ClearARGB( color:UInt )

		For Local y:=0 Until _height
			For Local x:=0 Until _width
				SetPixelARGB( x,y,color )
			Next
		Next
	End

	#rem monkeydoc Creates a copy of the pixmap.

	@return A new pixmap.
	
	#end
	Method Copy:Pixmap()
		
		Local pitch:=Width * Depth
		Local data:=Cast<UByte Ptr>( stdlib.plugins.libc.malloc( pitch * Height ) )
		For Local y:=0 Until Height
			stdlib.plugins.libc.memcpy( data+y*pitch,PixelPtr( 0,y ),pitch )
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
	Method Paste( pixmap:Pixmap,x:Int,y:Int )

		DebugAssert( x>=0 And x+pixmap._width<=_width And y>=0 And y+pixmap._height<=_height )
		
		For Local ty:=0 Until pixmap._height
			For Local tx:=0 Until pixmap._width
				SetPixel( x+tx,y+ty,pixmap.GetPixel( tx,ty ) )
			Next
		Next
	End

	'Optimize!
	'
	#rem monkeydoc Converts the pixmap to a different format.
	
	@param format The pixel format to convert the pixmap to.
	
	@return A new pixmap.
	
	#end
	Method Convert:Pixmap( format:PixelFormat )
		
		Local t:=New Pixmap( _width,_height,format )
		
		If IsFloatPixelFormat( _format ) And Not IsFloatPixelFormat( format )
			For Local y:=0 Until _height
				For Local x:=0 Until _width
					Local c:=GetPixel( x,y )
					c.r=Clamp( c.r,0.0,1.0 )
					c.g=Clamp( c.g,0.0,1.0 )
					c.b=Clamp( c.b,0.0,1.0 )
					c.a=Clamp( c.a,0.0,1.0 )
					t.SetPixel( x,y,c )
				Next
			Next
		Else
			For Local y:=0 Until _height
				For Local x:=0 Until _width
					t.SetPixel( x,y,GetPixel( x,y ) )
				Next
			Next
		Endif
		
		Return t
	End
	
	'Optimize!
	'
	#rem monkeydoc Premultiply pixmap r,g,b components by alpha.
	#end
	Method PremultiplyAlpha()
		
		Select _format
		Case PixelFormat.IA8,PixelFormat.RGBA8,PixelFormat.RGBA16F,PixelFormat.RGBA32F
			
			For Local y:=0 Until _height
				For Local x:=0 Until _width
					Local color:=GetPixel( x,y )
					color.r*=color.a
					color.g*=color.a
					color.b*=color.a
					SetPixel( x,y,color )
				Next
			Next
		End
	End
	
	#rem monkeydoc @hidden Halves the pixmap for mipmapping
	
	Mipmap must be even width and height.
	
	FIXME: Handle funky sizes.
	
	#end
	Method MipHalve:Pixmap()
		
		If Width=1 And Height=1 Return Null
		
		Local dst:=New Pixmap( Max( Width/2,1 ),Max( Height/2,1 ),Format )
		
		If Width=1
			For Local y:=0 Until dst.Height
				Local c0:=GetPixel( 0,y*2 )
				Local c1:=GetPixel( 0,y*2+1 )
				dst.SetPixel( 0,y,(c0+c1)*0.5 )
			Next
			Return dst
		Else If Height=1
			For Local x:=0 Until dst.Width
				Local c0:=GetPixel( x*2,0 )
				Local c1:=GetPixel( x*2+1,0 )
				dst.SetPixel( x,0,(c0+c1)*0.5 )
			Next
			Return dst
		Endif

		Select _format
		Case PixelFormat.RGBA8
			
			For Local y:=0 Until dst.Height
				
				Local dstp:=Cast<UInt Ptr>( dst.PixelPtr( 0,y ) )
				Local srcp0:=Cast<UInt Ptr>( PixelPtr( 0,y*2 ) )
				Local srcp1:=Cast<UInt Ptr>( PixelPtr( 0,y*2+1 ) )
				
				For Local x:=0 Until dst.Width
					
					Local src0:=srcp0[0],src1:=srcp0[1],src2:=srcp1[0],src3:=srcp1[1]
					
					Local dst:=( (src0 Shr 2)+(src1 Shr 2)+(src2 Shr 2)+(src3 Shr 2) ) & $ff000000
					dst|=( (src0 & $ff0000)+(src1 & $ff0000)+(src2 & $ff0000)+(src3 & $ff0000) ) Shr 2 & $ff0000
					dst|=( (src0 & $ff00)+(src1 & $ff00)+(src2 & $ff00)+(src3 & $ff00) ) Shr 2 & $ff00
					dst|=( (src0 & $ff)+(src1 & $ff)+(src2 & $ff)+(src3 & $ff) ) Shr 2
					
					dstp[x]=dst
					
					srcp0+=2
					srcp1+=2
				Next
			Next
		Default
			For Local y:=0 Until dst.Height
				
				For Local x:=0 Until dst.Width
					
					Local c0:=GetPixel( x*2,y*2 )
					Local c1:=GetPixel( x*2+1,y*2 )
					Local c2:=GetPixel( x*2+1,y*2+1 )
					Local c3:=GetPixel( x*2,y*2+1 )
					Local cm:=(c0+c1+c2+c3)*.25
					dst.SetPixel( x,y,cm )
				Next
			Next
		End
		
		Return dst
	End
	
	#rem monkeydoc Flips the pixmap on the Y axis.
	#end
	Method FlipY()
		
		Local sz:=Width*Depth
		
		Local tmp:=New UByte[sz]
		
		For Local y:=0 Until Height/2
			
			Local p1:=PixelPtr( 0,y )
			Local p2:=PixelPtr( 0,Height-1-y )
			
			stdlib.plugins.libc.memcpy( tmp.Data,p1,sz )
			stdlib.plugins.libc.memcpy( p1,p2,sz )
			stdlib.plugins.libc.memcpy( p2,tmp.Data,sz )
		Next
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
		
		Local pixmap:=New Pixmap( width,height,_format,PixelPtr( x,y ),_pitch )
		
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
	
	Field _width:Int
	Field _height:Int
	Field _format:PixelFormat
	Field _depth:Int
	Field _pitch:Int
	Field _owned:Bool
	Field _data:UByte Ptr

	Public
	
	' INTEGRATED EXTENSIONS 
	
	' ------------------------------------------------------
	' Extension methods for Pixmap drawing operations
	' Implementation by iDkP from GaragePixel
	' 2025-03-23 Aida 4
	' ------------------------------------------------------
	'
	' Purpose:
	' Provides extension methods for the stdlib Pixmap class to add advanced drawing
	' operations for shapes, curves, and gradients without requiring sdk_mojo.
	'
	' Functionality:
	' - Drawing filled and outline rectangles, circles, triangles, quads and polygons
	' - Multiple polygon filling techniques (even-odd and winding rules)
	' - Line drawing with adjustable thickness
	' - Bezier curve drawing (quadratic and cubic) with various container inputs
	' - Gradient fills with multiple color stops and reference points
	' - Dithered gradient rendering using Bayer matrix patterns
	' - Alpha-aware blending for all drawing operations
	' - Container-agnostic implementations supporting arrays, lists, and stacks
	'
	' Technical advantages:
	' All operations respect the alpha channel, the polygon filling
	' algorithms implement both even-odd rule and non-zero winding number rule. 
	' The gradient system supports arbitrary reference points and multiple color
	' stops, enabling sophisticated effects usually found only in dedicated graphics
	' libraries. Dithered gradient options provide an aesthetic alternative to smooth
	' gradients while potentially improving performance. This integrated library
	' is really fast! But at this date (23/03/2025, further improvements are planned). 
	'
	' We can even use these functions to create an 2d "old-school" renderer.

	' Sugar for drawing a single pixel with bounds checking
	Method DrawPixel(x:Int, y:Int, argb:UInt, alpha:Float)
		'semi-Sugar
		If x < 0 Or y < 0 Or x >= Width Or y >= Height Return
		
		If alpha >= 1.0
			SetPixelARGB(x, y, argb)
		Else
			Local destPixel:UInt = GetPixelARGB(x, y)
			Local blendedPixel:UInt = BlendPixels(destPixel, argb)
			SetPixelARGB(x, y, blendedPixel)
		End
	End 

	' Sugar for drawing a single pixel, no bounds checking...
	Method DrawPixelFast(x:Int, y:Int, argb:UInt, alpha:Float)
		'semi-Sugar
		
		If alpha >= 1.0 'skipping the blending is always faster than only one test.
			SetPixelARGB(x, y, argb)
		Else
			Local destPixel:UInt = GetPixelARGB(x, y)
			Local blendedPixel:UInt = BlendPixels(destPixel, argb)
			SetPixelARGB(x, y, blendedPixel)
		End
	End 

	' Draw a line on a pixmap
	Method DrawLine(x1:Int, y1:Int, x2:Int, y2:Int, color:Color, thickness:Int=1)
		' Convert color to ARGB format
		Local a:Float = color.a
		Local r:Float = color.r
		Local g:Float = color.g
		Local b:Float = color.b
		
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | (UInt(r * 255.0) Shl 16) | (UInt(g * 255.0) Shl 8) | UInt(b * 255.0)
		
		' Special case for horizontal lines
		If y1 = y2
			Local startX:Int = Min(x1, x2)
			Local endX:Int = Max(x1, x2)
			DrawRect(startX, y1 - thickness/2, endX - startX + 1, thickness, color)
			Return
		End
		
		' Special case for vertical lines
		If x1 = x2
			Local startY:Int = Min(y1, y2)
			Local endY:Int = Max(y1, y2)
			DrawRect(x1 - thickness/2, startY, thickness, endY - startY + 1, color)
			Return
		End
		
		' Use Bresenham's line algorithm for other lines
		Local dx:Int = Abs(x2 - x1)
		Local dy:Int = Abs(y2 - y1)
		Local sx:Int = x1 < x2 ? 1 Else -1
		Local sy:Int = y1 < y2 ? 1 Else -1
		Local err:Int = dx - dy
		
		While True
			' For thick lines, draw multiple pixels
			If thickness <= 1
				DrawPixel(x1, y1, argb, a)
			Else
				Local halfThick:Int = thickness / 2
				For Local oy:Int = -halfThick To halfThick
					For Local ox:Int = -halfThick To halfThick
						If ox*ox + oy*oy <= halfThick*halfThick
							DrawPixel(x1 + ox, y1 + oy, argb, a)
						End
					End
				End
			End
			
			If x1 = x2 And y1 = y2 Exit
			
			Local e2:Int = 2 * err
			If e2 > -dy
				err -= dy
				x1 += sx
			End
			If e2 < dx
				err += dx
				y1 += sy
			End
		Wend
	End

	' ------------------------------------------------------
	' BEZIERS
	' ------------------------------------------------------

	' Draw cubic bezier curve
	Method DrawCubicBezier(x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, color:Color, thickness:Int=1, steps:Int=30)
		If steps < 2 Then steps = 2
		
		Local prevX:Float = Float(x0)
		Local prevY:Float = Float(y0)
		
		For Local i:Int = 1 To steps
			Local t:Float = Float(i) / Float(steps)
			Local t2:Float = t * t
			Local t3:Float = t2 * t
			Local mt:Float = 1.0 - t
			Local mt2:Float = mt * mt
			Local mt3:Float = mt2 * mt
			
			' Cubic Bezier formula
			Local px:Float = mt3 * x0 + 3.0 * mt2 * t * x1 + 3.0 * mt * t2 * x2 + t3 * x3
			Local py:Float = mt3 * y0 + 3.0 * mt2 * t * y1 + 3.0 * mt * t2 * y2 + t3 * y3
			
			DrawLine(Int(prevX), Int(prevY), Int(px), Int(py), color, thickness)
			
			prevX = px
			prevY = py
		End
	End
	
	' Draw cubic bezier from array of control points (requires 4 points)
	Method DrawCubicBezier(points:Vec2f[], color:Color, thickness:Int=1, steps:Int=30)
		If points.Length < 4 Return
		
		DrawCubicBezier(Int(points[0].x), Int(points[0].y), 
		               Int(points[1].x), Int(points[1].y),
		               Int(points[2].x), Int(points[2].y), 
		               Int(points[3].x), Int(points[3].y),
		               color, thickness, steps)
	End
	
	' Draw cubic bezier from List of control points (requires 4 points)
	Method DrawCubicBezier(points:List<Vec2f>, color:Color, thickness:Int=1, steps:Int=30)
		If points.Count() < 4 Return
		
		Local pointsArray:Vec2f[] = New Vec2f[4]
		Local i:Int = 0
		
		For Local point:=Eachin points
			If i < 4
				pointsArray[i] = point
				i += 1
			Else
				Exit
			End
		End
		
		DrawCubicBezier(pointsArray, color, thickness, steps)
	End

	' Draw cubic bezier from Stack of control points (requires 4 points)
	Method DrawCubicBezier(points:Stack<Vec2f>, color:Color, thickness:Int=1, steps:Int=30)
		If points.Length < 4 Return
		
		DrawCubicBezier(Int(points.Get(0).x), Int(points.Get(0).y), 
		               Int(points.Get(1).x), Int(points.Get(1).y),
		               Int(points.Get(2).x), Int(points.Get(2).y), 
		               Int(points.Get(3).x), Int(points.Get(3).y),
		               color, thickness, steps)
	End

	' Draw quadratic bezier curve
	Method DrawQuadraticBezier(x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, color:Color, thickness:Int=1, steps:Int=20)
		If steps < 2 Then steps = 2
		
		Local prevX:Float = Float(x0)
		Local prevY:Float = Float(y0)
		
		For Local i:Int = 1 To steps
			Local t:Float = Float(i) / Float(steps)
			Local mt:Float = 1.0 - t
			
			' Quadratic Bezier formula
			Local px:Float = mt * mt * x0 + 2.0 * mt * t * x1 + t * t * x2
			Local py:Float = mt * mt * y0 + 2.0 * mt * t * y1 + t * t * y2
			
			DrawLine(Int(prevX), Int(prevY), Int(px), Int(py), color, thickness)
			
			prevX = px
			prevY = py
		End
	End

	' Draw quadratic bezier from array of control points (requires 3 points)
	Method DrawQuadraticBezier(points:Vec2f[], color:Color, thickness:Int=1, steps:Int=20)
		If points.Length < 3 Return
		
		DrawQuadraticBezier(Int(points[0].x), Int(points[0].y), 
		                   Int(points[1].x), Int(points[1].y),
		                   Int(points[2].x), Int(points[2].y), 
		                   color, thickness, steps)
	End
	
	' Draw quadratic bezier from List of control points (requires 3 points)
	Method DrawQuadraticBezier(points:List<Vec2f>, color:Color, thickness:Int=1, steps:Int=20)
		Local pCount:=points.Count() 
		If pCount < 3 Return
		
		Local pointsArray:Vec2f[] = New Vec2f[3]
		Local i:Int = 0
		
		For Local point:=Eachin points
			If i < 3
				pointsArray[i] = point
				i += 1
			Else
				Exit
			End
		End
		
		DrawQuadraticBezier(pointsArray, color, thickness, steps)
	End

	' Draw quadratic bezier from Stack of control points (requires 3 points)
	Method DrawQuadraticBezier(points:Stack<Vec2f>, color:Color, thickness:Int=1, steps:Int=20)
		If points.Length < 3 Return
		
		DrawQuadraticBezier(Int(points.Get(0).x), Int(points.Get(0).y), 
		                   Int(points.Get(1).x), Int(points.Get(1).y),
		                   Int(points.Get(2).x), Int(points.Get(2).y), 
		                   color, thickness, steps)
	End

	' ------------------------------------------------------
	' CLASSICAL SHAPES
	' ------------------------------------------------------

	' Draw a filled rectangle on a pixmap with color blending
	Method DrawRect(x:Int, y:Int, width:Int, height:Int, color:Color)
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Convert color to ARGB format
		Local a:Float = color.a
		Local r:Float = color.r
		Local g:Float = color.g
		Local b:Float = color.b
		
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | (UInt(r * 255.0) Shl 16) | (UInt(g * 255.0) Shl 8) | UInt(b * 255.0)
		
		' Fast path for solid color
		If a >= 1.0
			For Local cy:Int = y1 To y2
				For Local cx:Int = x1 To x2
					SetPixelARGB(cx, cy, argb)
				End
			End
			Return
		End
		
		' Alpha blending path
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				Local destPixel:UInt = GetPixelARGB(cx, cy)
				Local blendedPixel:UInt = BlendPixels(destPixel, argb)
				SetPixelARGB(cx, cy, blendedPixel)
			End
		End
	End
	
	' Draw a rectangle outline on a pixmap
	Method DrawRectOutline(x:Int, y:Int, width:Int, height:Int, color:Color, thickness:Int=1)
		' Draw top line
		DrawRect(x, y, width, thickness, color)
		
		' Draw bottom line
		DrawRect(x, y + height - thickness, width, thickness, color)
		
		' Draw left line
		DrawRect(x, y + thickness, thickness, height - thickness * 2, color)
		
		' Draw right line
		DrawRect(x + width - thickness, y + thickness, thickness, height - thickness * 2, color)
	End

	' Draw a filled circle on a pixmap
	Method DrawCircle(centerX:Int, centerY:Int, radius:Int, color:Color)
		' Clip circle to pixmap bounds
		Local x1:Int = Max(0, centerX - radius)
		Local y1:Int = Max(0, centerY - radius)
		Local x2:Int = Min(Width - 1, centerX + radius)
		Local y2:Int = Min(Height - 1, centerY + radius)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Convert color to ARGB format
		Local a:Float = color.a
		Local r:Float = color.r
		Local g:Float = color.g
		Local b:Float = color.b
		
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | (UInt(r * 255.0) Shl 16) | (UInt(g * 255.0) Shl 8) | UInt(b * 255.0)
		
		' Draw circle using midpoint circle algorithm
		Local radiusSq:Int = radius * radius
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Distance from center (squared)
				Local dx:Int = cx - centerX
				Local dy:Int = cy - centerY
				Local distSq:Int = dx * dx + dy * dy
				
				If distSq <= radiusSq
					If a >= 1.0
						SetPixelARGB(cx, cy, argb)
					Else
						Local destPixel:UInt = GetPixelARGB(cx, cy)
						Local blendedPixel:UInt = BlendPixels(destPixel, argb)
						SetPixelARGB(cx, cy, blendedPixel)
					End
				End
			End
		End
	End
	
	' Draw a circle outline on a pixmap
	Method DrawCircleOutline(centerX:Int, centerY:Int, radius:Int, color:Color, thickness:Int=1)
		' Optimized for thin outlines (1-2 pixels)
		If thickness <= 2
			DrawCircleOutlineThin(centerX, centerY, radius, color, thickness)
			Return
		End
		
		' For thicker outlines, draw as the difference between two filled circles
		Local innerRadius:Int = radius - thickness
		If innerRadius < 0 Then innerRadius = 0
		
		' Draw outer circle
		DrawCircle(centerX, centerY, radius, color)
		
		' Erase inner circle if needed
		If innerRadius > 0
			' Create a color with zero alpha but same RGB
			Local eraseColor:Color = New Color(color.r, color.g, color.b, 0.0)
			
			' Draw inner circle with zero alpha
			DrawCircle(centerX, centerY, innerRadius, eraseColor)
		End
	End
	
	' Helper for drawing thin circle outlines efficiently
	Method DrawCircleOutlineThin(centerX:Int, centerY:Int, radius:Int, color:Color, thickness:Int=1)

		' Optimized circle drawing using Bresenham's circle algorithm
		' This avoids the inefficiency of the two-circle approach for thin lines
		
		' Convert color to ARGB format
		Local a:Float = color.a
		Local r:Float = color.r
		Local g:Float = color.g
		Local b:Float = color.b
		
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | (UInt(r * 255.0) Shl 16) | (UInt(g * 255.0) Shl 8) | UInt(b * 255.0)
		
		Local x:Int = 0
		Local y:Int = radius
		Local d:Int = 3 - 2 * radius
		
		While y >= x
			' Draw 8 octants
			For Local t:Int = 0 Until thickness
				DrawPixel(centerX + x, centerY + y - t, argb, a)
				DrawPixel(centerX + y - t, centerY + x, argb, a)
				DrawPixel(centerX + y - t, centerY - x, argb, a)
				DrawPixel(centerX + x, centerY - y + t, argb, a)
				DrawPixel(centerX - x, centerY - y + t, argb, a)
				DrawPixel(centerX - y + t, centerY - x, argb, a)
				DrawPixel(centerX - y + t, centerY + x, argb, a)
				DrawPixel(centerX - x, centerY + y - t, argb, a)
			End
			
			If d < 0
				d += 4 * x + 6
			Else
				d += 4 * (x - y) + 10
				y -= 1
			End
			x += 1
		Wend
	End

	' Draw a filled triangle 
	Method DrawTriangle(x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, color:Color, fillRule:UByte=FILL_EVEN_ODD)

		' Convert vertices to float for more accurate calculations
		Local fx1:Float = Float(x1)
		Local fy1:Float = Float(y1)
		Local fx2:Float = Float(x2)
		Local fy2:Float = Float(y2)
		Local fx3:Float = Float(x3)
		Local fy3:Float = Float(y3)
		
		' Find bounding box with clipping
		Local minX:Int = Max(0, Min(Min(x1, x2), x3))
		Local minY:Int = Max(0, Min(Min(y1, y2), y3))
		Local maxX:Int = Min(Width - 1, Max(Max(x1, x2), x3))
		Local maxY:Int = Min(Height - 1, Max(Max(y1, y2), y3))
		
		' Early exit if triangle is completely outside
		If minX > maxX Or minY > maxY Return
		
		' Convert color to ARGB format
		Local a:Float = color.a
		Local r:Float = color.r
		Local g:Float = color.g
		Local b:Float = color.b
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | (UInt(r * 255.0) Shl 16) | (UInt(g * 255.0) Shl 8) | UInt(b * 255.0)
		
		' Calculate edge functions
		Local e12dx:Float = fx2 - fx1
		Local e12dy:Float = fy2 - fy1
		Local e23dx:Float = fx3 - fx2
		Local e23dy:Float = fy3 - fy2
		Local e31dx:Float = fx1 - fx3
		Local e31dy:Float = fy1 - fy3
		
		' Check if triangle has zero area
		Local area:Float = 0.5 * (e12dx * e31dy - e31dx * e12dy)
		If Abs(area) < 0.00001 Return
		
		' Fill the triangle using half-space method
		For Local y:Int = minY To maxY
			For Local x:Int = minX To maxX
				Local fx:Float = Float(x) + 0.5
				Local fy:Float = Float(y) + 0.5
				
				' Compute edge values
				Local e12:Float = (fx - fx1) * e12dy - (fy - fy1) * e12dx
				Local e23:Float = (fx - fx2) * e23dy - (fy - fy2) * e23dx
				Local e31:Float = (fx - fx3) * e31dy - (fy - fy3) * e31dx
				
				Local inside:Bool = False
				
				If fillRule = FILL_WINDING
					' Non-zero winding rule (all edges must have same sign)
					inside = (e12 >= 0 And e23 >= 0 And e31 >= 0) Or (e12 <= 0 And e23 <= 0 And e31 <= 0)
				Else
					' iDkP:
					' 	Even-odd rule is not really applicable for triangles as they're always convex !!!!!!
					' 	but for consistency we'll use the same approach as polygons :D
					inside = (e12 >= 0 And e23 >= 0 And e31 >= 0) Or (e12 <= 0 And e23 <= 0 And e31 <= 0)
				End
				
				If inside
					If a >= 1.0
						SetPixelARGB(x, y, argb)
					Else
						Local destPixel:UInt = GetPixelARGB(x, y)
						Local blendedPixel:UInt = BlendPixels(destPixel, argb)
						SetPixelARGB(x, y, blendedPixel)
					End
				End
			End
		End
	End

	' Draw triangle outline
	Method DrawTriangleOutline(x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, color:Color, thickness:Int=1)
		DrawLine(x1, y1, x2, y2, color, thickness)
		DrawLine(x2, y2, x3, y3, color, thickness)
		DrawLine(x3, y3, x1, y1, color, thickness)
	End

	' Draw a quad (four-sided polygon)
	Method DrawQuad(x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, x4:Int, y4:Int, color:Color, fillRule:UByte=FILL_EVEN_ODD)
		' Create points array and use DrawPolygon
		Local points:=New Vec2f[](
			New Vec2f(Float(x1), Float(y1)),
			New Vec2f(Float(x2), Float(y2)),
			New Vec2f(Float(x3), Float(y3)),
			New Vec2f(Float(x4), Float(y4)))
		
		DrawPolygon(points, color, fillRule)
	End
	
	' Draw quad outline
	Method DrawQuadOutline(x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, x4:Int, y4:Int, color:Color, thickness:Int=1)
		DrawLine(x1, y1, x2, y2, color, thickness)
		DrawLine(x2, y2, x3, y3, color, thickness)
		DrawLine(x3, y3, x4, y4, color, thickness)
		DrawLine(x4, y4, x1, y1, color, thickness)
	End

	' Draw polygon from array of points
	Method DrawPolygon(points:Vec2f[], color:Color, fillRule:UByte=FILL_EVEN_ODD)
		If points.Length < 3 Return
		
		' Find bounding box
		Local minX:Float = points[0].x
		Local minY:Float = points[0].y
		Local maxX:Float = minX
		Local maxY:Float = minY
		
		For Local i:Int = 1 Until points.Length
			minX = Min(minX, points[i].x)
			minY = Min(minY, points[i].y)
			maxX = Max(maxX, points[i].x)
			maxY = Max(maxY, points[i].y)
		End
		
		' Clip bounding box to pixmap
		Local startX:Int = Max(0, Int(minX))
		Local startY:Int = Max(0, Int(minY))
		Local endX:Int = Min(Width - 1, Int(maxX + 0.999))
		Local endY:Int = Min(Height - 1, Int(maxY + 0.999))
		
		' Early exit if polygon is completely outside
		If startX > endX Or startY > endY Return
		
		' Convert color to ARGB format
		Local a:Float = color.a
		Local argb:UInt = (UInt(a * 255.0) Shl 24) | 
		                  (UInt(color.r * 255.0) Shl 16) | 
		                  (UInt(color.g * 255.0) Shl 8) | 
		                  UInt(color.b * 255.0)
		
		' Process the polygon using requested fill rule
		If fillRule = FILL_EVEN_ODD
			' Even-odd rule implementation
			For Local y:Int = startY To endY
				For Local x:Int = startX To endX
					Local inside:Bool = False
					Local j:Int = points.Length - 1
					
					For Local i:Int = 0 Until points.Length
						' Check if the ray intersects with the edge
						If ((points[i].y > y) <> (points[j].y > y)) And 
						   (x < points[i].x + (points[j].x - points[i].x) * 
						   (y - points[i].y) / (points[j].y - points[i].y))
							inside = Not inside
						End
						j = i
					End
					
					If inside
						If a >= 1.0
							SetPixelARGB(x, y, argb)
						Else
							Local destPixel:UInt = GetPixelARGB(x, y)
							Local blendedPixel:UInt = BlendPixels(destPixel, argb)
							SetPixelARGB(x, y, blendedPixel)
						End
					End
				End
			End
		Else
			' Non-zero winding rule implementation
			For Local y:Int = startY To endY
				For Local x:Int = startX To endX
					Local winding:Int = 0
					Local j:Int = points.Length - 1
					
					For Local i:Int = 0 Until points.Length
						If points[i].y <= y
							If points[j].y > y And IsLeftOf(points[i], points[j], x, y)
								winding += 1
							End
						Else
							If points[j].y <= y And IsLeftOf(points[j], points[i], x, y)
								winding -= 1
							End
						End
						j = i
					End
					
					If winding <> 0
						If a >= 1.0
							SetPixelARGB(x, y, argb)
						Else
							Local destPixel:UInt = GetPixelARGB(x, y)
							Local blendedPixel:UInt = BlendPixels(destPixel, argb)
							SetPixelARGB(x, y, blendedPixel)
						End
					End
				End
			End
		End
	End

	' Draw polygon from List of points
	Method DrawPolygon(points:List<Vec2f>, color:Color, fillRule:UByte=FILL_EVEN_ODD)
		local pcount:=points.Count()
		If pcount < 3 Return
		
		' Convert list to array for processing

		Local pointsArray:Vec2f[] = New Vec2f[pcount]
		Local i:Int = 0
		
		For Local point:= Eachin points
			pointsArray[i] = point
			i += 1
		End
		
		DrawPolygon(pointsArray, color, fillRule)
	End

	' Draw polygon from Stack of points
	Method DrawPolygon(points:Stack<Vec2f>, color:Color, fillRule:UByte=FILL_EVEN_ODD)
		If points.Length < 3 Return
		
		' Convert stack to array for processing
		Local pointsArray:Vec2f[] = New Vec2f[points.Length]
		
		For Local i:Int = 0 Until points.Length
			pointsArray[i] = points.Get(i)
		End
		
		DrawPolygon(pointsArray, color, fillRule)
	End

	' Draw polygon outline from array of points
	Method DrawPolygonOutline(points:Vec2f[], color:Color, thickness:Int=1)
		If points.Length < 3 Return
		
		For Local i:Int = 0 Until points.Length - 1
			DrawLine(Int(points[i].x), Int(points[i].y), 
			        Int(points[i+1].x), Int(points[i+1].y), 
			        color, thickness)
		End
		
		' Close the polygon
		DrawLine(Int(points[points.Length-1].x), Int(points[points.Length-1].y), 
		        Int(points[0].x), Int(points[0].y), 
		        color, thickness)
	End
	
	' Draw polygon outline from List of points
	Method DrawPolygonOutline(points:List<Vec2f>, color:Color, thickness:Int=1)
		Local pCount:=points.Count() 		
		If pCount < 3 Return
		
		Local prev:Vec2f = Null
		Local first:Vec2f = Null
		
		For Local point:=Eachin points
			If prev = Null
				prev = point
				first = point
				Continue
			End
			
			DrawLine(Int(prev.x), Int(prev.y), Int(point.x), Int(point.y), color, thickness)
			prev = point
		End
		
		' Close the polygon
		DrawLine(Int(prev.x), Int(prev.y), Int(first.x), Int(first.y), color, thickness)
	End

	' Draw polygon outline from Stack of points
	Method DrawPolygonOutline(points:Stack<Vec2f>, color:Color, thickness:Int=1)
		If points.Length < 3 Return
		
		For Local i:Int = 0 Until points.Length - 1
			DrawLine(Int(points.Get(i).x), Int(points.Get(i).y), 
			        Int(points.Get(i+1).x), Int(points.Get(i+1).y), 
			        color, thickness)
		End
		
		' Close the polygon
		DrawLine(Int(points.Get(points.Length-1).x), Int(points.Get(points.Length-1).y), 
		        Int(points.Get(0).x), Int(points.Get(0).y), 
		        color, thickness)
	End
	
	' ------------------------------------------------------
	' GRADIENT DRAWING FUNCTIONS
	' ------------------------------------------------------

	' Draw linear gradient rectangle
	Method DrawGradientRect(x:Int, y:Int, width:Int, height:Int, colorStart:Color, colorEnd:Color, vertical:Bool=False)
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Component values for interpolation
		Local r1:Float = colorStart.r
		Local g1:Float = colorStart.g
		Local b1:Float = colorStart.b
		Local a1:Float = colorStart.a
		
		Local r2:Float = colorEnd.r
		Local g2:Float = colorEnd.g
		Local b2:Float = colorEnd.b
		Local a2:Float = colorEnd.a
		
		If vertical
			' Vertical gradient
			For Local cy:Int = y1 To y2
				' Interpolation factor
				Local t:Float = Float(cy - y1) / Float(y2 - y1)
				If y2 = y1 Then t = 0
				
				Local r:Float = Lerp(r1, r2, t)
				Local g:Float = Lerp(g1, g2, t)
				Local b:Float = Lerp(b1, b2, t)
				Local a:Float = Lerp(a1, a2, t)
				
				Local color:Color = New Color(r, g, b, a)
				
				For Local cx:Int = x1 To x2
					DrawPixel(cx, cy, ColorToARGB(color), a)
				End
			End
		Else
			' Horizontal gradient
			For Local cx:Int = x1 To x2
				' Interpolation factor
				Local t:Float = Float(cx - x1) / Float(x2 - x1)
				If x2 = x1 Then t = 0
				
				Local r:Float = Lerp(r1, r2, t)
				Local g:Float = Lerp(g1, g2, t)
				Local b:Float = Lerp(b1, b2, t)
				Local a:Float = Lerp(a1, a2, t)
				
				Local color:Color = New Color(r, g, b, a)
				
				For Local cy:Int = y1 To y2
					DrawPixel(cx, cy, ColorToARGB(color), a)
				End
			End
		End
	End
	
	' Draw rectangle with gradient between two arbitrary points
	Method DrawGradientRect(x:Int, y:Int, width:Int, height:Int, colorStart:Color, colorEnd:Color, 
	                           pointStart:Vec2f, pointEnd:Vec2f)
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Calculate vector between gradient points
		Local dx:Float = pointEnd.x - pointStart.x
		Local dy:Float = pointEnd.y - pointStart.y
		Local gradientLength:Float = Sqrt(dx * dx + dy * dy)
		
		' Normalize direction vector if possible
		If gradientLength > 0.0001
			dx /= gradientLength
			dy /= gradientLength
		Else
			dx = 0
			dy = 0
		End
		
		' Component values for interpolation
		Local r1:Float = colorStart.r
		Local g1:Float = colorStart.g
		Local b1:Float = colorStart.b
		Local a1:Float = colorStart.a
		
		Local r2:Float = colorEnd.r
		Local g2:Float = colorEnd.g
		Local b2:Float = colorEnd.b
		Local a2:Float = colorEnd.a
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Project the current point onto the gradient line
				Local vx:Float = Float(cx) - pointStart.x
				Local vy:Float = Float(cy) - pointStart.y
				
				' Dot product gives position along the gradient line
				Local projection:Float = vx * dx + vy * dy
				
				' Normalize to 0-1 range
				Local t:Float = projection / gradientLength
				t = Clamp(t, 0.0, 1.0)
				
				' Interpolate color
				Local r:Float = Lerp(r1, r2, t)
				Local g:Float = Lerp(g1, g2, t)
				Local b:Float = Lerp(b1, b2, t)
				Local a:Float = Lerp(a1, a2, t)
				
				Local color:Color = New Color(r, g, b, a)
				DrawPixel(cx, cy, ColorToARGB(color), a)
			End
		End
	End
	
	' Draw dithered gradient rectangle using Bayer matrix
	Method DrawDitheredGradientRect(x:Int, y:Int, width:Int, height:Int, colorStart:Color, colorEnd:Color, vertical:Bool=False)
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Calculate gradient position (0.0 to 1.0)
				Local t:Float
				If vertical
					t = Float(cy - y1) / Float(y2 - y1)
					If y2 = y1 Then t = 0
				Else
					t = Float(cx - x1) / Float(x2 - x1)
					If x2 = x1 Then t = 0
				End
				
				' Get bayer matrix threshold value at this pixel
				Local bayer:Float = BayerMatrix[(cy Mod 8) * 8 + (cx Mod 8)]
				
				' Choose color based on threshold comparison
				Local color:Color
				If t < bayer
					color = colorStart
				Else
					color = colorEnd
				End
				
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			End
		End
	End
	
	' Draw dithered gradient rectangle with arbitrary points
	Method DrawDitheredGradientRect(	x:Int, y:Int, width:Int, height:Int, colorStart:Color, colorEnd:Color, 
	                                    pointStart:Vec2f, pointEnd:Vec2f)
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Calculate vector between gradient points
		Local dx:Float = pointEnd.x - pointStart.x
		Local dy:Float = pointEnd.y - pointStart.y
		Local gradientLength:Float = Sqrt(dx * dx + dy * dy)
		
		' Normalize direction vector if possible
		If gradientLength > 0.0001
			dx /= gradientLength
			dy /= gradientLength
		Else
			dx = 0
			dy = 0
		End
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Project the current point onto the gradient line
				Local vx:Float = Float(cx) - pointStart.x
				Local vy:Float = Float(cy) - pointStart.y
				
				' Dot product gives position along the gradient line
				Local projection:Float = vx * dx + vy * dy
				
				' Normalize to 0-1 range
				Local t:Float = projection / gradientLength
				t = Clamp(t, 0.0, 1.0)
				
				' Get bayer matrix threshold value at this pixel
				Local bayer:Float = BayerMatrix[(cy Mod 8) * 8 + (cx Mod 8)]
				
				' Choose color based on threshold comparison
				Local color:Color
				If t < bayer
					color = colorStart
				Else
					color = colorEnd
				End
				
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			End
		End
	End
	
	' Draw a gradient circle
	Method DrawGradientCircle(centerX:Int, centerY:Int, radius:Int, colorInner:Color, colorOuter:Color)
		' Clip circle to pixmap bounds
		Local x1:Int = Max(0, centerX - radius)
		Local y1:Int = Max(0, centerY - radius)
		Local x2:Int = Min(Width - 1, centerX + radius)
		Local y2:Int = Min(Height - 1, centerY + radius)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Draw circle using midpoint circle algorithm with gradient
		Local radiusSq:Float = Float(radius * radius)
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Distance from center (squared)
				Local dx:Float = Float(cx - centerX)
				Local dy:Float = Float(cy - centerY)
				Local distSq:Float = dx * dx + dy * dy
				
				If distSq <= radiusSq
					' Calculate gradient factor (0 at center, 1 at edge)
					Local t:Float = Sqrt(distSq) / Float(radius)
					t = Clamp(t, 0.0, 1.0)
					
					' Interpolate color
					Local color:Color = LerpColor(colorInner, colorOuter, t)
					
					DrawPixel(cx, cy, ColorToARGB(color), color.a)
				End
			End
		End
	End
	
	' Draw a dithered gradient circle
	Method DrawDitheredGradientCircle(centerX:Int, centerY:Int, radius:Int, colorInner:Color, colorOuter:Color)
		' Clip circle to pixmap bounds
		Local x1:Int = Max(0, centerX - radius)
		Local y1:Int = Max(0, centerY - radius)
		Local x2:Int = Min(Width - 1, centerX + radius)
		Local y2:Int = Min(Height - 1, centerY + radius)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Draw circle using midpoint circle algorithm with gradient
		Local radiusSq:Float = Float(radius * radius)
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Distance from center (squared)
				Local dx:Float = Float(cx - centerX)
				Local dy:Float = Float(cy - centerY)
				Local distSq:Float = dx * dx + dy * dy
				
				If distSq <= radiusSq
					' Calculate gradient factor (0 at center, 1 at edge)
					Local t:Float = Sqrt(distSq) / Float(radius)
					t = Clamp(t, 0.0, 1.0)
					
					' Get bayer matrix threshold
					Local bayer:Float = BayerMatrix[(cy Mod 8) * 8 + (cx Mod 8)]
					
					' Choose color based on threshold comparison
					Local color:Color
					If t < bayer
						color = colorInner
					Else
						color = colorOuter
					End
					
					DrawPixel(cx, cy, ColorToARGB(color), color.a)
				End
			End
		End
	End

	' Draw a gradient triangle
	Method DrawGradientTriangle(	x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, 
	                               	color1:Color, color2:Color, color3:Color)
		' Convert vertices to float for more accurate calculations
		Local fx1:Float = Float(x1)
		Local fy1:Float = Float(y1)
		Local fx2:Float = Float(x2)
		Local fy2:Float = Float(y2)
		Local fx3:Float = Float(x3)
		Local fy3:Float = Float(y3)
		
		' Find bounding box with clipping
		Local minX:Int = Max(0, Min(Min(x1, x2), x3))
		Local minY:Int = Max(0, Min(Min(y1, y2), y3))
		Local maxX:Int = Min(Width - 1, Max(Max(x1, x2), x3))
		Local maxY:Int = Min(Height - 1, Max(Max(y1, y2), y3))
		
		' Early exit if triangle is completely outside
		If minX > maxX Or minY > maxY Return
		
		' Calculate edge functions
		Local e12dx:Float = fx2 - fx1
		Local e12dy:Float = fy2 - fy1
		Local e23dx:Float = fx3 - fx2
		Local e23dy:Float = fy3 - fy2
		Local e31dx:Float = fx1 - fx3
		Local e31dy:Float = fy1 - fy3
		
		' Check if triangle has zero area
		Local area:Float = 0.5 * (e12dx * e31dy - e31dx * e12dy)
		If Abs(area) < 0.00001 Return
		
		Local invArea:Float = 1.0 / (2.0 * area)
		
		' Fill the triangle using barycentric coordinates for color interpolation
		For Local y:Int = minY To maxY
			For Local x:Int = minX To maxX
				Local fx:Float = Float(x) + 0.5
				Local fy:Float = Float(y) + 0.5
				
				' Compute barycentric coordinates
				Local w1:Float = ((fy2 - fy3) * (fx - fx3) + (fx3 - fx2) * (fy - fy3)) * invArea
				Local w2:Float = ((fy3 - fy1) * (fx - fx3) + (fx1 - fx3) * (fy - fy3)) * invArea
				Local w3:Float = 1.0 - w1 - w2
				
				' If point is inside the triangle
				If w1 >= 0 And w2 >= 0 And w3 >= 0
					' Interpolate colors using barycentric coordinates
					Local r:Float = w1 * color1.r + w2 * color2.r + w3 * color3.r
					Local g:Float = w1 * color1.g + w2 * color2.g + w3 * color3.g
					Local b:Float = w1 * color1.b + w2 * color2.b + w3 * color3.b
					Local a:Float = w1 * color1.a + w2 * color2.a + w3 * color3.a
					
					Local color:Color = New Color(r, g, b, a)
					DrawPixel(x, y, ColorToARGB(color), a)
				End
			End
		End
	End
	
	' Draw a gradient line between two points
	Method DrawGradientLine(x1:Int, y1:Int, x2:Int, y2:Int, color1:Color, color2:Color, thickness:Int=1)
		' Special case for horizontal lines
		If y1 = y2
			Local startX:Int = Min(x1, x2)
			Local endX:Int = Max(x1, x2)
			
			For Local x:Int = startX To endX
				Local t:Float = Float(x - startX) / Float(endX - startX)
				If endX = startX Then t = 0
				
				Local color:Color = LerpColor(color1, color2, t)
				
				For Local ty:Int = -thickness/2 To thickness/2
					Local y:Int = y1 + ty
					If y >= 0 And y < Height
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
			Return
		End
		
		' Special case for vertical lines
		If x1 = x2
			Local startY:Int = Min(y1, y2)
			Local endY:Int = Max(y1, y2)
			
			For Local y:Int = startY To endY
				Local t:Float = Float(y - startY) / Float(endY - startY)
				If endY = startY Then t = 0
				
				Local color:Color = LerpColor(color1, color2, t)
				
				For Local tx:Int = -thickness/2 To thickness/2
					Local x:Int = x1 + tx
					If x >= 0 And x < Width
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
			Return
		End
		
		' Use Bresenham's line algorithm for other lines with gradient color
		Local dx:Int = Abs(x2 - x1)
		Local dy:Int = Abs(y2 - y1)
		Local sx:Int = x1 < x2 ? 1 Else -1
		Local sy:Int = y1 < y2 ? 1 Else -1
		Local err:Int = dx - dy
		
		' Calculate line length for interpolation
		Local lineLength:Float = Sqrt(Float(dx * dx + dy * dy))
		Local cx:Int = x1
		Local cy:Int = y1
		Local distanceTraveled:Float = 0
		
		While True
			' Calculate how far along the line we are
			Local t:Float = distanceTraveled / lineLength
			Local color:Color = LerpColor(color1, color2, t)
			
			' For thick lines, draw multiple pixels
			If thickness <= 1
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			Else
				Local halfThick:Int = thickness / 2
				For Local oy:Int = -halfThick To halfThick
					For Local ox:Int = -halfThick To halfThick
						If ox*ox + oy*oy <= halfThick*halfThick
							DrawPixel(cx + ox, cy + oy, ColorToARGB(color), color.a)
						End
					End
				End
			End
			
			If cx = x2 And cy = y2 Exit
			
			Local e2:Int = 2 * err
			Local movedX:Bool = False
			Local movedY:Bool = False
			
			If e2 > -dy
				err -= dy
				cx += sx
				movedX = True
			End
			
			If e2 < dx
				err += dx
				cy += sy
				movedY = True
			End
			
			' Update distance traveled - use Pythagorean for diagonal movement
			If movedX And movedY
				distanceTraveled += 1.414213562  ' sqrt(2)
			Else
				distanceTraveled += 1.0
			End
		Wend
	End
	' Draw a multi-color gradient along a line using color points
	Method DrawMultiGradientLine(x1:Int, y1:Int, x2:Int, y2:Int, colors:Color[], positions:Float[], thickness:Int=1)
		If colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		' Check if positions array is correctly normalized
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1
				Return ' Invalid positions array
			End
			If i > 0 And positions[i] < positions[i-1]
				Return ' Positions must be ascending
			End
		End
		
		' Special cases for horizontal and vertical lines
		If y1 = y2 Or x1 = x2
			DrawMultiGradientLineSimple(x1, y1, x2, y2, colors, positions, thickness)
			Return
		End
		
		' Use Bresenham's algorithm with multi-color gradients
		Local dx:Int = Abs(x2 - x1)
		Local dy:Int = Abs(y2 - y1)
		Local sx:Int = x1 < x2 ? 1 Else -1
		Local sy:Int = y1 < y2 ? 1 Else -1
		Local err:Int = dx - dy
		
		' Calculate line length
		Local lineLength:Float = Sqrt(Float(dx * dx + dy * dy))
		Local cx:Int = x1
		Local cy:Int = y1
		Local distanceTraveled:Float = 0
		
		While True
			' Calculate how far along the line we are (0 to 1)
			Local t:Float = distanceTraveled / lineLength
			
			' Find the color segment we're in
			Local segmentStart:Int = 0
			
			For Local i:Int = 1 Until positions.Length
				If t <= positions[i]
					segmentStart = i - 1
					Exit
				End
			End
			
			' If we're at the end, use the last segment
			If segmentStart >= positions.Length - 1
				segmentStart = positions.Length - 2
			End
			
			Local segmentEnd:Int = segmentStart + 1
			
			' Calculate local position within this segment
			Local segmentPos:Float = (t - positions[segmentStart]) / 
			                        (positions[segmentEnd] - positions[segmentStart])
			
			Local color:Color = LerpColor(colors[segmentStart], colors[segmentEnd], segmentPos)
			
			' For thick lines, draw multiple pixels
			If thickness <= 1
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			Else
				Local halfThick:Int = thickness / 2
				For Local oy:Int = -halfThick To halfThick
					For Local ox:Int = -halfThick To halfThick
						If ox*ox + oy*oy <= halfThick*halfThick
							DrawPixel(cx + ox, cy + oy, ColorToARGB(color), color.a)
						End
					End
				End
			End
			
			If cx = x2 And cy = y2 Exit
			
			Local e2:Int = 2 * err
			Local movedX:Bool = False
			Local movedY:Bool = False
			
			If e2 > -dy
				err -= dy
				cx += sx
				movedX = True
			End
			
			If e2 < dx
				err += dx
				cy += sy
				movedY = True
			End
			
			' Update distance traveled
			If movedX And movedY
				distanceTraveled += 1.414213562  ' sqrt(2)
			Else
				distanceTraveled += 1.0
			End
		Wend
	End
	
	' Helper for simpler multi-gradient rendering of horizontal/vertical lines
	Method DrawMultiGradientLineSimple(	x1:Int, y1:Int, x2:Int, y2:Int, 
										colors:Color[], positions:Float[], thickness:Int)
		If y1 = y2
			' Horizontal line
			Local startX:Int = Min(x1, x2)
			Local endX:Int = Max(x1, x2)
			Local width:Int = endX - startX + 1
			
			For Local x:Int = startX To endX
				Local t:Float = Float(x - startX) / Float(width - 1)
				If width <= 1 Then t = 0
				
				' Find color segment
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				' Calculate segment position
				Local segmentPos:Float = (t - positions[segmentStart]) / 
				                        (positions[segmentEnd] - positions[segmentStart])
				
				Local color:Color = LerpColor(colors[segmentStart], colors[segmentEnd], segmentPos)
				
				For Local ty:Int = -thickness/2 To thickness/2
					Local y:Int = y1 + ty
					If y >= 0 And y < Height
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
		Else
			' Vertical line
			Local startY:Int = Min(y1, y2)
			Local endY:Int = Max(y1, y2)
			Local height:Int = endY - startY + 1
			
			For Local y:Int = startY To endY
				Local t:Float = Float(y - startY) / Float(height - 1)
				If height <= 1 Then t = 0
				
				' Find color segment
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				' Calculate segment position
				Local segmentPos:Float = (t - positions[segmentStart]) / 
				                        (positions[segmentEnd] - positions[segmentStart])
				
				Local color:Color = LerpColor(colors[segmentStart], colors[segmentEnd], segmentPos)
				
				For Local tx:Int = -thickness/2 To thickness/2
					Local x:Int = x1 + tx
					If x >= 0 And x < Width
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
		End
	End
	
	' Draw multi-color gradient between arbitrary points
	Method DrawMultiGradientLine(startPoint:Vec2f, endPoint:Vec2f, colors:Color[], positions:Float[], thickness:Int=1)
		DrawMultiGradientLine(Int(startPoint.x), Int(startPoint.y), Int(endPoint.x), Int(endPoint.y), colors, positions, thickness)
	End
	
	' Draw multi-color gradient from List of colors and positions
	Method DrawMultiGradientLine(x1:Int, y1:Int, x2:Int, y2:Int, colors:List<Color>, positions:List<Float>, thickness:Int=1)
		If colors.Count() < 2 Or positions.Count() < 2 Or colors.Count() <> positions.Count() Return
		
		' Convert lists to arrays
		Local colorsArray:Color[] = New Color[colors.Count()]
		Local positionsArray:Float[] = New Float[positions.Count()]
		Local i:Int = 0
		
		Local colorIter:=colors.All()
		Local posIter:=positions.All()
		
		While Not colorIter.AtEnd And Not posIter.AtEnd
			colorsArray[i] = colorIter.Current
			positionsArray[i] = posIter.Current
			i += 1
			colorIter.Bump()
			posIter.Bump()
		Wend
		
		DrawMultiGradientLine(x1, y1, x2, y2, colorsArray, positionsArray, thickness)
	End
	
	' Draw multi-color gradient from Stacks of colors and positions
	Method DrawMultiGradientLine(x1:Int, y1:Int, x2:Int, y2:Int, colors:Stack<Color>, positions:Stack<Float>, thickness:Int=1)
		If colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		' Convert stacks to arrays
		Local colorsArray:Color[] = New Color[colors.Length]
		Local positionsArray:Float[] = New Float[positions.Length]
		
		For Local i:Int = 0 Until colors.Length
			colorsArray[i] = colors.Get(i)
			positionsArray[i] = positions.Get(i)
		End
		
		DrawMultiGradientLine(x1, y1, x2, y2, colorsArray, positionsArray, thickness)
	End

	' Draw a cubic bezier curve with color gradient
	Method DrawGradientCubicBezier(		x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, 
	                                   	colorStart:Color, colorEnd:Color, thickness:Int=1, steps:Int=30)
		If steps < 2 Then steps = 2
		
		Local prevX:Float = Float(x0)
		Local prevY:Float = Float(y0)
		Local prevColor:Color = colorStart
		
		For Local i:Int = 1 To steps - 1
			Local t:Float = Float(i) / Float(steps)
			Local t2:Float = t * t
			Local t3:Float = t2 * t
			Local mt:Float = 1.0 - t
			Local mt2:Float = mt * mt
			Local mt3:Float = mt2 * mt
			
			' Cubic Bezier formula
			Local px:Float = mt3 * x0 + 3.0 * mt2 * t * x1 + 3.0 * mt * t2 * x2 + t3 * x3
			Local py:Float = mt3 * y0 + 3.0 * mt2 * t * y1 + 3.0 * mt * t2 * y2 + t3 * y3
			
			Local currentColor:Color = LerpColor(colorStart, colorEnd, t)
			
			DrawGradientLine(Int(prevX), Int(prevY), Int(px), Int(py), prevColor, currentColor, thickness)
			
			prevX = px
			prevY = py
			prevColor = currentColor
		End
	End
	
	' Draw a cubic bezier curve with multi-color gradient
	Method DrawMultiGradientCubicBezier(	x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, x3:Int, y3:Int, 
	                                        colors:Color[], positions:Float[], thickness:Int=1, steps:Int=30)
		If steps < 2 Or colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		' Check if positions array is correctly normalized
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1 Return
			If i > 0 And positions[i] < positions[i-1] Return
		End
		
		' Points along the curve
		Local points:Float[] = New Float[steps * 2]
		
		' Calculate all points along the curve first
		For Local i:Int = 0 To steps - 1
			Local t:Float = Float(i) / Float(steps)
			Local t2:Float = t * t
			Local t3:Float = t2 * t
			Local mt:Float = 1.0 - t
			Local mt2:Float = mt * mt
			Local mt3:Float = mt2 * mt
			
			' Cubic Bezier formula
			points[i*2] = mt3 * x0 + 3.0 * mt2 * t * x1 + 3.0 * mt * t2 * x2 + t3 * x3
			points[i*2+1] = mt3 * y0 + 3.0 * mt2 * t * y1 + 3.0 * mt * t2 * y2 + t3 * y3
		End
		
		' Draw segments with gradient colors
		For Local i:Int = 0 Until steps - 1
			Local t1:Float = Float(i) / Float(steps)
			Local t2:Float = Float(i+1) / Float(steps)
			
			' Find colors at these points
			Local color1:Color = GetColorAtPosition(colors, positions, t1)
			Local color2:Color = GetColorAtPosition(colors, positions, t2)
			
			DrawGradientLine(Int(points[i*2]), Int(points[i*2+1]), 
			                Int(points[(i+1)*2]), Int(points[(i+1)*2+1]), 
			                color1, color2, thickness)
		End
	End
	
	' Draw a quadratic bezier curve with color gradient
	Method DrawGradientQuadraticBezier(		x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, 
	                                       	colorStart:Color, colorEnd:Color, thickness:Int=1, steps:Int=20)
		If steps < 2 Then steps = 2
		
		Local prevX:Float = Float(x0)
		Local prevY:Float = Float(y0)
		Local prevColor:Color = colorStart
		
		For Local i:Int = 1 To steps - 1
			Local t:Float = Float(i) / Float(steps)
			Local mt:Float = 1.0 - t
			
			' Quadratic Bezier formula
			Local px:Float = mt * mt * x0 + 2.0 * mt * t * x1 + t * t * x2
			Local py:Float = mt * mt * y0 + 2.0 * mt * t * y1 + t * t * y2
			
			Local currentColor:Color = LerpColor(colorStart, colorEnd, t)
			
			DrawGradientLine(Int(prevX), Int(prevY), Int(px), Int(py), prevColor, currentColor, thickness)
			
			prevX = px
			prevY = py
			prevColor = currentColor
		End
	End
	
	' Draw a quadratic bezier curve with multi-color gradient
	Method DrawMultiGradientQuadraticBezier(	x0:Int, y0:Int, x1:Int, y1:Int, x2:Int, y2:Int, 
	                                           	colors:Color[], positions:Float[], thickness:Int=1, steps:Int=20)
	                                           
		If steps < 2 Or colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		' Check position array validity
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1 Return
			If i > 0 And positions[i] < positions[i-1] Return
		End
		
		' Points along the curve
		Local points:Float[] = New Float[steps * 2]
		
		' Calculate all points along the curve first
		For Local i:Int = 0 To steps - 1
			Local t:Float = Float(i) / Float(steps)
			Local mt:Float = 1.0 - t
			
			' Quadratic Bezier formula
			points[i*2] = mt * mt * x0 + 2.0 * mt * t * x1 + t * t * x2
			points[i*2+1] = mt * mt * y0 + 2.0 * mt * t * y1 + t * t * y2
		End
		
		' Draw segments with gradient colors
		For Local i:Int = 0 Until steps
			Local t1:Float = Float(i) / Float(steps)
			Local t2:Float = Float(i+1) / Float(steps)
			
			' Find colors at these points
			Local color1:Color = GetColorAtPosition(colors, positions, t1)
			Local color2:Color = GetColorAtPosition(colors, positions, t2)
			
			DrawGradientLine(Int(points[i*2]), Int(points[i*2+1]), 
			                Int(points[(i+1)*2]), Int(points[(i+1)*2+1]), 
			                color1, color2, thickness)
		End
	End
	
	' Draw multi-colored dithered line with Bayer matrix pattern
	Method DrawDitheredMultiGradientLine(x1:Int, y1:Int, x2:Int, y2:Int, colors:Color[], positions:Float[], thickness:Int=1)
		If colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		' Check if positions array is correctly normalized
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1 Return
			If i > 0 And positions[i] < positions[i-1] Return
		End
		
		' Special cases for horizontal and vertical lines
		If y1 = y2 Or x1 = x2
			DrawDitheredMultiGradientLineSimple(x1, y1, x2, y2, colors, positions, thickness)
			Return
		End
		
		' Setup for Bresenham's algorithm
		Local dx:Int = Abs(x2 - x1)
		Local dy:Int = Abs(y2 - y1)
		Local sx:Int = x1 < x2 ? 1 Else -1
		Local sy:Int = y1 < y2 ? 1 Else -1
		Local err:Int = dx - dy
		
		' Calculate line length for interpolation
		Local lineLength:Float = Sqrt(Float(dx * dx + dy * dy))
		Local cx:Int = x1
		Local cy:Int = y1
		Local distanceTraveled:Float = 0
		
		While True
			' Calculate how far along the line we are (0 to 1)
			Local t:Float = distanceTraveled / lineLength
			
			' Get bayer matrix threshold value at this pixel
			Local bayer:Float = BayerMatrix[(cy Mod 8) * 8 + (cx Mod 8)]
			
			' Find segment containing t
			Local segmentStart:Int = 0
			For Local i:Int = 1 Until positions.Length
				If t <= positions[i]
					segmentStart = i - 1
					Exit
				End
			End
			
			If segmentStart >= positions.Length - 1
				segmentStart = positions.Length - 2
			End
			
			Local segmentEnd:Int = segmentStart + 1
			
			' Calculate thresholded position within segment
			Local segmentPos:Float = (t - positions[segmentStart]) / 
			                        (positions[segmentEnd] - positions[segmentStart])
			
			' Apply dithering - choose between segment start and end colors
			Local color:Color
			If segmentPos < bayer
				color = colors[segmentStart]
			Else
				color = colors[segmentEnd]
			End
			
			' For thick lines, draw multiple pixels
			If thickness <= 1
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			Else
				Local halfThick:Int = thickness / 2
				For Local oy:Int = -halfThick To halfThick
					For Local ox:Int = -halfThick To halfThick
						If ox*ox + oy*oy <= halfThick*halfThick
							DrawPixel(cx + ox, cy + oy, ColorToARGB(color), color.a)
						End
					End
				End
			End
			
			If cx = x2 And cy = y2 Exit
			
			Local e2:Int = 2 * err
			Local movedX:Bool = False
			Local movedY:Bool = False
			
			If e2 > -dy
				err -= dy
				cx += sx
				movedX = True
			End
			
			If e2 < dx
				err += dx
				cy += sy
				movedY = True
			End
			
			' Update distance traveled
			If movedX And movedY
				distanceTraveled += 1.414213562  ' sqrt(2)
			Else
				distanceTraveled += 1.0
			End
		Wend
	End
	
	' Helper for simpler dithered multi-gradient rendering of horizontal/vertical lines
	Method DrawDitheredMultiGradientLineSimple(x1:Int, y1:Int, x2:Int, y2:Int, colors:Color[], positions:Float[], thickness:Int)
		If y1 = y2
			' Horizontal line
			Local startX:Int = Min(x1, x2)
			Local endX:Int = Max(x1, x2)
			Local width:Int = endX - startX + 1
			
			For Local x:Int = startX To endX
				Local t:Float = Float(x - startX) / Float(width - 1)
				If width <= 1 Then t = 0
				
				' Find segment containing t
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				For Local ty:Int = -thickness/2 To thickness/2
					Local y:Int = y1 + ty
					If y >= 0 And y < Height
						' Get bayer matrix threshold for this pixel
						Local bayer:Float = BayerMatrix[(y Mod 8) * 8 + (x Mod 8)]
						
						' Calculate position within segment
						Local segmentPos:Float = (t - positions[segmentStart]) / 
						                        (positions[segmentEnd] - positions[segmentStart])
						
						' Choose color based on threshold
						Local color:Color
						If segmentPos < bayer
							color = colors[segmentStart]
						Else
							color = colors[segmentEnd]
						End
						
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
		Else
			' Vertical line
			Local startY:Int = Min(y1, y2)
			Local endY:Int = Max(y1, y2)
			Local height:Int = endY - startY + 1
			
			For Local y:Int = startY To endY
				Local t:Float = Float(y - startY) / Float(height - 1)
				If height <= 1 Then t = 0
				
				' Find segment containing t
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				For Local tx:Int = -thickness/2 To thickness/2
					Local x:Int = x1 + tx
					If x >= 0 And x < Width
						' Get bayer matrix threshold for this pixel
						Local bayer:Float = BayerMatrix[(y Mod 8) * 8 + (x Mod 8)]
						
						' Calculate position within segment
						Local segmentPos:Float = (t - positions[segmentStart]) / 
						                        (positions[segmentEnd] - positions[segmentStart])
						
						' Choose color based on threshold
						Local color:Color
						If segmentPos < bayer
							color = colors[segmentStart]
						Else
							color = colors[segmentEnd]
						End
						
						DrawPixel(x, y, ColorToARGB(color), color.a)
					End
				End
			End
		End
	End

	' Draw multi-point gradient rectangle with arbitrary points
	Method DrawMultiGradientRect(	x:Int, y:Int, width:Int, height:Int, colors:Color[], 
	                                positions:Float[], pointStart:Vec2f, pointEnd:Vec2f)
	                                
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Check input validity
		If colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1 Return
			If i > 0 And positions[i] < positions[i-1] Return
		End
		
		' Calculate vector between gradient points
		Local dx:Float = pointEnd.x - pointStart.x
		Local dy:Float = pointEnd.y - pointStart.y
		Local gradientLength:Float = Sqrt(dx * dx + dy * dy)
		
		' Normalize direction vector if possible
		If gradientLength > 0.0001
			dx /= gradientLength
			dy /= gradientLength
		Else
			dx = 0
			dy = 0
		End
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Project the current point onto the gradient line
				Local vx:Float = Float(cx) - pointStart.x
				Local vy:Float = Float(cy) - pointStart.y
				
				' Dot product gives position along the gradient line
				Local projection:Float = vx * dx + vy * dy
				
				' Normalize to 0-1 range
				Local t:Float = projection / gradientLength
				t = Clamp(t, 0.0, 1.0)
				
				' Find segment containing t
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				' Calculate position within segment
				Local segmentPos:Float = (t - positions[segmentStart]) / 
				                        (positions[segmentEnd] - positions[segmentStart])
				
				Local color:Color = LerpColor(colors[segmentStart], colors[segmentEnd], segmentPos)
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			End
		End
	End
	
	' Draw a dithered multi-point gradient rectangle with arbitrary points
	Method DrawDitheredMultiGradientRect(	x:Int, y:Int, width:Int, height:Int, colors:Color[], 
	                                        positions:Float[], pointStart:Vec2f, pointEnd:Vec2f)
	                                        
		' Clip rectangle to pixmap bounds
		Local x1:Int = Max(0, x)
		Local y1:Int = Max(0, y)
		Local x2:Int = Min(Width - 1, x + width - 1)
		Local y2:Int = Min(Height - 1, y + height - 1)
		
		' Early exit if completely outside bounds
		If x1 > x2 Or y1 > y2 Return
		
		' Check input validity
		If colors.Length < 2 Or positions.Length < 2 Or colors.Length <> positions.Length Return
		
		For Local i:Int = 0 Until positions.Length
			If positions[i] < 0 Or positions[i] > 1 Return
			If i > 0 And positions[i] < positions[i-1] Return
		End
		
		' Calculate vector between gradient points
		Local dx:Float = pointEnd.x - pointStart.x
		Local dy:Float = pointEnd.y - pointStart.y
		Local gradientLength:Float = Sqrt(dx * dx + dy * dy)
		
		' Normalize direction vector if possible
		If gradientLength > 0.0001
			dx /= gradientLength
			dy /= gradientLength
		Else
			dx = 0
			dy = 0
		End
		
		For Local cy:Int = y1 To y2
			For Local cx:Int = x1 To x2
				' Project the current point onto the gradient line
				Local vx:Float = Float(cx) - pointStart.x
				Local vy:Float = Float(cy) - pointStart.y
				
				' Dot product gives position along the gradient line
				Local projection:Float = vx * dx + vy * dy
				
				' Normalize to 0-1 range
				Local t:Float = projection / gradientLength
				t = Clamp(t, 0.0, 1.0)
				
				' Get bayer matrix threshold
				Local bayer:Float = BayerMatrix[(cy Mod 8) * 8 + (cx Mod 8)]
				
				' Find segment containing t
				Local segmentStart:Int = 0
				For Local i:Int = 1 Until positions.Length
					If t <= positions[i]
						segmentStart = i - 1
						Exit
					End
				End
				
				If segmentStart >= positions.Length - 1
					segmentStart = positions.Length - 2
				End
				
				Local segmentEnd:Int = segmentStart + 1
				
				' Calculate position within segment
				Local segmentPos:Float = (t - positions[segmentStart]) / 
				                        (positions[segmentEnd] - positions[segmentStart])
				
				' Choose color based on threshold comparison
				Local color:Color
				If segmentPos < bayer
					color = colors[segmentStart]
				Else
					color = colors[segmentEnd]
				End
				
				DrawPixel(cx, cy, ColorToARGB(color), color.a)
			End
		End
	End
	
	Private 'Tools

	' Helper to determine if a point is on the left side of a line
	Method IsLeftOf:Bool(a:Vec2f, b:Vec2f, x:Float, y:Float)
		Return (b.x - a.x) * (y - a.y) - (x - a.x) * (b.y - a.y) > 0
	End
	
	' Convert Color to ARGB UInt
	Method ColorToARGB:UInt(color:Color)
		Return (UInt(color.a * 255.0) Shl 24) | 
		       (UInt(color.r * 255.0) Shl 16) | 
		       (UInt(color.g * 255.0) Shl 8) | 
		       UInt(color.b * 255.0)
	End
	
	' Linear interpolation between two float values
	Method Lerp:Float(a:Float, b:Float, t:Float)
		'TODO: Undone it when the Math lib will be integrated
		t = Clamp(t, 0.0, 1.0)
		Return a + (b - a) * t
	End
	
	' Interpolate between two colors
	Method LerpColor:Color(c1:Color, c2:Color, t:Float)
		t = Clamp(t, 0.0, 1.0)
		Return New Color(
			Lerp(c1.r, c2.r, t),
			Lerp(c1.g, c2.g, t),
			Lerp(c1.b, c2.b, t),
			Lerp(c1.a, c2.a, t))
	End
	
	' Clamp a float value between min and max
	Method Clamp:Float(value:Float, min:Float, max:Float)
		If value < min Then Return min
		If value > max Then Return max
		Return value
	End
	
	' Blend two ARGB pixels with alpha
	Function BlendPixels:UInt(dest:UInt, source:UInt)
		' Extract components
		Local destA:Int = (dest Shr 24) & $FF
		Local destR:Int = (dest Shr 16) & $FF
		Local destG:Int = (dest Shr 8) & $FF
		Local destB:Int = dest & $FF
		
		Local srcA:Int = (source Shr 24) & $FF
		Local srcR:Int = (source Shr 16) & $FF
		Local srcG:Int = (source Shr 8) & $FF
		Local srcB:Int = source & $FF
		
		' Early out for transparent source
		If srcA = 0 Return dest
		
		' Early out for fully opaque source
		If srcA = 255 Return source
		
		' Blend alpha
		Local outA:Int = srcA + (destA * (255 - srcA)) / 255
		
		' Avoid division by zero
		If outA = 0 Return 0
		
		' Blend colors
		Local outR:Int = (srcR * srcA + destR * destA * (255 - srcA) / 255) / outA
		Local outG:Int = (srcG * srcA + destG * destA * (255 - srcA) / 255) / outA
		Local outB:Int = (srcB * srcA + destB * destA * (255 - srcA) / 255) / outA
		
		' Clamp values
		outA = Min(255, outA)
		outR = Min(255, outR)
		outG = Min(255, outG)
		outB = Min(255, outB)
		
		Return (outA Shl 24) | (outR Shl 16) | (outG Shl 8) | outB
	End

	' Helper method to get a color at a specific gradient position
	Method GetColorAtPosition:Color(colors:Color[], positions:Float[], t:Float)
		' Handle edge cases
		If t <= positions[0] Return colors[0]
		If t >= positions[positions.Length-1] Return colors[positions.Length-1]
		
		' Find segment containing t
		Local segmentStart:Int = 0
		For Local i:Int = 1 Until positions.Length
			If t <= positions[i]
				segmentStart = i - 1
				Exit
			End
		End
		
		Local segmentEnd:Int = segmentStart + 1
		
		' Calculate position within segment
		Local segmentPos:Float = (t - positions[segmentStart]) / 
		                        (positions[segmentEnd] - positions[segmentStart])
		
		Return LerpColor(colors[segmentStart], colors[segmentEnd], segmentPos)
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
