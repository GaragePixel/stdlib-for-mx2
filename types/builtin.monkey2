
Namespace stdlib.types

#rem monkeydoc MiniLibrary: builtintypes
@author idKp for GaragePixel
@since 2025-06-17
@source Announced at: https://discord.com/channels/796336780302876683/799786578746015756/1384257668834922497

The main objective of stdlib.types allows dispatching via integer IDs who is an order of magnitude faster
than string-based reflection.

Sometimes, in pure meta-programming, we need to initialize a lambda with a null of a certain type.
Since in Monkey2/Wonkey we can't create an instance of a type as argument in a lambda,
we have to declare a type of something null every time from the exterior.
If we use `__UInt__`, for example, we don't have to go to that trouble anymore.
	
Note:
| Type    | Bits | Signed | Floating Point | Typical C Mapping   |
|---------|------|--------|----------------|---------------------|
| Byte    | 8    | Yes    | No             | int8_t              |
| UByte   | 8    | No     | No             | uint8_t             |
| Bool8   | 8    | No     | No             | int8_t				 |
| Short   | 16   | Yes    | No             | int16_t             |
| UShort  | 16   | No     | No             | uint16_t            |
| Int     | 32   | Yes    | No             | int32_t             |
| UInt    | 32   | No     | No             | uint32_t            |
| Bool    | 32   | No     | No             | bool                |
| Long    | 64   | Yes    | No             | int64_t             |
| ULong   | 64   | No     | No             | uint64_t            |
------------------------------------------------------------------
| Float   | 32   | Yes    | Yes            | float               |
| Double  | 64   | Yes    | Yes            | double              |
| LongLong| 128  | Yes    | Yes            | (Not standard type) |

@example
```monkey
Local this:Byte=100
Select Typeof( this )
'    Case __t_ubyte__
'        Print "hello"
    Case __t_byte__
        Print "hello"
End
```
The reflection works at id level, the case `__t_ubyte__` will returns `false`,
only the exact type will be trigged.
Now d_a_n_i_l_o can complete his example: https://discord.com/channels/796336780302876683/870267572812128298/1189233435080925194
#end

' Primitive types' Interfaces:

Enum _iType_								'big endian
	__i_static__					=		$00000
		__i_unknow__				=		$00010
		__i_nil__					=		$00020
		__i_variant__				=		$00030
		__i_composite__				=		$00040
		__i_primitive__				=		$00050
			__i_nan__				=		$00250
			__i_numeric__			=		$00250
				__i_integral__		=		$01250
					__i_compact__	=		$11250
					__i_short__		=		$21250
				__i_real__			=		$02250
			__i_bool__				=		$00350
'			__i_hex__				=		$00450
			__i_string__			=		$00550
	__i_dynamic__					=		$00001
End

'SubInterface reflection

Function SuperInterfaceof:_iType_( interfaceof:_iType_ )

	Select interfaceof

		case _iType_.__i_static__, _iType_.__i_dynamic__ 'The super interface is the default (root)
			Return interfaceof

		Case _iType_.__i_nan__, _iType_.__i_bool__
			Return _iType_.__i_primitive__
			
		case _iType_.__i_integral__, _iType_.__i_real__
			Return _iType_.__i_numeric__

		case _iType_.__i_compact__, _iType_.__i_short__
			Return _iType_.__i_integral__
			
		Case _iType_.__i_numeric__
			Return _iType_.__i_primitive__

		Case _iType_.__i_primitive__, _iType_.__i_composite__
			Return _iType_.__i_dynamic__
			
		Case _iType_.__i_string__
			Return _iType_.__i_primitive__

'		Case _iType_.__i_hex__
'			Return _iType_.__i_primitive_

		Case _iType_.__i_variant__, _iType_.__i_unknow__, _iType_.__i_nil__
			Return _iType_.__i_dynamic__
			
		Default
			If interfaceof And $00001 Return _iType_.__i_dynamic__
			'TODO Reflection of custom type!
	End
	Return _iType_.__i_unknow__
End

Function Interfaceof<T>:_iType_( typeid:T )'_pType_
	Select Typeof(typeid)
		Case __Bool__
			Return _iType_.__i_bool__
		Case __Byte__	Or __Short__	Or __UByte__	Or __UShort__
			Return _iType_.__i_short__
		Case __Int__	Or __UInt__
			Return _iType_.__i_compact__
		Case __Long__	Or __ULong__
			Return _iType_.__i_integral__
		Case __Float__	Or __Double__
			Return _iType_.__i_real__
