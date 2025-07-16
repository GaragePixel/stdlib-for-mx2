Namespace stdlib.syntax.truncs

'#Import "../../../types/types"

Using std.types

Function Trunc<T>:T(x:T)
	' For example, it returns 20 for 20.45
	If x > 0
		Return Floor(x)
	End
	Return Ceil(x)
End	
