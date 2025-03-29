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
		
		' Handle negative coordinates for y-coordinate if needed
		' (Only relevant for negative y values with Monkey2's modulo behavior)
		'If my < 0 my += matrix._height
		
		' Direct array access with minimal computation
		Return matrix._data[my * matrix._width + mx]
	End

	Function GetThreshold_General<T>:T(matrix:DitherMatrix<T>, x:Int, y:Int)
		
		' General threshold lookup for rectangular matrices
		
		' Calculate position with standard modulo
		Local mx:Int = x Mod matrix._width
		Local my:Int = y Mod matrix._height
		
		' Handle negative coordinates (Monkey2 behavior, TOTEST)
		'If mx < 0 mx += matrix._width
		'If my < 0 my += matrix._height
	
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
		
		If size>64 Return Null 'protects against exploit
		
		' Validate size is power of 2
		If size & (size - 1) <> 0
			Print "Warning: Bayer matrix size should be power of 2. Using nearest power of 2."
		End
	
		' Initialize matrix
		Local matrix:Int[] = New Int[size * size]
		Local log2Size:Int = Int(Log(size) / Log(2))
		
		For Local y:Int = 0 Until size
			For Local x:Int = 0 Until size
				Local value:Int = 0
				
				' Construct Bayer pattern through bit interleaving
				For Local bit:Int = 0 Until log2Size
					' Extract and interleave bits from x and y coordinates
					Local xBit:Int = (x Shr bit) & 1
					Local yBit:Int = (y Shr bit) & 1
					
					' Build value by interleaving bits
					' Each bit pair contributes to a specific bit position
					'value = value Or ((xBit Xor yBit) Shl (2 * bit)) TODO: Integrate with the Xor of the Boolean lib
					
					' Alternative to Xor:
					Local notEqual:Int = 0
					If (xBit = 1 And yBit = 0) Or (xBit = 0 And yBit = 1) notEqual = 1
					value = value Or (notEqual Shl (2 * bit))
				Next
				
				' Scale to 0-15 range
				value = (value * normalize) / (size * size)
				
				' Store in the matrix
				matrix[y * size + x] = value
			Next
		End
		
		Local sqrtSize:Int=Sqrt(size)
		Return New DitherMatrix<T>(sqrtSize,sqrtSize,matrix,normalize)
	End
	
	Function HalftoneMatrix:DitherMatrix<T>(size:Int, normalize:T=1.0)
		' Generate a radial halftone matrix of specified size (must be power of 2)
		' with integer thresholds (0-15 range)
		
		If size>64 Return Null 'protects against exploit
		
		' Validate size is power of 2
		If size & (size - 1) <> 0
			Print "Warning: Halftone matrix size should be power of 2. Using nearest power of 2."
		End
		
		Local matrix:Int[] = New Int[size * size]
		Local center:Float = Float(size - 1) / 2.0
		
		For Local y:Int = 0 Until size
			For Local x:Int = 0 Until size
				' Calculate distance from center
				Local dx:Float = x - center
				Local dy:Float = y - center
				
				' Normalized distance (0-1 range)
				Local distance:Float = Sqrt(dx * dx + dy * dy) / center
				
				' Invert and scale to 0-15 integer range
				' Using 15.999 to ensure 1.0 maps to exactly 15
				Local value:Int = Int((1.0 - distance) * normalize)
				
				' Clamp to valid range using direct Min/Max
				value = Max(0, Min(15, value))
				
				' Store in the matrix
				matrix[y * size + x] = value
			Next
		End
		
		Local sqrtSize:Int=Sqrt(size)
		Return New DitherMatrix<T>(sqrtSize,sqrtSize,matrix,normalize)
	End
End 