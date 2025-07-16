
Namespace stdlib.types

Using stdlib.types.bools

#rem monkeydoc 
@author iDkP from GaragePixel
@since 2025-07-03
@example
'	Local myv1:=New Varr(10)
'	Local myv2:=New Varr("test")
	Local myv1:=TVar.Create(10)
	Print myv1.Type
	Local myv2:=TVar.Create("test")
	Print myv2.Type
	myv1.Set("monkey")
	Print myv1.Type
	Local myv1Type:=myv1.Type
	'Print "the "+myv1.Get<String>()
	'Print "the "+TVar.Get(myv1)
	Print "the "+myv1
	'Print "the "+myv1.Get()
'	Print 10+myv1.Get<Int>()
'	Print myv1.Get<Int>()+10
	myv1=TVar.Create(10)
	Print 10+Int(myv1)
	Select myv1.Type
		Case __t_int__
			Print Int(myv1)+10
		case __t_string__ 
			Print myv1
	End 
#end 

Class TVar
	Function Create<T>:TVar(v:T)
		Local out:=New TVar()
		out.Set(v)
		Return out
	End  
	Property Type:TypeInfo()
		Return _type
	Setter(type:TypeInfo) 'Allows to override the type, be careful!
		_type=type
		'TODO: Closure for SafeCast from _type
	End
	Operator To<T>:T()
		Return SafeCast<T>()
	End
	Method Set<T>(v:T)
		_value=Cast<Variant>(v)
		_type=Typeof(v)
		'TODO: Closure for SafeCast from _type
	End 
	Method SafeCast<T>:T()
		Select _type
			Case __t_bool__
				Local intermediate:=Cast<Bool>( _value )
				Return Cast<T>( intermediate )
			Case __t_int__
				Local intermediate:=Cast<Int>( _value )
				Return Cast<T>( intermediate )
			case __t_float__
				Local intermediate:=Cast<Float>( _value )
				Return Cast<T>( intermediate )
			Case __t_short__
				Local intermediate:=Cast<Short>( _value )
				Return Cast<T>( intermediate )
			Case __t_uint__
				Local intermediate:=Cast<UInt>( _value )
				Return Cast<T>( intermediate )
			Case __t_ushort__
				Local intermediate:=Cast<UShort>( _value )
				Return Cast<T>( intermediate )
			Case __t_double__
				Local intermediate:=Cast<Double>( _value )
				Return Cast<T>( intermediate )
			Case __t_long__
				Local intermediate:=Cast<Long>( _value )
				Return Cast<T>( intermediate )
			Case __t_ulong__
				Local intermediate:=Cast<ULong>( _value )
				Return Cast<T>( intermediate )
			Case __t_string__
				Local intermediate:=Cast<String>( _value )
				Return Cast<T>( intermediate )
			Default 
				'Generic fallback for custom types
				'Direct cast since we can't enumerate all possible types
				Return Cast<T>( _value )
		End
		Return Null
	End
	Private
	Field _value:Variant
	Field _type:TypeInfo
End 
