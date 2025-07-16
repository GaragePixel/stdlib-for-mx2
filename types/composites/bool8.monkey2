
Namespace stdlib.types.bool8

' Added 2024 by iDkP from GaragePixel

'------------------------------------------------ Logical: Bool8 (and old Bool type)

'#Import "../types"

'#Import "../../types/bools.monkey2"

'#Import "../../syntax/aliases/prefixes.monkey2"

Using stdlib.types.bools

Using stdlib.aliases.prefixes

Private 

#rem monkeydoc hidden
#end 
Function Xor:Bool(a:Bool,b:Bool)
	' Quick fix, Kludge
	Return Not a=b
End 

Public 

#rem monkeydoc Convenience type alias for Stack\<Bool8\>.
#end
Alias Bool8Stack:Stack<Bool8> 'Added ïDkP 2025-07-09!

'---------------------- Logical Gates

'Logical operators, in Infix notation:
'
'	Builded-in: 
'		Not, And, Or, ~
'	Added in Aida.std: 
'		Logical operators:
'			Eq, Not, And, Or, 'Versions for Bool8
'			Nand, Nand, Imply, Cimply,
'			Xnor,
'			Nor, Nymply, Cnymply, 
'			Mux, Demux
'			Sugar:
'				Xor

' Quick true table for two entries, overview:
'
'	Input		Output
'	A	B		AND		NAND	OR		NOR		XOR		XNOR	IMPLY	NYMPLY	CYMPLY	CNYMPLY
'	0	0		0		1		0		1		0		1		1		0		1		0
'	0	1		0		1		1		0		1		0		1		0		0		1
'	1	0		0		1		1		0		1		0		0		1		1		0
'	1	1		1		0		1		0		0		1		1		0		1		0
'
' Technical note:
'
' By use of De Morgan's laws, an AND function is identical to an OR function 
' with negated inputs and outputs. 
' Likewise, an OR function is identical to an AND function 
' with negated inputs and outputs. 
' A NAND gate is equivalent to an OR gate with negated inputs
' and a NOR gate is equivalent to an AND gate with negated inputs.
'
' Sources:
'
'	These wikipedia articles helps me to test the code of this library:
'		https://en.wikipedia.org/wiki/Truth_table
'		https://en.wikipedia.org/wiki/AND_gate
'		https://en.wikipedia.org/wiki/NAND_logic
'		https://en.wikipedia.org/wiki/XOR_gate
'		https://en.wikipedia.org/wiki/XNOR_gate
'		https://en.wikipedia.org/wiki/IMPLY_gate
'		https://en.wikipedia.org/wiki/NIMPLY_gate
'		https://en.wikipedia.org/wiki/Converse_nonimplication
' 		https://en.wikipedia.org/wiki/Infix_notation
'		https://en.wikipedia.org/wiki/Reverse_Polish_notation
'
' Truth tables:
'
'Not operator (invertion):
	' 0 1
	' 1 0
'And operator (conjunction):
	' 0,0 0
	' 0,1 0
	' 1,0 0
	' 1,1 1
'Or operator (disjunction):
	' 0,0 0
	' 0,1 1
	' 1,0 1
	' 1,1 1
'Nand operator (alternative denial):
	' 0,0 1
	' 0,1 1
	' 1,0 1
	' 1,1 0
'Nand with 3 entries:
	' 0,0,0 1
	' 0,0,1 0
	' 0,1,0 0
	' 0,1,1 1
	' 1,0,0 0
	' 1,0,1 1
	' 1,1,0 1
	' 1,1,1 0
'Nor operator (joint denial):
	' 0,0 1
	' 1,1 0
	' 1,0 0
	' 0,1 0
'Xor operator (exclusive or):
	' 0,0 0
	' 1,1 1
	' 1,0 1
	' 0,1 0
'Xnor operator (biconditional):
	' 0,0 1
	' 0,1 0
	' 1,0 0
	' 1,1 1
'Imply operator (implication):
	' 0,0 1
	' 0,1 1
	' 1,0 0
	' 1,1 1
'Nimply operator (non-implication):
	' 0,0 0
	' 0,1 0
	' 1,0 1
	' 1,1 0
'CImply operator (converse implication):
	' 0,0 1
	' 0,1 0
	' 1,0 1
	' 1,1 1
'Cnimply operator (converse non-implication):
	' 0,0 0
	' 0,1 1
	' 1,0 0
	' 1,1 0
'Mux (multiplexing):
	' InA 	InB		Select	Out
	' 0 	0 		0 		0
	' 0 	1 		0 		0
	' 1 	0 		0 		1
	' 1 	1 		0 		1
	' 0 	0 		1 		0
	' 0 	1 		1 		1
	' 1 	0 		1 		0
	' 1 	1 		1 		1
