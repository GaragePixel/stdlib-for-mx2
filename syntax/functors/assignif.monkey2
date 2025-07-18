
Namespace stdlib.syntax

#rem monkeydoc @pro Assigns something if not null.
@author iDkP from GagagePixel
@since 2025-07-18
If callback_NotNull is null, target's value is left intact
So, instead of to write the content of this function in-code,
we can just wrote AssignIf(eval(),Varptr(myVar))
#end 
Function AssignIf<T>( callback_NotNull:T(),target:T Ptr )
	Local result:=callback_NotNull()
	If result target[0] = result
End 

#rem monkeydoc @pro Assigns something if not null or false.
@author iDkP from GagagePixel
@since 2025-07-18
If callback_NotNull is null or false, target's value is left intact
So, instead of to write the content of this function in-code,
we can just wrote AssignIff(eval(),Varptr(myVar))
#end 
Function AssignIff<T>( callback_NotNull:T(),target:T Ptr )
	Local result:=callback_NotNull()
	If result And result<>False target[0] = result
End 
