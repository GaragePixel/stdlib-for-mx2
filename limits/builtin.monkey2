
Namespace stdlib.limits

'Minilibrary: Limits
'iDkP For GaragePixel
'2007-2021-2025

#rem
| Type    | Bits | Signed | Floating Point | Typical C Mapping   |
|---------|------|--------|----------------|---------------------|
| Int     | 32   | Yes    | No             | int32_t             |
| UInt    | 32   | No     | No             | uint32_t            |
| Short   | 16   | Yes    | No             | int16_t             |
| UShort  | 16   | No     | No             | uint16_t            |
| Long    | 64   | Yes    | No             | int64_t             |
| ULong   | 64   | No     | No             | uint64_t            |
| Byte    | 8    | Yes    | No             | int8_t              |
| UByte   | 8    | No     | No             | uint8_t             |
| Bool    | 32   | -      | -              | bool                |
| Bool8   | 8    | -      | -              | int8_t				 |
| Float   | 32   | Yes    | Yes            | float               |
| Double  | 64   | Yes    | Yes            | double              |
| LongLong| 128  | Yes    | Yes            | (Not standard type) | 
#end

Using monkey.types

' Uppercase constants are only for the Built-in datatypes

Const BYTE_MIN:Byte=-128
Const BYTE_MAX:Byte=127
Const UBYTE_MIN:UByte=0
Const UBYTE_MAX:UByte=255
Const SHORT_MIN:Short=-32768
Const SHORT_MAX:Short=32767
Const USHORT_MIN:UShort=0
Const USHORT_MAX:UShort=65535
Const INT_MIN:Int=-2147483648
Const INT_MAX:Int=2147483647
Const BOOL_MIN:Bool=INT_MIN
Const BOOL_MAX:Bool=INT_MAX
Const UINT_MIN:UInt=0
Const UINT_MAX:UInt=4294967295
Const LONG_MIN:Long=-9223372036854775808
Const LONG_MAX:Long=9223372036854775807

Const ULONG_MIN:ULong=0
Const ULONG_MAX:ULong=18446744073709551615
Const DOUBLE_MIN:Double=FloatMin'LONGMIN
Const DOUBLE_MAX:Double=FloatMax'LONGMAX
'Const SINGLE_MAX:Float="many"
'18446744073709551615
'.579999946057796478271484375 

' Soon:
' Float16 (IEEE-754 half-precision) limits
'Const FLOAT16_POSITIVE_ZERO:UShort = $0000
'Const FLOAT16_NEGATIVE_ZERO:UShort = $8000
'Const FLOAT16_POSITIVE_INFINITY:UShort = $7C00
'Const FLOAT16_NEGATIVE_INFINITY:UShort = $FC00
'Const FLOAT16_NOT_A_NUMBER:UShort = $7E00
'
' BFloat16 (Brain Floating Point) limits
'Const BFLOAT16_POSITIVE_ZERO:UShort = $0000
'Const BFLOAT16_NEGATIVE_ZERO:UShort = $8000
'Const BFLOAT16_POSITIVE_INFINITY:UShort = $7F80
'Const BFLOAT16_NEGATIVE_INFINITY:UShort = $FF80
'Const BFLOAT16_NOT_A_NUMBER:UShort = $7FC0

' LLong (composite type from Denise Amiga)
'Const LLONG_MIN:=−9223372036854775808			'Minimum value for a long long int
'Const LLONG_MAX:=+9223372036854775807 			'Maximum value for a long long int
'Const ULLONG_MIN:=0							'Minimum value for an unsigned long long int
'Const ULLONG_MAX:=+18446744073709551615		'Maximum value for an unsigned long long int

' Specials

Const CHAR_BIT:UByte=8							'Number of bits in a char
Const SCHAR_MIN:Byte=-128						'Minimum value for a signed char
Const SCHAR_MAX:Byte=+127						'Maximum value for a signed char
Const UCHAR_MIN:UByte=0							'Minimum value for an unsigned char
Const UCHAR_MAX:UByte=255						'Maximum value for an unsigned char
Const CHAR_MIN:Byte=-128					 	'Minimum value for a char
Const CHAR_MAX:Byte=+127						'Maximum value for a char

' Built-in types (the 20th century's folkloric inconsistant convention)

Const BoolMin:Bool=INT_MIN						'32 bit signed integer.
Const BoolMax:Bool=INT_MAX						'32 bit signed integer.
'or this: Const BoolMin:Bool=False				'send your preference
'or this: Const BoolMax:Bool=True				'to iDkP/GaragePixel on github!

Const ByteMin:Byte=BYTE_MIN						'8 bit signed integer.
Const ByteMax:Byte=BYTE_MAX						'8 bit signed integer.
Const UByteMin:UByte=UBYTE_MIN					'8 bit unsigned integer.
Const UByteMax:UByte=UBYTE_MAX					'8 bit unsigned integer.
Const ShortMin:Short=SHORT_MIN					'16 bit signed integer.
Const ShortMax:Short=SHORT_MAX					'16 bit signed integer.
Const UShortMin:UShort=USHORT_MIN				'16 bit unsigned integer.
Const UShortMax:UShort=USHORT_MAX				'16 bit unsigned integer.
Const IntMin:Int=INT_MIN						'32 bit signed integer (is it unsigned?)
Const IntMax:Int=INT_MAX						'32 bit signed integer (is it unsigned?)
Const UIntMin:UInt=UINT_MIN						'32 bit unsigned integer.
Const UIntMax:UInt=UINT_MAX						'32 bit unsigned integer.
Const FloatMin:Long=10*Exp(-38)					'32 bit signed float.
Const FloatMax:ULong=3*10*Exp(38)				'32 bit signed float.
Const DoubleMin:Long=DOUBLE_MIN					'32 bit signed float (TESTME)
Const DoubleMax:Long=DOUBLE_MAX					'32 bit signed float (TESTME)
Const LongMin:Long=LONG_MIN						'64 bit signed integer.
Const LongMax:Long=LONG_MAX						'64 bit signed integer.
Const ULongMin:ULong=ULONG_MIN					'64 bit unsigned integer.
Const ULongMax:ULong=ULONG_MAX					'64 bit unsigned integer.

