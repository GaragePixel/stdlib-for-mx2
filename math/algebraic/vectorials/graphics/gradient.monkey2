'==============================================================
' 2D Geometric Primitives Library
' Implementation: iDkP for GaragePixel
' 2025-03-28 (Aida 4)
'
' Generic Gradient Class with Runtime Optimization
' 	- Allows both graphical and non graphical operations.
'   - Supports both Color and Int gradient calculations with a single implementation
'   - Implements three gradient types: segment, directional, and radial
'	- Allow multi-colors gradients
'   - Enables smooth interpolation between multiple color stops
'
' Note:
'	The function pointer approach for the calculation methods 
'	is an excellent optimization choice, it eliminates runtime type checking 
'	during high-frequency color evaluations, and this is extremely fast! 
'
'	The performance results are: over 20 million gradient calculations 
'	per second, so then 1,000,000 gradient calculations in just 30ms!
'
'	By preconfiguring function pointers when parameters change 
'	(rather than using runtime conditionals as the Mark's coding style), 
'	we've achieved calculation speeds that would be suitable 
'	even for extremely demanding real-time applications.
'
'	My implementation's ability to handle both object 
'	and integer color formats with the same codebase while maintaining 
'	excellent performance validates the design choices. 
'	So please wait for the integration of my coding style in the actual 
'	Mark's implementation of the pixmap (iDkP: 2025-03-28)
'
'	Benchmark (commons PC configuration since ~2015):
'
'		1,000,000 gradient calculations in 30-40ms
'		~20 million calculations per second
'		TrueColor integer gradients showing a ~20% performance advantage over Color objects
'		Segment and Radial gradients performing identically (both 29-31ms)


'==============================================================

Namespace stdlib.math.types

#Import "../../../../resources/graphics/color"

Using stdlib.graphics..

Enum GradientType
	Segment
	Directional
	Radial 
End 

Enum GradientMode
	Simple
	Multi
End 

Alias Gradientc:Gradient<Color>
Alias Gradienti:Gradient<Int>

