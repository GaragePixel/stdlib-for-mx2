'Pointers
'iDkP for GaragePixel
'	These sugars are inspirated from the c++'s stdio library
'	added in a attempt to make the code more pretty, the pointers less visible.
'
'	Note:
'		PInt defined in config

Namespace stdlib.syntax.pointers

'#Import "../../config"

Using stdlib.config

' Pointer/Ref nomenclature

Function Pointer:Object Ptr(this:Object)
	Return Varptr( this )
End 

Function Pointer<T>:T Ptr(this:T)
	Return Varptr( this )
End 

Function Ref<T>:T(v:T Ptr)
	' Sugar which avoids to use the statement p[0] 
	' Get the value of the referenced variable v
	Return v[0]
End 

Function Ref<T>:T(v:T Ptr, idx:PInt)
	' Sugar which allows to get the value of type T in the referenced variable v, same type
	Return (Varptr v[0])[idx]
End 
		
Function Ref:Variant(v:Variant Ptr)
	' Sugar which avoids to use the statement p[0] 
	' Get the variant inside the referenced variant
	Return v[0]
End 

' Read/Assign nomenclature		

Function Read<T>:T(v:T Ptr)
	' Sugar which avoids to use the statement p[0] 
	' (same that Ref)
	Return v[0]
End 

Function Read<T>:T(v:T Ptr[])
	' Sugar which avoids to use the statement p[0][0]
	Return v[0][0]
End 

Function Read<T>:T(v:T Ptr, idx:PInt)
	' Sugar which allows to get the value of type T in the referenced variable v, same type
	Return (Varptr v[0])[idx]
End 
		
Function Read:Variant(v:Variant Ptr)
	' Sugar which avoids to use the statement p[0] 
	' Get the variant inside the referenced variant
	Return v[0]
End 
		
Function Assign<T>(p:T Ptr, v:T)
	' Sugar which allows to assign a value of type T to a pointer of the same type
	p[0]=v
End
		
Function Assign(p:Variant Ptr, v:Variant)
	' Sugar which allow to assign a variant to a variant reference 
	p[0]=v
End	

Function Assign<T>(p:Variant Ptr, idx:PInt ,v:T)
	'Sugar which allow to assign a value of type T to an array of same type 
	'in a variant pointed by its reference
	(Varptr p[0])[idx]=v
End	
