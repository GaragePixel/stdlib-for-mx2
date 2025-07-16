
Namespace stdlib.types

'------------------------------------------------ Explicite type conversions

' iDkP from GaragePixel
' 2024.12

' Explicite type conversions in the Infix notation.
'
' Important note:
' Until the code editor don't edit the word's cases, it should
' be works. If you use a code editor that will reconize the function's names as
' keyword of the language (that's not the case), these function's names
' will be auto-modified and will trigs an error compile-time. If you choose to
' made your code editor reconize this function's name as a keyword,
' you should may grey this functions family.
' Anyway please avoid to use the explicite type conversion toward 
' these aliases as much as possible or made your code editor ignores these
' function's names (it's okay if your code editor colorize specificaly the aliases
' without changing the cases).

Function uint8<T>:UInt8(n:T)
	'Explicite type conversion in the Infix notation.
	Return Cast<UInt8>(n)
End

Function uint16<T>:UInt16(n:T)
	'Explicite type conversion in the Infix notation.
	Return Cast<UInt16>(n)
End

Function uint32<T>:UInt32(n:T)
	'Explicite type conversion in the Infix notation.
	Return Cast<UInt32>(n)
End

Function uint64<T>:UInt64(n:T)
	'Explicite type conversion in the Infix notation.
	Return Cast<UInt64>(n)
End

Function float64<T>:Float64(n:T)
	'Explicite type conversion in the Infix notation.
	Return Cast<Float64>(n)
End

'Function bool8<T>:Bool8(n:T) 'FIXME: Duplicate identifier 'bool8' is it because bool8=ubyte?
'	'Explicite type conversion in the Infix notation.
'	Return Cast<Bool8>(n)
'End

