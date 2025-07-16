
Namespace stdlib.types.bools

' Added 2024 by iDkP from GaragePixel

'------------------------------------------------ Logical: Bool

'#Import "types"

'#Import "../syntax/aliases/prefixes.monkey2"

Using stdlib.aliases.prefixes

#rem monkeydoc Convenience type alias for Stack\<Bool\>.
#end
Alias BoolStack:Stack<Bool> 'Added iDkP 2025-07-09!

#rem monkeydoc Convenience type alias for Array\<Bool\>.
#end
Alias BoolArray:Bool[] 'Added iDkP 2025-07-09!

'---------------------- Utils: Old Bool type

Function Is:Bool(a:Bool)
	'Deprecated int32 boolean version, for the reciprocal
	Return a=True
End 

Function Eq:Bool(a:Bool,b:Bool)
	'Deprecated int32 boolean version, for the reciprocal
	'Equivalent a<->b also noted a==b
	Return a=b
End

#rem monkeydoc Checks if all values in a set of booleans are true.
@author iDkP from GaragePixel
@since 2025-07-07
@return If any value is false, the result is false, else true.
#end
Function All:Bool( bools:BoolStack )
	Local result:Bool = True
	For Local b:=Eachin bools
		result = result And b
	End
	Return result
End

Function All<T>:Bool( elements:Stack<T> )
	Local result:Bool = True
	Local state:Bool = False
	For Local b:=Eachin elements
		state = b ? True Else False
		result = state And b
	End
	Return result
End

Function All<T>:Bool( elements:List<T> )
	Local result:Bool = True
	Local state:Bool = False
	For Local b:=Eachin elements
		state = b ? True Else False
		result = state And b
	End
	Return result
End

Function All<T>:Bool( elements:T[] )
	Local result:Bool = True
	Local state:Bool = False
	For Local b:=0 Until elements.Length-1
		state = elements[b] ? True Else False
		result = state And b
	End
	Return result
End

Function All<BoolArray>:Bool( elements:BoolArray )
	Local result:Bool = True
	Local state:Bool = False
	For Local b:=0 Until elements.Length-1
		result = result And elements[b]
	End
	Return result
End

'---------------------- Logical Gates: Old Bool type

' Algebra extended to the old boolean type of the then-Sibly's era.
' Of course the old boolean type is hightly deprecated in favor of bool8.

Function NandBool<T>:Bool(a:T,b:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not(a And b)
End
Function NandBool<T>:Bool(a:T,b:T,c:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not(XorBool(XorBool(a,b),c))
End
Function NorBool<T>:Bool(a:T,b:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not(a Or b)
End
'Function Xor<T>:Bool(a:T,b:T) 'TODO (avoid collision with UBYTE/Bool8 by making each types manually
'	' Added by iDkP because is missing from the Mark's implementation.	
'	' Sugar in order to replace the stupid usage of " ~ "
'	' We can cast int, float, short, double and long
'	' My original implementation:
'	'	Return Xor(Bool(a),Bool(b))
'	Return a~b
'End
Function XorBool:Bool(a:Int,b:Int)
	' Added by iDkP because is missing from the Mark's implementation.	
	' Sugar in order to replace the usage of " ~ "
	' the old Bool type is deprecated, so XorBool is a special function's name
	' in order to avoid the duplicated declaration of Xor with Bool8
	' Since Xor is a build-in language feature:
	Return a~b
End
Function Xor:Bool(a:Bool,b:Bool)
	' Added by iDkP because is missing from the Mark's implementation.
	' The original a~b can't return a xor between two booleans explicitly (type must be integral), but why?
	' Maybe because the operator is made for general purpose (can xor between any integer), it looses the special
	' type bool. General integral purposed xor are usually not fast, the special case of the boolean-type should
	' to be treated aside.
'	Return a=b? False Else True 'Is a If-Then test faster than a~b?
'	Return a~b
	Return Not a=b
End
Function XnorBool<T>:Bool(a:T,b:T) '↔

	' 2024 Added by iDkP because is missing from the language's features.
	' Original implementation for this library.
	'
	' Xnor with Xor-gates (code and idea originally from this library):
	'	Local Y1:=Xor((Xor(a,b)),a)
	'	Local Y2:=Xor((Xor(a,b)),b)
	'	Return Not(Xor(Y1,Y2))
	'
	' Since the tree isn't this deep, we can avoid to allocate:
	Return Not(XorBool(XorBool(XorBool(a,b),a),XorBool(XorBool(a,b),b))) 'this is the concatenated version
End
Function MuxBool<T>:Bool(a:T,b:T,s:T)
	' Added 2024 by iDkP
	Return (a And Not(s)) Or (b And s)
End
Function DemuxBool<T>:Bool[](a:T,s:T)
	' Added 2024 by iDkP - Original work for this library
	Return New Bool[](Not NandBool(NandBool(a, s), a),Not NandBool(a, s) )
End
Function ImplyBool<T>:Bool(a:T,b:T) 'Implication →
	' Added 2024 by iDkP
	Return Not a Or b
End

Function NimplyBool<T>:Bool(a:T,b:T) 'Non-implication →/
	' Added 2024 by iDkP
	Return Not(Not(a) Or b)
End

Function CimplyBool<T>:Bool(a:T,b:T) 'Converse ←
	' Added 2024 by iDkP
	Return Not b Or a
End
Function CnimplyBool<T>:Bool(a:T,b:T) 'Converse /←
	' Added 2024 by iDkP
	Return Not(Not(b) Or a)
End

#rem monkeydoc expert Returns the number of True values in a Stack of Bool
@author iDkP from GaragePixel
@since 2025-07-07
@prefix _pTruth_ Normal behaviour
@prefix _pUntruth_ Inverses the result
@return Int The number of counted states
#end 
Function Truth<P>:Int( bools:Stack<Bool> ) Where P=_pTruth_'_pTruth_, _pTrue_, _pOn_...
	Local s:Int=0
	For Local n:=Eachin bools
		s+=n
	End
	Return s
End 

Function Truth<P>:Int( bools:Stack<Bool> ) Where P=_pUntruth_'_pUntruth_, _pFalse_, _pOff_...
	Local s:Int=0
	For Local n:=Eachin bools
		s+=Not n
	End
	Return s
End  

#rem monkeydoc Returns the number of True values in a Stack of Bool
@author iDkP from GaragePixel
@since 2025-07-07
@param untruth Inverses the result
@return Int The number of counted states
#end 
Function Truth:Int( bools:Stack<Bool>, untruth:Bool=False )
	Local s:Int=0
	If untruth
		For Local n:=Eachin bools
			s+=Not n
		End
	Else
		For Local n:=Eachin bools
			s+=n
		End
	End 
	Return s
End