'		Case __Hex1__	Or __Hex2__		Or __Hex3__		Or __Hex4__
'			Return _iType_.__i_hex__
'		Case __Hex5__	Or __Hex6__		Or __Hex7__		Or __Hex8__
'			Return _iType_.__i_hex__
	End
	Return Null
End

' Primitive types:

' === NULLS LABELS === │ === TYPES === │ ===== ID ===== │ ====== REFLECTION ====== │ === INFO === │
'Const __Hex1__			:__t_hex1__,	__t_hex1__		:=$0						'hex8  bit  is 1 bytes
'Const __Hex2__			:__t_hex2__,	__t_hex2__		:=$00						'hex16 bits is 2 chained bytes
'Const __Hex3__			:__t_hex3__,	__t_hex3__		:=$000						'hex24 bits is 3 chained bytes
'Const __Hex4__			:__t_hex4__,	__t_hex4__		:=$0000						'hex32 bits is 4 chained bytes
'Const __Hex5__			:__t_hex4__,	__t_hex4__		:=$00000					'hex40 bits is 5 chained bytes
'Const __Hex6__			:__t_hex4__,	__t_hex4__		:=$000000					'hex48 bits is 6 chained bytes
'Const __Hex7__			:__t_hex4__,	__t_hex4__		:=$0000000					'hex56 bits is 7 chained bytes
'Const __Hex8__			:__t_hex4__,	__t_hex4__		:=$00000000					'hex64 bits is 8 chained bytes = __Int__
Const __Byte__			:Byte,			__t_byte__		:=Typeof(__Byte__)			'byte is hex's unit
Const __UByte__			:UByte,			__t_ubyte__		:=Typeof(__UByte__)
Const __Bool__			:Bool,			__t_bool__		:=Typeof(__Bool__)
Const __Int__			:Int,			__t_int__		:=Typeof(__Int__)
Const __UInt__			:UInt,			__t_uint__		:=Typeof(__UInt__)
Const __Short__			:Short,			__t_short__		:=Typeof(__Short__)
Const __UShort__		:UShort,		__t_ushort__	:=Typeof(__UShort__)
Const __Long__			:Long,			__t_long__		:=Typeof(__Long__)
Const __ULong__			:ULong,			__t_ulong__		:=Typeof(__ULong__)
Const __Float__			:Float,			__t_float__		:=Typeof(__Float__)
Const __Double__		:Double,		__t_double__	:=Typeof(__Double__)
Const __String__		:String,		__t_string__	:=Typeof(__String__)
Const __Variant__		:Variant,		__t_variant__	:=Typeof(__Variant__)

' Composite types:

Const __Complex__		:Complex,		__t_complex__	:=Typeof(__Complex__)
'Const __LongLong__		:LongLong,		__t_longlong__	:=Typeof(__LongLong__)

' --------- Aliases for the Byte Datatype Naming Convention (BDC Aliases)

' === NULLS LABELS === │ === TYPES === │ ===== ID ===== │ ====== REFLECTION ======
Const __Byte8__			:Byte,			__t_byte8__		:=Typeof(__Byte8__)		'Int8	'8 bit signed integer (sugar).
Const __UByte8__		:UByte,			__t_ubyte8__	:=Typeof(__UByte8__)	'UInt8	'8 bit unsigned integer (sugar).
Const __Byte16__		:Short,			__t_byte16__	:=Typeof(__Byte16__)	'Int16	'16 bit signed integer.
Const __UByte16__		:UShort,		__t_ubyte16__	:=Typeof(__UByte16__)	'UInt16	'16 bit unsigned integer.
Const __Byte32__		:Int,			__t_byte32__	:=Typeof(__Byte32__)	'Int32	'16 bit signed integer.
Const __UByte32__		:UInt,			__t_ubyte32__	:=Typeof(__UByte32__)	'UInt32	'32 bit unsigned integer.
Const __Byte64__		:Long,			__t_byte64__	:=Typeof(__Byte64__)	'Int64	'64 bit signed integer.
Const __UByte64__		:ULong,			__t_ubyte64__	:=Typeof(__UByte64__)	'UInt64	'64 bit unsigned integer.

' --------- Aliases for the New Datatype Naming Convention (NDC Aliases)

