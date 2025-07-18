
Namespace stdlib.syntax

#rem monkeydoc @pro It's the ternary but function styled.
@author iDkP from GagagePixel
@since 2025-07-18
@param eval/state: any values not null
@param callbackTrue/options1 evaluated/stated variable returned if eval/state is not null
@param callbackFalse/options2 evaluated/stated variable returned if eval/state is not null
@return If val is not null/false, returns callbackTrue/option1's value
@return If val is null/false, returns the callbackFalse/option2's value
@example
	Local myValue:=IfElse(evalThis,thenDoReturnThat,elseDoReturnThat)
#end 
Function IfElse<T>:T( eval:T(),callbackTrue:T(),callbackFalse:T()=Null ) 
	If eval Return callbackTrue()
	Return callbackFalse()
End 

Function IfElse<T>:T( eval:T(),option1:T,option2:T=Null ) 
	If eval Return option1
	Return option2
End 

Function IfElse<T>:T( state:T,option1:T,option2:T=Null ) 
	If eval Return option1
	Return option2
End 