'Demux (demultiplexing):
	' In	Select	OutA 	OutB
	' 0 	0 		0 		0
	' 1 	0  		1 		0
	' 0 	1		0 		0
	' 1 	1		0 		1

'------------------------------------------------ Consts for data types

'C and C++ treats booleans like integers, 
'In this library, the boolean is threated as a UInt8 (UByte);
'the most little datatype possible.
'So the 2 states can to be made from a 0-255 range
'and these memory print is about 4 times more light (since
'the integer needs 4 bytes) with no extra computation cost.

Const False8:Bool8=$0
Const True8:Bool8=$1

'---------------------- Logical Gates: Bool8

' The complete boolean algebra is crucial.
' Since it was missing or very incomplete in the last implementation of the language
' under the Sibly's era, I decided to complet it and expand it to the 
' new boolean type (bool8) with a very few computations needed and the lowest memory print.
'
' Please remember that the new bool8 type is only an alias of UByte. Once declared, it
' will works like a charm, with a memory print 4 times lighter.
'
' If we use Nand(False,False) instead of Nand(False8,False8), it will works normally
' but the returned value will be 0 or 1, in the Byte data type. 
' Internally, the arguments will be implicitly casted from bool to byte. 
' If will want to compare it will a boolean, it will be again implicitly casted from byte to bool. 
' In order to avoid some few extra computation, we should keep in mind that 
' the logical gates uses only the Byte data type, alias Bool8. 
' So we should compare Nand(False8,False8)=True8, since comparing two Bytes 
' don't require any extra cost.
'
' If we want work only with the old bool type, the logical gates has the equivalent
' version for the old Bool data type, per example NandBool(False,False) who will returns a heavy int32 as boolean,
' but Nand:Bool8(False,False) will returns a light byte as boolean.

' Conversion from/to the old bool type

Function FromBool:Bool8(this:Bool)
	Return Cast<Bool8>(this)
End

Function ToBool:Bool(this:Bool8)
	Return Cast<Bool>(this)
End

Function FromBool8:Bool(this:Bool8)
	Return Cast<Bool>(this)
End

Function ToBool8:Bool8(this:Bool)
	Return Cast<Bool8>(this)
End

' Operations wrote with these functions produce a code in Infix notation.

Function Is:Bool(a:Bool8)
	'Casts to bool the state of a
	Return a=True8
End 

Function IsNot:Bool(a:Bool8)
	'Casts to bool the state of a
	Return a=False8
End 

Function Eq:Bool(a:Bool8,b:Bool8)
	'Equivalent a<->b also noted a==b
	'Precast the result to the int32 boolean
	Return Cast<Bool>(Xnor(a,b))
End

Function Eq:Bool(a:Bool,b:Bool)
	'Deprecated int32 boolean version, for the 
	'interchanges between Bool and Bool8
	Return Cast<Bool>(Xnor(a,b))
End

'#rem monkeydoc Checks if all values in a stack of bool8 are True8.
'@author iDkP from GaragePixel
'@since 2025-07-07
'@return If any value is False8, the result is False8, else True8.
'#end 
'Function All:Bool8( bools:Bool8Stack )
'	'Note: It should be handled by the Bool's All version, so 'semi-undoned'
'	Local result:Bool8 = True8
'	For Local b:=Eachin bools
'		result = And8(result,b)
'	End
'	Return result
'End

Function Eq8:Bool8(a:Bool8,b:Bool8)
	'Equivalent a<->b also noted a==b
	'Return the result as a Bool8
	Return Xnor(a,b)
End

Function Not8:Bool8(a:Bool8)
	Return a~True8 'Equivalent with Xor(a,True8)
End
Function And8:Bool8(a:Bool8,b:Bool8)
	Return a&b
End
Function Or8:Bool8(a:Bool8,b:Bool8)
	Return a|b