' LLong (composite type from Denise Amiga)
'Const LLongMin:=LLONG_MIN						'Minimum value for a long long int
'Const LLongMax:=LLONG_MAX			 			'Maximum value for a long long int
'Const ULLongMin:=ULLONG_MIN					'Minimum value for an unsigned long long int
'Const ULLongMax:=ULLONG_MAX					'Maximum value for an unsigned long long int

' Specials

Const CharBit:UByte=CHAR_BIT					'Number of bits in a char
Const SCharMin:Byte=SCHAR_MIN					'Minimum value for a signed char
Const SCharMax:Byte=SCHAR_MAX					'Maximum value for a signed char
Const UCharMin:Byte=UCHAR_MIN					'Minimum value for an unsigned char
Const UCharMax:Byte=UCHAR_MAX					'Maximum value for an unsigned char
Const CharMin:Byte=CHAR_MIN					 	'Minimum value for a char
Const CharMax:Byte=CHAR_MAX						'Maximum value for a char

' Other Datatypes (the 20th century's folkloric inconsistant convention)

Const Binary16Min:Double=HalfMin 				'16 bit floating point.
Const Binary16Max:Short=HalfMax 				'16 bit floating point.
Const HalfMin:Double=5/96*10*Exp(-8)		 	'16 Bit floating point
Const HalfMax:Short =UShortMax 					'16 Bit floating point
Const WordMin:Double=SHORT_MIN 					'16 bit microsoft's word.
Const WordMax:Double=SHORT_MAX 					'16 bit microsoft's word.
Const SingleMin:ULong=FloatMin 					'32 bit signed integer.
Const SingleMax:ULong=FloatMax 					'32 bit unsigned integer.
Const Binary32Min:ULong=FloatMin 				'32 bit floating point.
Const Binary32Max:ULong=FloatMax 				'32 bit floating point.
Const DWordMin:Double=INT_MIN 					'32 bit microsoft's word.
Const DWordMax:Double=INT_MAX 					'32 bit microsoft's word.
Const Binary64Min:ULong=DoubleMin-Abs(DoubleMin)'64 bit floating point.
Const Binary64Max:ULong=DoubleMax*2				'64 bit floating point.

'By type inferences (it will works for each aliases too)

Function MinValue<T>:T( v:T ) Where T=Bool
	Return BoolMin
End
Function MaxValue<T>:T( v:T ) Where T=Bool
	Return BoolMax
End

'Note: Sort of bug with Byte...

'Function MinValue<T>:T( v:T ) Where T=Byte
'	Return ByteMin
'End
'Function MaxValue<T>:T( v:T ) Where T=Byte
'	Return ByteMax
'End
'Function MinValue<T>:T( v:T ) Where T=UByte
'	Return UByteMin
'End
'Function MaxValue<T>:T( v:T ) Where T=UByte
'	Return UByteMax
'End

Function MinValue:Byte( v:Byte )' Where T=Byte
	Return ByteMin
End
Function MaxValue:Byte( v:Byte )' Where T=Byte
	Return ByteMax
End
Function MinValue:UByte( v:UByte )' Where T=UByte
	Return UByteMin
End
Function MaxValue:UByte( v:UByte )' Where T=UByte
	Return UByteMax
End

Function MinValue<T>:T( v:T ) Where T=Short
	Return ShortMin
End
Function MaxValue<T>:T( v:T ) Where T=Short
	Return ShortMax
End
Function MinValue<T>:T( v:T ) Where T=UShort
	Return UShortMin
End
Function MaxValue<T>:T( v:T ) Where T=UShort
	Return UShortMax
End

Function MinValue<T>:T( v:T ) Where T=Int
	Return IntMin
End
Function MaxValue<T>:T( v:T ) Where T=Int
	Return IntMax
End
Function MinValue<T>:T( v:T ) Where T=UInt
	Return UIntMin
End
Function MaxValue<T>:T( v:T ) Where T=UInt
	Return UIntMax
End

Function MinValue<T>:T( v:T ) Where T=Float
	Return FloatMin
End
Function MaxValue<T>:T( v:T ) Where T=Float
	Return FloatMax
End
Function MinValue<T>:T( v:T ) Where T=Double
	Return DoubleMin
End
Function MaxValue<T>:T( v:T ) Where T=Double
	Return DoubleMax
End

Function MinValue<T>:T( v:T ) Where T=Long
	Return LongMin
End
Function MaxValue<T>:T( v:T ) Where T=Long
	Return LongMax
End
Function MinValue<T>:T( v:T ) Where T=ULong
	Return ULongMin
End
Function MaxValue<T>:T( v:T ) Where T=ULong
	Return ULongMax
End
