' Makevars
' 2024-01

	'iDkP for GaragePixel
	'	Allows to set a variant with an non null variable inside.

Namespace stdlib.syntax.makevars

#Import "../../../types/types"
#Import "variantcasts"

Using stdlib.types
Using stdlib.syntax.variantcasts

Function MakeVarT<T>:Variant(v:T) 
	' Sugar
	' Var type casting: Casts any type into a variant
	Return Cast<Variant>(v)
End

Function MakeVarBool:Variant()
	' Sugar
	' Create a bool and return it in a variant
	Return Cast<Variant>(Bool(False))
End

Function MakeVarBool8:Variant()
	' Sugar
	' Create a bool8 and return it in a variant
	Return Cast<Variant>(CastBool8(False8))
End

Function MakeVarInt:Variant()
	' Sugar
	' Create a int and return it in a variant
	Return Cast<Variant>(Int(0))
End

Function MakeVarUInt:Variant()
	' Sugar
	' Create a uint and return it in a variant
	Return Cast<Variant>(UInt(0))
End

Function MakeVarFloat:Variant()
	' Sugar
	' Create a float and return it in a variant
	Return Cast<Variant>(Float(0.0))
End

Function MakeVarDouble:Variant()
	' Sugar
	' Create a double and return it in a variant
	Return Cast<Variant>(Double(0.0))
End

Function MakeVarByte:Variant()
	' Sugar
	' Create a byte and return it in a variant
	Return Cast<Variant>(Byte(0))
End

Function MakeVarUByte:Variant()
	' Sugar
	' Create a ubyte and return it in a variant
	Return Cast<Variant>(UByte(0))
End

Function MakeVarShort:Variant()
	' Sugar
	' Create a short and return it in a variant
	Return Cast<Variant>(Short(0))
End

Function MakeVarUShort:Variant()
	' Sugar
	' Create a ushort and return it in a variant
	Return Cast<Variant>(UShort(0))
End
	
Function MakeVarLong:Variant()
	' Sugar
	' Create a long and return it in a variant
	Return Cast<Variant>(Long(0))
End

Function MakeVarULong:Variant()
	' Sugar
	' Create a ulong and return it in a variant
	Return Cast<Variant>(ULong(0))
End

Function MakeVarString:Variant()
	' Sugar
	' Create a string and return it in a variant
	Return Cast<Variant>(String(""))
End

Function MakeVarCString:Variant()
	' Sugar
	' Create a cstring and return it in a variant
	Return Cast<Variant>(CString(""))
End

Function MakeVarObject:Variant()
	' Sugar
	' Create a Object and return it in a variant
	Return Cast<Variant>(New Object)
End