End
Function Nand<T>:Bool8(a:T,b:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not8(And8(a,b))
End
Function Nand<T>:Bool8(a:T,b:T,c:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not8(Xor(Xor(a,b),c))
End
Function Nor<T>:Bool8(a:T,b:T)
	' 2024 - Added by iDkP because is missing from the Mark's implementation.
	Return Not8(Or8(a,b))
End
Function Xor:Bool8(a:Int,b:Int)
	' Added by iDkP because is missing from the Mark's implementation.	
	' Sugar in order to replace the usage of " ~ "
	' Since Xor is a build-in language feature:
	Return a~b
End
Function Xor:Bool8(a:Bool8,b:Bool8)
	' Added by iDkP because is missing from the Mark's implementation.
	' The original a~b can't return a xor between two booleans explicitly (type must be integral), but why?
	' Maybe because the operator is made for general purpose (can xor between any integer), it looses the special
	' type bool. General integral purposed xor are usually not fast, the special case of the boolean-type should
	' to be treated aside.
	Return a=b? False8 Else True8 'Is a If-Then test faster than a~b?
'	Return a~b
End
Function Xnor<T>:Bool8(a:T,b:T) '↔

	' 2024 Added by iDkP because is missing from the language's features.
	' Original implementation for this library.
	'
	' Xnor with Xor-gates (code and idea originally from this library):
	'	Local Y1:=Xor((Xor(a,b)),a)
	'	Local Y2:=Xor((Xor(a,b)),b)
	'	Return Not(Xor(Y1,Y2))
	'
	' Since the tree isn't this deep, we can avoid to allocate:
	Return Not8(Xor(Xor(Xor(a,b),a),Xor(Xor(a,b),b))) 'this is the concatenated version
End
Function Mux<T>:Bool8(a:T,b:T,s:T)
	' Added 2024 by iDkP
	Return (a & Not8(s)) | (b & s)
End
Function Demux<T>:Bool8[](a:T,s:T)
	' Added 2024 by iDkP - Original work for this library
	'Return New Bool8[](Not8(Nand(Nand(a, s)), Cast<Bool8>(a)),Not8(Nand(a, s)))
	Return New Bool8[](Not8(Nand(Nand(a,s),a)),Not8(Nand(a,s)))
End
Function Imply<T>:Bool8(a:T,b:T) 'Implication →
	' Added 2024 by iDkP
	Return Not8(a | b)
End

Function Nimply<T>:Bool8(a:T,b:T) 'Non-implication →/
	' Added 2024 by iDkP
	Return Not8(Not8(a) | b)
End

Function Cimply<T>:Bool8(a:T,b:T) 'Converse ←
	' Added 2024 by iDkP
	Return Not8(b | a)
End
Function Cnimply<T>:Bool8(a:T,b:T) 'Converse /←
	' Added 2024 by iDkP
	Return Not8(Not8(b) | a)
End

#rem monkeydoc expert Returns the number of True8 values in a Stack of Bool8
@author iDkP from GaragePixel
@since 2025-07-07
@prefix _pTruth_ Normal behaviour
@prefix _pUntruth_ Inverses the result
@return Int The number of counted states
#end 
Function Truth<P>:Int( bools:Bool8Stack ) Where P=_pTruth_', _pTrue_, _pOn_...
	Local s:Int=0
	For Local n:=Eachin bools
		s+=Is(n)
	End
	Return s
End 

Function Truth<P>:Int( bools:Bool8Stack ) Where P=_pUntruth_', _pFalse_, _pOff_...
	Local s:Int=0
	For Local n:=Eachin bools
		s+=IsNot(n)
	End
	Return s
End 

#rem monkeydoc Returns the number of True8 values in a Stack of Bool8
@author iDkP from GaragePixel
@since 2025-07-07
@param untruth Inverses the result
@return Int The number of counted states
#end 
Function Truth:Int( bools:Bool8Stack, untruth:Bool8=False8 )
	Local s:Int=0
	If untruth
		For Local n:=Eachin bools
			s+=Is(n)
		End
	Else
		For Local n:=Eachin bools
			s+=IsNot(n)
		End
	End 
	Return s
End 

#rem monkeydoc Expert Average of bool values from a stack of bool8.
@author iDkP from GaragePixel
@since 2025-07-07

### Average of bool8 values from a stack of bool8:
Since the bool8 can has only two states: False8 or True8, we could say
that the average the fraction of the true values from the stack. For example,
the average of (true, true, false) is 2/3=0.6.
But it's more pratical to get a purcentage. Here the purcentage of true
values should be 66%.
- If you want the purcentage, use the argument pct=true, the function will
return a byte, since byte fit a range of a purcentage.
- If you want a fraction, keep in mind that the result will use the size
of the stack. In the example: 3. The Avr return a fraction as a Float32.
- If you just want count the number of True values in the stack, use the 
Truth function.
@prefix _pPct_ for purcentage
@prefix _pFract_ for fractional form
#end 
Function Avr8<P>:Byte( bools:Bool8Stack ) Where P=_pFastPct_
	'Only integer output
	Local s:UInt=0
	For Local n:=Eachin bools
		s+=n*100 'Bool8 is a byte, so we can compute numerically with, as for bool
	End
	Return s/bools.Length
End 

Function Avr8<P>:Byte( bools:Bool8Stack ) Where P=_pPct_
	'Handles float value as output
	Local s:Double=0
	For Local n:=Eachin bools
		s+=n*100 'Bool8 is a byte, so we can compute numerically with, as for bool
	End
	Return s/bools.Length
End

Function Avr8<P>:Float( bools:Bool8Stack ) Where P=_pFract_
	Local s:Float=0
	For Local n:=Eachin bools
		s+=n
	End
	Return s/bools.Length
End
