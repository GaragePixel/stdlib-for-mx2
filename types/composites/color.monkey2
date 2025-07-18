
Namespace stdlib.types

'#Import "../../math/algebraic/vectorials/types/.."

Using stdlib.math.types..

#rem monkeydoc The Color type provides support for manipulating red, green blue, alpha colors.
#end
Struct Color
		
	#rem monkeydoc Transparent black.
	#end
	Const None:=New Color( 0,0,0,0 )
	
	#rem monkeydoc Black.
	#end
	Const Black:=New Color( 0,0,0 )
	
	#rem monkeydoc Grey.
	#end
	Const Grey:=New Color( .5,.5,.5 )
	
	#rem monkeydoc Light Grey.
	#end
	Const LightGrey:=New Color( .75,.75,.75 )
	
	#rem monkeydoc Dark Grey.
	#end
	Const DarkGrey:=New Color( .25,.25,.25 )
	
	#rem monkeydoc White.
	#end
	Const White:=New Color( 1,1,1 )
	
	#rem monkeydoc Red.
	#end
	Const Red:=New Color( 1,0,0 )
	
	#rem monkeydoc Green.
	#end
	Const Green:=New Color( 0,1,0 )
	
	#rem monkeydoc Blue.
	#end
	Const Blue:=New Color( 0,0,1 )
	
	#rem monkeydoc Brown.
	#end
	Const Brown:=New Color( .7,.4,.1 )
	
	#rem monkeydoc Orange.
	#end
	Const Orange:=New Color( 1,.5,0 )
	
	#rem monkeydoc Yellow.
	#end
	Const Yellow:=New Color( 1,1,0 )
	
	#rem monkeydoc Lime.
	#end
	Const Lime:=New Color( .7,1,0 )
	
	#rem monkeydoc Pine.
	#end
	Const Pine:=New Color( 0,.5,0 )
	
	#rem monkeydoc Aqua.
	#end
	Const Aqua:=New Color( 0,.9,.4 )
	
	#rem monkeydoc Cyan.
	#end
	Const Cyan:=New Color( 0,1,1 )
	
	#rem monkeydoc Sky.
	#end
	Const Sky:=New Color( 0,.5,1 )
	
	#rem monkeydoc Steel.
	#end
	Const Steel:=New Color( .2,.2,.7 )
	
	#rem monkeydoc Violet.
	#end
	Const Violet:=New Color( .7,0,1 )
	
	#rem monkeydoc Magenta.
	#end
	Const Magenta:=New Color( 1,0,1 )
	
	#rem monkeydoc Puce.
	#end
	Const Puce:=New Color( 1,0,.4 )
	
	#rem monkeydoc Skin.
	#end
	Const Skin:=New Color( .8,.5,.6 )
	
	#rem monkeydoc Pink.
	#end
	Const Pink:=New Color( 1,.75,.8 )
	
	#rem monkeydoc HotPink.
	#end
	Const HotPink:=New Color( 1,.41,.71 )

	#rem monkeydoc SeaGreen.
	#end
	Const SeaGreen:=New Color( .031372,.301960,.247058,1 )

	#rem monkeydoc Silver.
	#end
	Const Silver:=New Color( 0.98695202723239916,0.98157612499486091,0.96058105436290453 )

	#rem monkeydoc Aluminum.
	#end
	Const Aluminum:=New Color( 0.95955910300613745,0.9635188914336692,0.96495768667887971 )

	#rem monkeydoc Gold.
	#end
	Const Gold:=New Color( 1,0.88565078560356991,0.6091625017721024 )

	#rem monkeydoc Copper.
	#end
	Const Copper:=New Color( 0.9792921449434141,0.81490079942355442,0.75455014940288267 )

	#rem monkeydoc Chromium.
	#end
	Const Chromium:=New Color( 0.76178782381338439,0.76588820797089974,0.76472402871006473 )

	#rem monkeydoc Nickel.
	#end
	Const Nickel:=New Color( 0.827766413700323,0.79798492878548577,0.74652364685504802 )

	#rem monkeydoc Titanium.
	#end
	Const Titanium:=New Color( 0.75694694835172049,0.72760746687141564,0.69520723368860826 )

	#rem monkeydoc Cobalt.
	#end
	Const Cobalt:=New Color( 0.82910355988659823,0.82495893307721546,0.81275025476652396 )

	#rem monkeydoc Platinum.
	#end
	Const Platinum:=New Color( 0.83493408973507777,0.81484503266020314,0.78399912482207756 )

	#rem monkeydoc CGA Legacy (0xAA/0xFF/0x55 mapped) 
	@adapted by iDkP from GaragePixel
	@since 2025-06-27
	#end
	Const CGA0:Color  = New Color( 0.00, 0.00, 0.00 )			' #000000
	Const CGA1:Color  = New Color( 0.00, 0.00, 0.67 )			' #0000AA
	Const CGA2:Color  = New Color( 0.00, 0.67, 0.00 )			' #00AA00
	Const CGA3:Color  = New Color( 0.00, 0.67, 0.67 )			' #00AAAA
	Const CGA4:Color  = New Color( 0.67, 0.00, 0.00 )			' #AA0000
	Const CGA5:Color  = New Color( 0.67, 0.00, 0.67 )			' #AA00AA
	Const CGA6:Color  = New Color( 0.67, 0.33, 0.00 )			' #AA5500
	Const CGA7:Color  = New Color( 0.67, 0.67, 0.67 )			' #AAAAAA
	Const CGA8:Color  = New Color( 0.33, 0.33, 0.33 )			' #555555
	Const CGA9:Color  = New Color( 0.33, 0.33, 1.00 )			' #5555FF
	Const CGA10:Color = New Color( 0.33, 1.00, 0.33 )			' #55FF55
	Const CGA11:Color = New Color( 0.33, 1.00, 1.00 )			' #55FFFF
	Const CGA12:Color = New Color( 1.00, 0.33, 0.33 )			' #FF5555
	Const CGA13:Color = New Color( 1.00, 0.33, 1.00 )			' #FF55FF
	Const CGA14:Color = New Color( 1.00, 1.00, 0.33 )			' #FFFF55
	Const CGA15:Color = New Color( 1.00, 1.00, 1.00 )			' #FFFFFF

	#rem monkeydoc CGA Next Gen
	@adapted by iDkP from GaragePixel
	@since 2025-06-27
	@source https://int10h.org/blog/2022/06/ibm-5153-color-true-cga-palette/ 
	@source http://www.oldskool.org/pc/cgacal
	#end
	Const CGA0NG:=New Color( 	0.00,	0.00,	0.00	)
	Const CGA1NG:=New Color( 	0.00,	0.00,	0.77	)
	Const CGA2NG:=New Color( 	0.00,	0.77,	0.00	)
	Const CGA3NG:=New Color( 	0.00,	0.77,	0.77	)
	Const CGA4NG:=New Color( 	0.77,	0.00,	0.00	)
	Const CGA5NG:=New Color( 	0.77,	0.00,	0.77	)
	Const CGA6NG:=New Color( 	0.77,	0.49,	0.00	)
	Const CGA7NG:=New Color( 	0.77,	0.77,	0.77	)
	Const CGA8NG:=New Color( 	0.31,	0.31,	0.31	)
	Const CGA9NG:=New Color( 	0.31,	0.31,	0.86	)
	Const CGA10NG:=New Color( 	0.31,	0.86,	0.31	)
	Const CGA11NG:=New Color( 	0.31,	0.95,	0.95	)
	Const CGA12NG:=New Color( 	0.86,	0.31,	0.31	)
	Const CGA13NG:=New Color( 	0.95,	0.31,	0.95	)
	Const CGA14NG:=New Color( 	0.95,	0.95,	0.31	)
	Const CGA15NG:=New Color( 	1.00,	1.00,	1.00	)

	#rem monkeydoc Red component of color.
	#end
	Field r:Float

	#rem monkeydoc Green component of color.
	#end
	Field g:Float
	
	#rem monkeydoc Blue component of color.
	#end
	Field b:Float
	
	#rem monkeydoc Alpha component of color.
	#end
	Field a:Float
	
	#rem monkeydoc Creates a new color.
	#end
	Method New( a:Float=1 )
		Self.a=a
	End
	
	Method New( i:Float,a:Float=1 )
		Self.r=i
		Self.g=i
		Self.b=i
		Self.a=1
	End
	
	Method New( r:Float,g:Float,b:Float,a:Float=1 )
		Self.r=r
		Self.g=g
		Self.b=b
		Self.a=a
	End
	
	Method New( v:stdlib.math.types.Vec4f )
		Self.r=v.x
		Self.g=v.y
		Self.b=v.z
		Self.a=v.w
	End
	
	#rem monkeydoc Converts the color to a printable string.
	#end
	Operator To:String()
		Return "Color("+r+","+g+","+b+","+a+")"
	End
	
	#rem monkeydoc Converts the color to float 4 vector.
	#end
	Operator To:stdlib.math.types.Vec4f()
		Return New Vec4f( r,g,b,a )
	End

	#rem monkeydoc The Red color component.
	#end
	Property R:Float()
		Return r
	Setter( r:Float )
		Self.r=r
	End
	
	#rem monkeydoc The green color component.
	#end
	Property G:Float()
		Return g
	Setter( g:Float )
		Self.g=g
	End
	
	#rem monkeydoc The blue color component.
	#end
	Property B:Float()
		Return b
	Setter( b:Float )
		Self.b=b
	End
	
	#rem monkeydoc The alpha color component.
	#end
	Property A:Float()
		Return a
	Setter( a:Float )
		Self.a=a
	End
	
	#rem monkeydoc Multiplies the color by another color or value and returns the result.
	#end
	Operator*:Color( color:Color )
		Return New Color( r*color.r,g*color.g,b*color.b,a*color.a )
	End

	Operator*:Color( scale:Float )
		Return New Color( r*scale,g*scale,b*scale,a*scale )
	End
	
	#rem monkeydoc Divides the color by another color or value and returns the result.
	#end
	Operator/:Color( color:Color )
		Return New Color( r/color.r,g/color.g,b/color.b,a/color.a )
	End

	Operator/:Color( scale:Float )
		Return New Color( r/scale,g/scale,b/scale,a/scale )
	End

	#rem monkeydoc Adds another color or value to the color and returns the result.
	#end
	Operator+:Color( color:Color )
		Return New Color( r+color.r,g+color.g,b+color.b,a+color.a )
	End

	Operator+:Color( offset:Float )
		Return New Color( r+offset,g+offset,b+offset,a+offset )
	End

	#rem monkeydoc Subtracts another color or value from the color and returns the result.
	#end
	Operator-:Color( color:Color )
		Return New Color( r-color.r,g-color.g,b-color.b,a-color.a )
	End

	Operator-:Color( offset:Float )
		Return New Color( r-offset,g-offset,b-offset,a-offset )
	End
	
	#rem monkeydoc Blends the color with another color and returns the result.
	#end	
	Method Blend:Color( color:Color,delta:Float )
		Local idelta:=1-delta
		Return New Color( r*idelta+color.r*delta,g*idelta+color.g*delta,b*idelta+color.b*delta,a*idelta+color.a*delta )
	End

	#rem monkeydoc Converts the color to 32 bit big endian ARGB format.
	
	Big endian ARGB is the same as little endian BGRA.
	
	#end	
	Method ToARGB:UInt()
		Return UInt(a*255) Shl 24 | UInt(r*255) Shl 16 | UInt(g*255) Shl 8 | UInt(b*255)
	End

	#rem monkeydoc Converts the color to 32 bit big endian BGRA format.

	Big endian BGRA is the same as little endian ARGB.
	
	#end	
	Method ToBGRA:UInt()
		Return UInt(b*255) Shl 24 | UInt(g*255) Shl 16 | UInt(r*255) Shl 8 | UInt(a*255)
	End

	#rem monkeydoc Converts the color to 32 bit big endian RGBA format.
	
	Big endian RGBA is the same as little endian ABGR.
	
	#end	
	Method ToRGBA:UInt()
		Return UInt(r*255) Shl 24 | UInt(g*255) Shl 16 | UInt(b*255) Shl 8 | UInt(a*255)
	End

	#rem monkeydoc Converts the color to 32 bit big endianABGR format.
	
	Big endian ABGR is the same as little endian RGBA.
	
	#end	
	Method ToABGR:UInt()
		Return UInt(a*255) Shl 24 | UInt(b*255) Shl 16 | UInt(g*255) Shl 8 | UInt(r*255)
	End

	#rem monkeydoc Converts the color to printable string.
	#end
	Method ToString:String()
		Return Self
	End
	
	#rem monkeydoc Creates a color from hue, saturation and value.
	#end
	Function FromHSV:Color( h:Float,s:Float,v:Float,a:Float=1 )

		h*=6
		
		Local f:=h-Floor( h )
		
		Local p:=v * ( 1 - s )
		Local q:=v * ( 1 - ( s * f ) )
		Local t:=v * ( 1 - ( s * ( 1-f ) ) )
		
		Local r:Float,g:Float,b:Float
		
		Select Int( h ) Mod 6
		Case 0 r=v ; g=t ; b=p
		Case 1 r=q ; g=v ; b=p
		Case 2 r=p ; g=v ; b=t
		Case 3 r=p ; g=q ; b=v
		Case 4 r=t ; g=p ; b=v
		Case 5 r=v ; g=p ; b=q
		End
		
		Return New Color( r,g,b,a )
	End
	
	#rem monkeydoc Creates a color from a 32 bit big endian ARGB color.

	Big endian ARGB is the same as little endian BGRA.

	#end
	Function FromARGB:Color( argb:UInt )
		Local a:=(argb Shr 24 & $ff)/255.0
		Local r:=(argb Shr 16 & $ff)/255.0
		Local g:=(argb Shr 8 & $ff)/255.0
		Local b:=(argb & $ff)/255.0
		Return New Color( r,g,b,a )
	End
	
	#rem monkeydoc Creates a color from a 32 bit big endian BGRA color.

	Big endian BGRA is the same as little endian ARGB.
	
	#end
	Function FromBGRA:Color( bgra:UInt )
		Local b:=(bgra Shr 24 & $ff)/255.0
		Local g:=(bgra Shr 16 & $ff)/255.0
		Local r:=(bgra Shr 8 & $ff)/255.0
		Local a:=(bgra & $ff)/255.0
		Return New Color( r,g,b,a )
	End
	
	#rem monkeydoc Creates a color from a 32 bit big endian RGBA color.

	Big endian RGBA is the same as little endian ABGR.
	
	#end
	Function FromRGBA:Color( rgba:UInt )
		Local r:=(rgba Shr 24 & $ff)/255.0
		Local g:=(rgba Shr 16 & $ff)/255.0
		Local b:=(rgba Shr 8 & $ff)/255.0
		Local a:=(rgba & $ff)/255.0
		Return New Color( r,g,b,a )
	End
	
	#rem monkeydoc Creates a color from a 32 bit big endian ABGR color.

	Big endian ABGR is the same as little endian RGBA.
	
	#end
	Function FromABGR:Color( abgr:UInt )
		Local a:=(abgr Shr 24 & $ff)/255.0
		Local b:=(abgr Shr 16 & $ff)/255.0
		Local g:=(abgr Shr 8 & $ff)/255.0
		Local r:=(abgr & $ff)/255.0
		Return New Color( r,g,b,a )
	End
	
	#rem monkeydoc Creates a random color.
	#end
'	Function Rnd:Color()
		
		'TODO: Change the random module
		
'		Return FromHSV( random.Rnd(6),1,1 )
		
'	End

End