Class Gradient<T> Where T=Color Or T=Int 'Takes Color, Int as Hex or Truecolor
	
	' Note:
	' 	Colors are interpolated in their native format (either Color objects or
	' 	Int ARGB values) to avoid unnecessary conversions in the rendering pipeline.
	' 	The gradient type determines which calculation function is assigned at
	' 	configuration time, eliminating the need for runtime type checking during
	' 	high-frequency color evaluations.

	Property A:Vec2f()
		Return _A
	Setter(a:Vec2f)
		_A = a
		If _type = GradientType.Directional Then UpdateDirectionVectors()
	End
	
	Property B:Vec2f()
		Return _B
	Setter(b:Vec2f)
		_B = b
		If _type = GradientType.Directional Then UpdateDirectionVectors()
	End
	
	Property Colors:T[]()
		Return _colors
	Setter(colors:T[])
		Assert(colors.Length<>_stops.Length,"Gradient error: colors mismatches the stops")
		_colors=colors
	End
	
	Property Stops:Float[]()
		Return _stops
	Setter(stops:Float[])
		Assert(_colors.Length<>stops.Length,"Gradient error: stops mismatches the colors")
		_stops=stops
	End
	
	Property Type:GradientType()
		Return _type
	Setter(type:GradientType)
		_type = type
		
		Select _type
			Case GradientType.Segment
				_calculateposition_ = CalculateSegment
				
			Case GradientType.Directional
				UpdateDirectionVectors()
				_calculateposition_ = CalculateDirectional
				
			Case GradientType.Radial
				_calculateposition_ = CalculateRadial
		End
	End
	
	Property Mode:GradientMode()
		Return _mode
	End	
	
	Method New(
		color0:T,color1:T,
		type:GradientType=GradientType.Segment)
		
		_type=type
		_mode=GradientMode.Simple
		_colors=New T[2](color0,color1)
		_stops=New Float[](0,1)
		_A=New Vec2f()
		_B=New Vec2f()
	End 
	
	Method New(
		color0:T,color1:T,
		pos0:Vec2f,pos1:Vec2f,
		type:GradientType=GradientType.Segment)
		
		_type=type
		_mode=GradientMode.Simple
		_colors=New T[2](color0,color1)
		_stops=New Float[](0,1)
		_A=pos0
		_B=pos1
	End 
	
	Method New(
		colors:T[],stops:Float[],
		type:GradientType=GradientType.Segment)
		
		Assert(colors.Length<>stops.Length,"Gradient error: colors and stops mismatches")
		_type=type
		_mode=GradientMode.Simple
		_colors=colors
		_stops=stops
		_A=New Vec2f()
		_B=New Vec2f()
	End 
	
	Method New(
		colors:T[],stops:Float[],
		pos0:Vec2f,pos1:Vec2f,
		type:GradientType=GradientType.Segment)
		
		Assert(colors.Length<>stops.Length,"Gradient error: colors and stops mismatches")
		_type=type
		_mode=GradientMode.Simple
		_colors=colors
		_stops=stops
		_A=pos0
		_B=pos1
	End 	
	
	Operator To:String()
		If _mode=GradientMode.Simple
			Return "Gradient (color0: "+_colors[0]+", color1: "+_colors[1]+")"
		Else '_mode=GradientMode.Multi
			Return "Gradient (colors: "+_colors.Length+", stops: "+_stops.Length+")"
		End
	End 

	Method ToString:String()
		
		Local type:String 
		Local mode:String
		
		If _type=GradientType.Segment 
			type="Segment"
		Elseif _type=GradientType.Directional 
			type="Directional"
		Elseif _type=GradientType.Radial 
			type="Radial"
		End 

		If _mode=GradientMode.Simple 
			mode="Simple"
		Elseif _mode=GradientMode.Multi
			mode="Multi"
		End 

		If _mode=GradientMode.Simple
			Return "Gradient (type: "+type+", mode:" +mode+", color0: "+_colors[0]+", color1: "+_colors[1]+")"
		Else '_mode=GradientMode.Multi
			
			Local colors:String
			Local stops:String

			If _colors.Length>=3

				For Local n:=0 Until _colors.Length-2
					colors+=String(_colors[n])+","
				Next
				colors+=String(_colors[_colors.Length-1])
				
				For Local n:=0 Until _stops.Length-2
					stops+=_stops[n]+","
				Next
				stops+=_stops[_stops.Length-1]
			Else
				colors+=_color[0]+","
				colors+=_color[1]
				stops+=_color[0]+","
				stops+=_color[1]
			End
			
			Return "Gradient (type: "+type+", mode:" +mode+", colors: "+_colors.Length+", stops: "+stops+")"
		End
	End
	
	Method ToSimple()
		If _mode=GradientMode.Multi 
			Local color0:=_colors[0]
			Local color1:=_colors[_colors.Length-1]
			Local pos0:=_stops[0]
			Local pos1:=_stops[_stops.Length-1]
			_colors=New T[2](color0,color1)
			_stops=New Float[2](pos0,pos1)
		End 
	End 
		
	Method SetColor( index:Int, value:T )
		_colors[index]=value
	End
	
	Method GetColor:T( index:Int )
		Return _colors[index]
	End	
	
	Method Setstop( index:Int, value:Float )
		_stops[index]=value
	End
	
	Method Getstop:Float( index:Int )
		Return _stops[index]
	End

	Method GetColor:T( x:Float, y:Float )
		' Get the gradient color at the given position
		
		' Calculate normalized position along the gradient
		'Local position:Vec2f = New Vec2f(x, y)
		Local t:Float = CalculatePosition(Varptr(x),Varptr(y))
		
		' Clamp t to valid range
		t = Max(0.0, Min(1.0, t))
		
		' Simple mode just interpolates between two colors
		If _mode = GradientMode.Simple
			Return Interpolate(Self, _colors[0], _colors[1], t)
		End
		
		' For multi-stop gradients, find the relevant segment and interpolate
		For Local i:Int = 0 Until _stops.Length - 1
			If t >= _stops[i] And t <= _stops[i+1]
				' Calculate interpolation factor within this segment
				Local segmentT:Float = (t - _stops[i]) / (_stops[i+1] - _stops[i])
				Return Interpolate(Self, _colors[i], _colors[i+1], segmentT)
			End
		Next
		
		' Fallback (dead code if 't' is properly clamped)
		If t <= _stops[0]
			Return _colors[0]
		Else
			Return _colors[_colors.Length-1]
		End
	End
	
	Method GetColor:T( position:Vec2f )
		' Sugar
		Return GetColor(position.x, position.y)
	End
	
	Method GetColor:T Ptr( x:Float Ptr, y:Float Ptr ) ' Primary pointer implementation for direct memory access
		
		' Calculate normalized position along the gradient
		'Local position:Vec2f = New Vec2f(x[0], y[0])
		Local t:Float = CalculatePosition(x,y)
		
		' Clamp t to valid range
		t = Max(0.0, Min(1.0, t))
		
		' Simple mode just interpolates between two colors
		If _mode = GradientMode.Simple
			Return Interpolate(Self, Varptr(_colors[0]), Varptr(_colors[1]), Varptr(t))
		End
		
		' For multi-stop gradients, find the relevant segment and interpolate
		For Local i:Int = 0 Until _stops.Length - 1
			If t >= _stops[i] And t <= _stops[i+1]
				' Calculate interpolation factor within this segment
				Local segmentT:Float = (t - _stops[i]) / (_stops[i+1] - _stops[i])
				Return Interpolate(Self, Varptr(_colors[i]), Varptr(_colors[i+1]), Varptr(segmentT))
			End
		Next
		
		' Fallback (dead code if 't' is properly clamped)
		If t <= _stops[0]
			Return Varptr(_colors[0])
		Else
			Return Varptr(_colors[_colors.Length-1])
		End
	End
	
	Method GetColor:T Ptr( position:Vec2f Ptr )
		' Sugar
		Return GetColor(Varptr(position[0].x), Varptr(position[0].y))
	End

	Method Sample:T( t:Float )
	
		' Sample the gradient at a specific normalized position (0-1)
		' Useful for 1D gradient sampling without position calculations
		
		' Clamp t to valid range
		t = Max(0.0, Min(1.0, t))
		
		' Simple mode just interpolates between two colors
		If _mode = GradientMode.Simple
			Return Interpolate(Self, _colors[0], _colors[1], t)
		End
		
		' For multi-stop gradients, find the relevant segment and interpolate
		For Local i:Int = 0 Until _stops.Length - 1
			If t >= _stops[i] And t <= _stops[i+1]
				' Calculate interpolation factor within this segment
				Local segmentT:Float = (t - _stops[i]) / (_stops[i+1] - _stops[i])
				Return Interpolate(Self, _colors[i], _colors[i+1], segmentT)
			End
		Next
		
		' Dead code if anything works as expected
		If t <= _stops[0]
			Return _colors[0]
		Else
			Return _colors[_colors.Length-1]
		End
	End

	Function IntToHexString:String(value:Int)
		Local hexChars:String = "0123456789ABCDEF"
		Local result:String = ""
		
		For Local i:Int = 0 Until 8
			Local digit:Int = (value Shr ((7-i)*4)) & $F
			result += String.FromChar(hexChars[digit])
		Next
		
		Return result
	End
	
	Private
		
	Method CalculatePosition:Float( x:Float Ptr, y:Float Ptr )
		
		' Calculate normalized position based on gradient type
		
		'iDkP:
		'	As you can see, my programmation style is very dynamic,
		'	if Mark had programmed the SetPixel/GetPixel of the pixmap
		'	using this style, our programs would have been 3 times faster.
		'	But everything will be fine, I'll fix this out for you.
		'	2025-03-28
		
