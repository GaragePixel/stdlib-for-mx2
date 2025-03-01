
Namespace stdlib.crypto.hashing.utils

Function Hex:String(val:UInt)
	Local hex:=("00000000"+stringio.ULongToString(val,16)).Right(8)
	Return hex
End Function
 
Function Rol:UInt(val:UInt, shift:Int)
	Return (val Shl shift) | (val Shr (32 - shift))
End Function
 
Function Ror:UInt(val:UInt, shift:Int)
	Return (val Shr shift) | (val Shl (32 - shift))
End Function

'Jesse: should this be an operator?
'iDkP: Nice sugar^^
Function UShr:UInt(val:UInt, shift:Int)
	Return val Shr shift
End
 
Function LEHex:String(val:UInt)
	Local out:String = Hex(val)
	Return out.Slice(6,8) + out.Slice(4,6) + out.Slice(2,4) + out.Slice(0,2)
End Function