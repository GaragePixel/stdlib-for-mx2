' Meta
' 2024-01

	'iDkP for GaragePixel
	'	Meta is a syntactic sugar that helps clarify syntax

Namespace stdlib.syntax.meta

'#Import "../../../types/types"

Using stdlib.types

Function Meta<T>:Variant(v:T)
	'Macro used to light up the syntax
	Return Cast<Variant>(v)
End 

Function Meta<T,T2>:T(v:T2)
	'Cast a type to another one
	Return Cast<T>(v)
End