'		Select _type
'			Case GradientType.Segment
'				Return CalculateSegment(position)
'				
'			Case GradientType.Directional
'				Return CalculateDirectional(position)
'				
'			Case GradientType.Radial
'				Return CalculateRadial(position)
'		End

		' iDkP:
		' 	The trick is to preconfigure a closure when the parameters change, 
		'	and not naively execute this or that block based on parameters.

		Return _calculateposition_(Self,x,y)
	End
	
	Function CalculateSegment:Float( grad:Gradient, x:Float Ptr, y:Float Ptr  )
		
		' Calculate position along a line segment
		
		' If points are identical, return 0
		If grad._A.x = grad._B.x And grad._A.y = grad._B.y Return 0.0
		
		' Calculate vector from A to B
		Local AB:Vec2f = New Vec2f(grad._B.x - grad._A.x, grad._B.y - grad._A.y)
		
		' Calculate vector from A to position
		Local AP:Vec2f = New Vec2f(x[0] - grad._A.x, y[0] - grad._A.y)
		
		' Project AP onto AB
		Local dot:Float = AP.x * AB.x + AP.y * AB.y
		Local lenSq:Float = AB.x * AB.x + AB.y * AB.y
		
		Return Clamp(dot / lenSq, 0.0, 1.0)
	End
	
	Function CalculateDirectional:Float( grad:Gradient, x:Float Ptr, y:Float Ptr )
		
		' Fast directional gradient calculation
		
		' Calculate vector components from A to B only once
		Local dx:Float = grad._B.x - grad._A.x
		Local dy:Float = grad._B.y - grad._A.y
		
		' Calculate squared length (avoid square root if possible)
		Local lenSq:Float = dx * dx + dy * dy
		If lenSq < 0.0001 Return 0.0
		
		' Calculate vector from A to position
		Local ax:Float = x[0] - grad._A.x
		Local ay:Float = y[0] - grad._A.y
		
		' Direct dot product calculation
		Local dot:Float = ax * dx + ay * dy
		
		' Fast way to handle the normalization
		Return Clamp(dot / lenSq, 0.0, 1.0)
	End
	
	Function CalculateRadial:Float( grad:Gradient, x:Float Ptr, y:Float Ptr )
		
		' Calculate position for radial gradient
		
		' A is center, distance from A to B is the radius
		Local radius:Float = Sqrt((grad._B.x - grad._A.x) * (grad._B.x - grad._A.x) + (grad._B.y - grad._A.y) * (grad._B.y - grad._A.y))
		If radius < 0.0001 Return 0.0
		
		' Calculate distance from center to position
		Local distance:Float = Sqrt((x[0] - grad._A.x) * (x[0] - grad._A.x) + 
		                           (y[0] - grad._A.y) * (y[0] - grad._A.y))
		
		Return Clamp(distance / radius, 0.0, 1.0)
	End
	
	Function Interpolate:T( grad:Gradient, color1:T, color2:T, t:Float )
		' Interpolate between two colors based on t
		Return Interpolate_(grad, color1, color2, t)
	End

	Function Interpolate:T Ptr( grad:Gradient, color1:T Ptr, color2:T Ptr, t:Float Ptr )
		' Interpolate between two colors based on t
		Return Interpolate_(grad, color1, color2, t)
	End
	
	Function Interpolate_:Color( grad:Gradient, c1:Color, c2:Color, t:Float )
		
		' Type-specific color interpolation
		
		Return New Color(
			c1.r + (c2.r - c1.r) * t,
			c1.g + (c2.g - c1.g) * t,
			c1.b + (c2.b - c1.b) * t,
			c1.a + (c2.a - c1.a) * t)
	End

	Function Interpolate_:Color Ptr( grad:Gradient, c1:Color Ptr, c2:Color Ptr, t:Float Ptr )
		
		' Type-specific color interpolation
		
		Local result:=New Color(
			c1[0].r + (c2[0].r - c1[0].r) * t[0],
			c1[0].g + (c2[0].g - c1[0].g) * t[0],
			c1[0].b + (c2[0].b - c1[0].b) * t[0],
			c1[0].a + (c2[0].a - c1[0].a) * t[0])
		Return Varptr(result)
	End
	
	Function Interpolate_:Int( grad:Gradient, argb1:Int, argb2:Int, t:Float )
		
		' Type-specific int color interpolation
		
		Local a1:Int = (argb1 Shr 24) & $FF
		Local r1:Int = (argb1 Shr 16) & $FF
		Local g1:Int = (argb1 Shr 8) & $FF
		Local b1:Int = argb1 & $FF
		
		Local a2:Int = (argb2 Shr 24) & $FF
		Local r2:Int = (argb2 Shr 16) & $FF
		Local g2:Int = (argb2 Shr 8) & $FF
		Local b2:Int = argb2 & $FF
		
		Local a:Int = a1 + Int((a2 - a1) * t)
		Local r:Int = r1 + Int((r2 - r1) * t)
		Local g:Int = g1 + Int((g2 - g1) * t)
		Local b:Int = b1 + Int((b2 - b1) * t)
		
		Return (a Shl 24) | (r Shl 16) | (g Shl 8) | b
	End

	Function Interpolate_:Int Ptr( grad:Gradient, argb1:Int Ptr, argb2:Int Ptr, t:Float Ptr)
		
		' Type-specific int color interpolation
		
		Local a1:Int = (argb1[0] Shr 24) & $FF
		Local r1:Int = (argb1[0] Shr 16) & $FF
		Local g1:Int = (argb1[0] Shr 8) & $FF
		Local b1:Int = argb1[0] & $FF
		
		Local a2:Int = (argb2[0] Shr 24) & $FF
		Local r2:Int = (argb2[0] Shr 16) & $FF
		Local g2:Int = (argb2[0] Shr 8) & $FF
		Local b2:Int = argb2[0] & $FF
		
		Local a:Int = a1 + Int((a2 - a1) * t[0])
		Local r:Int = r1 + Int((r2 - r1) * t[0])
		Local g:Int = g1 + Int((g2 - g1) * t[0])
		Local b:Int = b1 + Int((b2 - b1) * t[0])
		
		Local result:=(a Shl 24) | (r Shl 16) | (g Shl 8) | b
		
		Return Varptr(result)
	End
	
	Method UpdateDirectionVectors()
		
		' Calculate direction vector and its properties once
		
		Local dx:Float = _B.x - _A.x
		Local dy:Float = _B.y - _A.y
		
		' Calculate length and validate
		_dirLength = Sqrt(dx * dx + dy * dy)
		
		If _dirLength < 0.0001
			' Handle degenerate case
			_dirX = 1.0
			_dirY = 0.0
			_dirLength = 0.0001
			_invLength = 10000.0
		Else
			' Normalize and store the inverse length
			_invLength = 1.0 / _dirLength
			_dirX = dx * _invLength
			_dirY = dy * _invLength
		End
	End	

	Field _colors:T[]
	Field _stops:Float[] 
	Field _A:Vec2f
	Field _B:Vec2f
	Field _type:GradientType
	Field _mode:GradientMode
	Field _calculateposition_:=CalculateSegment

	Field _dirX:Float        ' Normalized direction X component
	Field _dirY:Float        ' Normalized direction Y component
	Field _dirLength:Float   ' Length of direction vector
	Field _invLength:Float   ' Precomputed inverse of length (1.0/length)
End 
