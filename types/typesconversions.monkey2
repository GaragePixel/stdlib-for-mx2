
Namespace stdlib.types

'------------------------------------------------ UByte / UInt32 / ULong... conversions
	
'iDkP for GaragePixel
'2023-12-26

'TODO
'dependency: Strings
#rem

Function UBytesToUInt32:UInt( this:UByte[], depth:Int=1 )
		
	' Example:
	'	Input as UByte[]: 92854848484951484848
	'	Returns 92854848484951484848 as string
		
	If depth<>0 And depth<>1
		
		Local result:UInt
		Local acc:UInt
		
		For Local n:=0 Until this.Length/depth Step depth
			For Local k:=0 Until depth
				acc+=this[n+k]
			End 

			result+=acc
		End
		
		Return result
	End
	
	Return UInt( Strings.Get( this ) )
End 
	
Function UBytesToUInt64:ULong( this:UByte[], depth:Int=1 )
		
	' Example:
	'	Input as UByte[]: 92854848484951484848
	'	Returns 92854848484951484848 as string
		
	If depth<>0 And depth<>1
		
		Local result:ULong
		Local acc:ULong 
		
		For Local n:=0 Until this.Length/depth Step depth
			For Local k:=0 Until depth
				acc+=this[n+k]
			End
			
			result+=acc
		End 
		
		Return result
	End
	Return UInt( Strings.Get( this ) )
End 
	
Function UBytesToString:String( this:UByte[], depth:Int=1 )
		
	' Example:
	'	Input as UByte[]: 92854848484951484848
	'	Returns 92854848484951484848 as string
		
	If depth<>0 And depth<>1 Return String( UBytesToUInt32( this,depth ) )
	Return Strings.Get(this)
End 
#end	
Function ULongToString:String( value:ULong,base:UInt )
	
	Local str:=""
		
	While value
		Local n:=value Mod base
		If n<10 str=String.FromChar( n+48 )+str Else str=String.FromChar( n+55 )+str
		value/=base
	Wend
		
	Return str ? str Else "0"
End

' Implementation: iDkP from GaragePixel
' 2025-04-03 (Aida 4)

' Memory bit manipulation functions
Function FloatToUInt:UInt(value:Float)
	Local bytes:=New UInt[1]
	Local bptr:Byte Ptr = Byte Ptr(Varptr bytes[0])
	
	stdlib.plugins.libc.memcpy(bptr, Varptr value, 4)
	Return bytes[0]
End

Function UIntToFloat:Float(value:UInt)
	Local bytes:=New UInt[1]
	bytes[0] = value
	Local result:Float
	Local bptr:Byte Ptr = Byte Ptr(Varptr bytes[0])
	
	stdlib.plugins.libc.memcpy(Varptr result, bptr, 4)
	Return result
End