' === NULLS LABELS === │ === TYPES === │ ===== ID ===== │ ====== REFLECTION ======
Const __Int8__			:Byte,			__t_int8__		:=Typeof(__Int8__)
Const __UInt8__			:UByte,			__t_uint8__		:=Typeof(__UInt8__)
Const __Int16__			:Short,			__t_int16__		:=Typeof(__Int16__)		'used for the conventional/C/C++/builded-in Bool type
Const __UInt16__		:UShort,		__t_uint16__	:=Typeof(__UInt16__)
Const __Int32__			:Int,			__t_int32__		:=Typeof(__Int32__)
Const __UInt32__		:UInt,			__t_uint32__	:=Typeof(__UInt32__)
Const __Int64__			:Long,			__t_int64__		:=Typeof(__Int64__)
Const __UInt64__		:ULong,			__t_uint64__	:=Typeof(__UInt64__)
Const __Float32__		:Float,			__t_float32__	:=Typeof(__Float32__)	'float (in lowercase): C, C++, C#, Java - (Float): Haskell, Swift, Aida (Sibly-family language)
																				'Float (uppercase) refers to Float64 Python, Ruby, PHP, and OCaml
Const __Float64__		:Double,		__t_float64__	:=Typeof(__Float64__)	'Single in versions of Octave before 3.2 refer to double-precision numbers Float64

' Other types:

Const __Binary32__		:Float32,		__t_binary32__	:=Typeof(__Binary32__)
Const __Binary64__		:Float64,		__t_binary64__	:=Typeof(__Binary64__)
Const __Single__		:Float32,		__t_single__	:=Typeof(__Single__)	'Object Pascal (Delphi), Visual Basic, and MATLAB
Const __Bool8__			:UByte,			__t_bool8__		:=Typeof(__Bool8__)		'used for the lighter Bool type of this library

' Composite types:

'Const __Float16__		:Float16,		__t_float16__	:=Typeof(__Float16__)
'Const __UFloat16__		:UFloat16,		__t_ufloat16__	:=Typeof(__UFloat16__)

Const __Complex64__		:Complex64,		__t_complex64__	:=Typeof(__Complex64__)
Const __Complex128__	:Complex128,	__t_complex128__:=Typeof(__Complex128__)

#rem monkeydoc MiniLibrary: enums
@author idKp for GaragePixel
@since
#end

Enum _pType_ 'primitive types
	
	unknow					=$000
	nan						=$001
	nil						=$002 'NULL is a void pointer, nil is an id
	vary					=$003 'Variant
	
	tbyte					=$010
	tubyte					=$020
	tbool					=$030
	tint					=$040
	tuint					=$050
	tshort					=$060
	tushort					=$070
	tlong					=$080
	tulong					=$090
	tfloat					=$0A0
	tdouble					=$0B0
	tstring					=$0C0
	
	tbyte8					=tbyte
	tubyte8					=tubyte
	tbyte16					=tshort
	tubyte16				=tushort
	tbyte32					=tint
	tubyte32				=tuint
	tbyte64					=tlong
	tubyte64				=tulong
	
	tint8					=tbyte
	tuint8					=tubyte
	tint16					=tshort
	tuint16					=tushort
	tint32					=tint
	tuint32					=tuint
	tint64					=tlong
	tuint64					=tulong
	tfloat32				=tfloat
	tfloat64				=tdouble
End

Enum _Type_ ' All Types
	
	unknow			=$000
	nan				=$001
	nul				=$002
	
	tbyte			=$010
	tubyte			=$020
	tbool			=$030
	tint			=$040
	tuint			=$050
	tshort			=$060
	tushort			=$070
	tlong			=$080
	tulong			=$090
	tfloat			=$0A0
	tdouble			=$0B0
	tstring			=$0C0
	
	tbyte8			=tbyte
	tubyte8			=tubyte
	tbyte16			=tshort
	tubyte16		=tushort
	tbyte32			=tint
	tubyte32		=tuint
	tbyte64			=tlong
	tubyte64		=tulong
	
	tint8			=tbyte
	tuint8			=tubyte
	tint16			=tshort
	tuint16			=tushort
	tint32			=tint
	tuint32			=tuint
	tint64			=tlong
	tuint64			=tulong
	tfloat32		=tfloat
	tfloat64		=tdouble
	
	' Composites
	
	tfloat16		=$100
	tUfloat16		=$200
	tLongLong		=$300
	tcomplex		=$400
	tcomplex64		=tcomplex
	tcomplex128		=$500
End

Enum _CType_ ' Composed Types
	tcomplex		=$100
	tcomplex64		=tcomplex
	tcomplex128		=$200
End

Function TypeIs:Byte(type:_Type_)
	'special
	If type And $00F Return $0
	'primitive
	If type And $0F0 Return $1
	'composite
	Return $2
End

Function IsSpecialType:Bool(type:_Type_)
	Return type And $00F ? True Else False
End

Function IsPrimitiveType:Bool(type:_Type_)
	Return type And $0F0 ? True Else False
End

Function IsCompositeType:Bool(type:_Type_)
	Return type And $F00 ? True Else False
End
