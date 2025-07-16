
Namespace stdlib.syntax.variantcasts

' Variant castings
' 2024-01

	'iDkP for GaragePixel
	'	These sugars casts the internal defined types into variant.

#Import "../../../types/builtin"

Using stdlib.types

Function CastVariant<T>:Variant(v:T)
	' Sugar
	' Casts a type into type Variant
	' Equivalent to Cast<Variant>(v)
	Return Cast<Variant>(v)
End

Function CastBool:Bool(v:Variant)
	' Sugar
	' Casts a variant into type Bool
	' Equivalent to Bool(v)
	Return Cast<Bool>(v)
End

Function CastBool8:Bool8(v:Variant)
	' Sugar
	' Casts a variant into type Bool8
	' Equivalent to Bool8(v)
	Return Cast<Bool8>(v)
End

Function CastInt:Int(v:Variant)
	' Sugar
	' Casts a variant into type Int
	' Equivalent to Int(v)
	Return Cast<Int>(v)
End

Function CastUInt:UInt(v:Variant)
	' Sugar
	' Casts a variant into type Int
	' Equivalent to Int(v)
	Return Cast<UInt>(v)
End

Function CastFloat:Float(v:Variant)
	' Sugar
	' Casts a variant into type float
	' Equivalent to Float(v)
	Return Cast<Float>(v)
End

Function CastDouble:Double(v:Variant)
	' Sugar
	' Casts a variant into type double
	' Equivalent to Double(v)
	Return Cast<Double>(v)
End

Function CastShort:Short(v:Variant)
	' Sugar
	' Casts a variant into type short
	' Equivalent to Short(v)
	Return Cast<Short>(v)
End

Function CastUShort:UShort(v:Variant)
	' Sugar
	' Casts a variant into type ushort
	' Equivalent to UShort(v)
	Return Cast<UShort>(v)
End

Function CastLong:Long(v:Variant)
	' Sugar
	' Casts a variant into type long
	' Equivalent to Long(v)
	Return Cast<Long>(v)
End

Function CastULong:ULong(v:Variant)
	' Sugar
	' Casts a variant into type ulong
	' Equivalent to ULong(v)
	Return Cast<ULong>(v)
End

Function CastString:String(v:Variant)
	' Sugar
	' Casts a variant into type String
	' Equivalent to String(v)
	Return Cast<String>(v)
End

Function CastCString:CString(v:Variant)
	' Sugar
	' Casts a variant into type CString
	' Equivalent to CString(v)
	Return Cast<CString>(v)
End

' Cast Variant Array type

Function CastBool:Int(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Bool[] and return the value from the index
	' Equivalent to Cast<Bool>((Varptr v)[idx])
	Return Cast<Bool>(v[idx])
End

Function CastBool8:Int(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Bool8[] and return the value from the index
	' Equivalent to Cast<Bool8>((Varptr v)[idx])
	Return Cast<Bool8>(v[idx])
End

Function CastInt:Int(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Int[] and return the value from the index
	' Equivalent to Cast<Int>((Varptr v)[idx])
	Return Cast<Int>(v[idx])
End

Function CastUInt:UInt(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type UInt[] and return the value from the index
	' Equivalent to Cast<UInt>((Varptr v)[idx])
	Return Cast<UInt>(v[idx])
End

Function CastFloat:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Float[] and return the value from the index
	' Equivalent to Cast<Float>((Varptr v)[idx])
	Return Cast<Float>(v[idx])
End

Function CastDouble:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Double[] and return the value from the index
	' Equivalent to Cast<Double>((Varptr v)[idx])
	Return Cast<Double>(v[idx])
End

Function CastShort:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Short[] and return the value from the index
	' Equivalent to Cast<Short>((Varptr v)[idx])
	Return Cast<Short>(v[idx])
End

Function CastUShort:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type UShort[] and return the value from the index
	' Equivalent to Cast<UShort>((Varptr v)[idx])
	Return Cast<UShort>(v[idx])
End

Function CastLong:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type Long[] and return the value from the index
	' Equivalent to Cast<Long>((Varptr v)[idx])
	Return Cast<Long>(v[idx])
End

Function CastULong:Float(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type ULong[] and return the value from the index
	' Equivalent to Cast<ULong>((Varptr v)[idx])
	Return Cast<ULong>(v[idx])
End

Function CastString:String(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type String[] and return the value from the index
	' Equivalent to Cast<String>((Varptr v)[idx])
	Return Cast<String>(v[idx])
End

Function CastCString:CString(v:Variant Ptr, idx:PInt)
	' Sugar
	' Casts a variant into type CString[] and return the value from the index
	' Equivalent to Cast<CString>((Varptr v)[idx])
	Return Cast<CString>(v[idx])
End
