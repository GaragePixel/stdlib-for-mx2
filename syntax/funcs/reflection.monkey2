' MiniLib: Reflection

#rem - Test:

Struct Obj
End 

Function Main()
	
	Local po:=Pointer( New Obj )
	Print TypeofPointer( po )
	Print GetType( po )

'	Output:
'
'	Obj
'	Obj Ptr	
End 
#end

Namespace stdlib.syntax.reflection

'#Import "<reflection>"

'Using reflection 'TOINTEGRATE

Function TypeofPointer<T>:String(v:T Ptr)

	' Get the basename of the referenced typeof v
	'
	' Fact:
	'	This code is the literal translation of:
	'	'Est retourné le type de la valeur v référencée'.
	
	Return Typeof(v[0])
End

Function GetType<T>:String(v:T)
	
	' Missing in the original reflection module, a simple way
	' to get the type of a datatype.

	'	Usage example #1 (without the Meta type):
	'		Select GetType(Cast<Variant>(v)))
	'			Case "Int"
	'				' ...Do that...
	'			Case "Float"
	'				' ...Do that... 
	'		End
	'
	'	Usage example #2 (using the Meta type):
	'		Select GetType(Meta(v))
	'			Case "Int"
	'				' ...Do that...
	'			Case "Float"
	'				' ...Do that... 
	'		End

	Return (Cast<Variant>(v)).Type
End 
