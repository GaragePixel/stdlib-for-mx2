
Namespace stdlib.limits

'idKp for GaragePixel
'2023-12-26

#Import "../types/aliases/bool8"
#Import "../types/composites/bool8"

Using stdlib.types
Using stdlib.types.bool8

' The 21th century's new datatype name convention (ndc)

Const Bool8Min:Bool8=False8	'True min: UBYTEMIN	'8 bit unsigned integer.
Const Bool8Max:Bool8=True8	'True max: UBYTEMAX	'8 bit unsigned integer.

Const Int16Min:Int16=SHORT_MIN					'16 bit signed integer.
Const Int16Max:Int16=SHORT_MAX					'16 bit signed integer.
Const UInt16Min:UInt16=USHORT_MIN				'16 bit unsigned integer.
Const UInt16Max:UInt16=USHORT_MAX				'16 bit unsigned integer.

#rem COMMING SOON
' Float16 (IEEE-754 half-precision) limits
Const Float16Min:Float = 5.96e-8       			'16 bit Float16 Smallest positive denormal (2^-24)
Const Float16MinNormal:Float = 6.10e-5 			'16 bit Float16 Smallest positive normal (2^-14)
Const Float16Max:Float = 65504.0       			'16 bit Float16 Largest positive finite value
Const Float16Epsilon:Float = 0.00097656 		'16 bit Float16 Smallest e where 1+e ≠ 1 (2^-10)
Const Float16Digits:Int = 3            			'16 bit Float16 Approximate decimal digits of precision

' bfloat16 (brain floating point) limits
Const BFloat16Min:Float = 1.18e-38     			'16 bit BFloat16 Smallest positive denormal (2^-126)
Const BFloat16MinNormal:Float = 1.18e-38 		'16 bit BFloat16 Smallest positive normal (2^-126)
Const BFloat16Max:Float = 3.4e+38      			'16 bit BFloat16 Largest positive finite value 
Const BFloat16epsilon:Float = 0.0078125 		'16 bit BFloat16 Smallest e where 1+e ≠ 1 (2^-7)
Const BFloat16digits:Int = 2           			'16 bit BFloat16 Approximate decimal digits of precision
#end

Const Int32Min:Int32=INT_MIN					'32 bit signed integer.
Const Int32Max:Int32=INT_MAX					'32 bit signed integer.
Const UInt32Min:UInt32=UINT_MIN					'32 bit unsigned integer.
Const UInt32Max:UInt32=UINT_MAX					'32 bit unsigned integer.
Const Float32Min:Float32=FloatMin'LONG_MIN 		'32 bit floating point.
Const Float32Max:Float32=FloatMax'LONG_MAX 		'32 bit floating point.

Const Int64Min:Int64=LONG_MIN					'64 bit signed integer.
Const Int64Max:Int64=LONG_MAX					'64 bit signed integer.
Const UInt64Min:UInt64=ULONG_MIN				'64 bit unsigned integer.
Const UInt64Max:UInt64=ULONG_MAX				'64 bit unsigned integer.
Const Float64Min:Float64=LONG_MIN 				'64 bit floating point.
Const Float64Max:Float64=LONG_MAX 				'64 bit floating point.

'From type inference for Bool8

Function MinValue<T>:T( v:T ) Where T=Bool8
	Return False8
End
Function MaxValue<T>:T( v:T ) Where T=Bool8
	Return True8
End
