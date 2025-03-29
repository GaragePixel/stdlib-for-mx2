'==============================================================
' DitherMatrix - High Performance Threshold Matrix Implementation
' Implementation: iDkP from GaragePixel
' 2025-03-29 (Aida 4)
'==============================================================
'
'	Efficient threshold matrix storage and lookup for dithering operations
'	with branch-free execution path and specialized implementation types.
'		
'	Functionality:
'		- Generic matrix storage for both integer and floating point thresholds
'		- Function pointer delegation for zero-branch lookup operations
'		- Specialized implementations for different matrix dimension types
'		- Fast bit-masking operations for power-of-two dimensions
'		- Factory functions for common dithering patterns (Bayer, Halftone)
'		- Customizable normalization for different output ranges
'	
'	Design Philosophy:
'		By detecting matrix properties during initialization and selecting specialized 
'		implementations, we eliminate runtime conditionals from the critical rendering path, 
'		significantly improving	performance on modern CPUs through 
'		better instruction cache utilization and branch prediction accuracy
'		(rather than using runtime conditionals as the Mark's coding style).
'		So please wait for the integration of my coding style in the actual
'		Mark's implementation of the pixmap (iDkP: 2025-03-28)
'
'==============================================================

Namespace stdlib.math.graphics

Using stdlib..

Enum DitherMode 
	None'No dither
	RGB'Solid 
	A'Alpha 
	ARGB'Composite
End 

Class DitherMatrix<T> Where T=Int Or T=Float
	
	Property Square:Bool()
		Return _width=_height
	End
	
	Property Norm:T()
		Return _norm 
	End
	
	Method New(width:Int, height:Int, data:T[], normalize:T=1.0)
		
		_data = data
		_width = width
		_height = height
		_norm=normalize

		If (width & (width - 1)) = 0
			If width = height
				_GetThreshold_=GetThreshold_Sqrt_Power2<T>
			Else
				If (height & (height - 1)) = 0
					_GetThreshold_=GetThreshold_Rect_Power2<T>
				Else 
					_GetThreshold_=GetThreshold_Width_Power2<T>
				End
			End 
		Else
			_GetThreshold_=GetThreshold_General<T>
		End
	End

	Method GetThreshold:T(x:Int, y:Int)
		Return _GetThreshold_(Self, x, y)
	End 

	Private 'Please, don't touch that
	
	Field _data:T[]
	Field _width:Int 
	Field _height:Int 
	Field _norm:T
	
	Field _GetThreshold_:=GetThreshold_Rect_Power2<T>
	
	Function GetThreshold_Sqrt_Power2<T>:T(matrix:DitherMatrix<T>, x:Int, y:Int)
		
		' Square power-of-2 matrices (most common, fastest case)
		
		' Fast threshold lookup for square matrices with power-of-2 dimensions
		' Width and height are identical and both power-of-2
		
		' Calculate position using fast bit masking (15x faster than division)
		Local mx:Int = x & (matrix._width - 1)
		Local my:Int = y & (matrix._width - 1)  ' _width is equal to _height
		
		Return matrix._data[my * matrix._width + mx]
	End
	
	Function GetThreshold_Rect_Power2<T>:T(matrix:DitherMatrix<T>, x:Int, y:Int)
		
		' Non-square power-of-2 matrices
		
		' Fast threshold lookup for rectangular matrices with power-of-2 dimensions
		' Both width and height are power-of-2 but not equal
		
		' Calculate position using appropriate masks for each dimension
		Local mx:Int = x & (matrix._width - 1)
		Local my:Int = y & (matrix._height - 1)
		
		Return matrix._data[my * matrix._width + mx]
	End

	Function GetThreshold_Width_Power2<T>:T(matrix:DitherMatrix<T>, x:Int, y:Int)
		
		' Specialized threshold lookup for matrices with:
		' - Width is power-of-2 (fast bit masking)
		' - Height is NOT power-of-2 (requires standard modulo)
		
		Local mx:Int = x & (matrix._width - 1)
		Local my:Int = y Mod matrix._height
		
		' Handle negative coordinates for y-coordinate
		' (This is the key fix for Width-only implementation)
		If my < 0 my += matrix._height
		
		' Direct array access with minimal computation
		Return matrix._data[my * matrix._width + mx]
	End

	Function GetThreshold_General<T>:T(matrix:DitherMatrix<T>, x:Int, y:Int)
		
		' General threshold lookup for rectangular matrices
		
		' Calculate position with standard modulo
		Local mx:Int = x Mod matrix._width
		Local my:Int = y Mod matrix._height
		
		' Handle negative coordinates (This is the key fix for General implementation)
		If mx < 0 mx += matrix._width
		If my < 0 my += matrix._height
	
		Return matrix._data[my * matrix._width + mx]
	End
	
	' ----------
	' The Factory:
	' ----------
	
	Public
	
	' I'm not Mark, isn't private, isn't protected. 
	' Amaze me by proposing original extensions for integration into stdlib
	
	Function BayerMatrix:DitherMatrix<T>(size:Int, normalize:T=1.0)
		
		' Generate a Bayer dithering matrix of specified size (must be power of 2)
		' Returns integer matrix with values normalized to 0-15 range

#If __DEBUG__
		If size>64 Return Null 'protects against exploit
#Endif
		
		' Validate size is power of 2
		If size & (size - 1) <> 0
			Print "Warning: Bayer matrix size should be power of 2"
			
			' Find nearest power of 2
			Local p:Int = 1
			While p < size
				p *= 2
			Wend
			size = p
		End
	
		' Calculate actual matrix dimension (size parameter might not be dimension)
		Local dimension:Int = size
		
		' Initialize matrix
		Local matrix:Int[] = New Int[dimension * dimension]
		
		' Calculate log2 of dimension for bit operations
		Local log2Dim:Int = 0
		Local temp:Int = dimension
		While temp > 1
			temp = temp Shr 1
			log2Dim += 1
		Wend
		
		For Local y:Int = 0 Until dimension
			For Local x:Int = 0 Until dimension
				Local value:Int = 0
				
				' Bayer bit-interleaving algorithm
				For Local bit:Int = 0 Until log2Dim
					' Extract bits from coordinates
					Local xBit:Int = (x Shr bit) & 1
					Local yBit:Int = (y Shr bit) & 1
					
					' Monkey2-compatible bit manipulation (no xor operator)
					Local notEqual:Int = 0
					If (xBit = 1 And yBit = 0) Or (xBit = 0 And yBit = 1) Then notEqual = 1
					
					' Shift and set bits
					value = value Shl 1
					value = value | notEqual
				Next
				
				' Scale value to range (0 to normalize)
				' Note: 2^(2*log2Dim) equals dimension*dimension
				Local maxValue:Int = (1 Shl (log2Dim * 2)) - 1
				
				' Avoid division by zero
				If maxValue > 0
					matrix[y * dimension + x] = (value * normalize) / maxValue
				Else
					matrix[y * dimension + x] = 0  ' Fallback for 1x1 matrix
				End
			Next
		Next
		
		Return New DitherMatrix<T>(dimension, dimension, matrix, normalize)
	End
	
	Function HalftoneMatrix:DitherMatrix<T>(size:Int, normalize:T=1.0)
		
		' Generate a radial halftone matrix of specified size
		' with integer thresholds (0-15 range)

#If __DEBUG__		
		If size>64 Return Null 'protects against exploit
#endif
		
		' Calculate actual matrix dimension (square root of size)
		Local dimension:Int = Int(Sqrt(Float(size)))
		
		' Ensure dimension is at least 2
		If dimension < 2 dimension = 2
		
		' Initialize matrix
		Local matrix:Int[] = New Int[dimension * dimension]
		Local center:Float = Float(dimension - 1) / 2.0
		
		' Calculate maximum distance (corner to center)
		Local maxDistance:Float = Sqrt(center * center + center * center)
		
		' Avoid division by zero
		If maxDistance < 0.001 maxDistance = 0.001
		
		For Local y:Int = 0 Until dimension
			For Local x:Int = 0 Until dimension
				' Calculate distance from center
				Local dx:Float = Float(x) - center
				Local dy:Float = Float(y) - center
				
				' Normalized distance (0-1 range)
				Local distance:Float = Sqrt(dx * dx + dy * dy) / maxDistance
				
				' Invert and scale to 0-normalize range
				' Higher values at center (furthest from corners)
				Local value:Int = Int((1.0 - distance) * normalize)
				
				' Ensure value is within range
				value = Max(0, Min(Int(normalize), value))
				
				' Store in the matrix
				matrix[y * dimension + x] = value
			Next
		Next
		
		Return New DitherMatrix<T>(dimension, dimension, matrix, normalize)
	End
End 
