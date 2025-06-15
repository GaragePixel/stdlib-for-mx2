
Namespace stdlib.stringio

#Import "../plugins/libc/libc"

Using stdlib.plugins.libc

Function StringJoin<T>:String(delimiter:String, items:List<T>)

	' Temporary place here
		
	' iDkP from GaragePixel 2025-05-04
	' Utility function that joins a list of elements 
	' into a single string with a specified delimiter.
	' Note: 
	' 	The item of type t must have the operator To.String
	' 	in such a way the syntax item.ToString() could be
	' 	adapted to Aida syntax.
	
	Local result:String = ""
	Local first:Bool = True
	
	For Local item:T = Eachin items
		If Not first
			result += delimiter
		Else
			first = False
		End
		result += item
	End
	
	Return result
End

#rem monkeydoc Loads a string from a file.

An empty string will be returned if the file could not be opened.

@param path The path of the file.

@param fixeols If true, converts eols to UNIX "~n" eols after loading.

@return A String containing the contents of the file. 

#end
Function LoadString:String( path:String,fixeols:Bool=False )

	Local data:=DataBuffer.Load( path )
	If Not data Return ""
	
	Local str:=String.FromCString( data.Data,data.Length )
	
	data.Discard()
	
	If fixeols
		str=str.Replace( "~r~n","~n" )
		str=str.Replace( "~r","~n" )
	Endif
	
	Return str
End

#rem monkeydoc Saves a string to a file.

@param str The string to save.

@param path The path of the file.

@param fixeols If true, converts eols to UNIX "~n" eols before saving.

@return False if the file could not be opened.

#end
Function SaveString:Bool( str:String,path:String,fixeols:Bool=False )

	If fixeols
		str=str.Replace( "~r~n","~n" )
		str=str.Replace( "~r","~n" )
	Endif
	
	Local data:=New DataBuffer( str.CStringLength )
	str.ToCString( data.Data,data.Length )
	
	Local ok:=data.Save( path )
	
	data.Discard()
	
	Return ok
End

#rem monkeydoc Converts an unsigned long value to a string.

@param value Value to convert.

@param base Numeric base for conversion, eg: 2 for binary, 16 for hex etc.

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

#rem monkeydoc Converts a string to an unsigned long value.
@param str String to convert.
@param base Numeric base for conversion, eg: 2 for binary, 16 for hex etc.
#end
Function StringToULong:ULong( str:String,base:UInt )

	Local value:ULong
	
	If base<=10
	
		For Local ch:=Eachin str
			If ch>=48 And ch<48+base value=value*base+(ch-48) Else Exit
		Next
		
		Return value
	Endif

	For Local ch:=Eachin str
		
		If ch>=48 And ch<58
			value=value*base+(ch-48)
		Else If ch>=65 And ch<65+(base-10)
			value=value*base+(ch-55)
		Else If ch>=97 And ch<97+(base-10)
			value=value*base+(ch-87)
		Else
			Exit
		Endif
	Next
	
	Return value
End

#rem monkeydoc Converts a ulong value to a binary string.
#end
Function Bin:String( value:ULong )
	
	Return ULongToString( value,2 )
End

#rem monkeydoc Converts a binary string to a ulong value.
#end
Function ParseBin:ULong( str:String )
	
	Return StringToULong( str,2 )
End

#rem monkeydoc Converts a ulong value to a hexadecimal string.
#end
Function Hex:String( value:ULong )
	
	Return ULongToString( value,16 )
End

#rem monkeydoc Converts a hexadecimal string to a ulong value.
#end
Function ParseHex:ULong( str:String )
	
	Return StringToULong( str,16 )
End

#rem monkeydoc Parse a boolean string.
Returns true if `str` equals "True", ignoring case. Otherwise, returns false.
#end
Function ParseBool:Bool( str:String )
	
	Return str.ToLower()="true"
End

#rem monkeydoc StringToCharArray
@author iDkP from [GaragePixel](https://github.com/GaragePixel)
@since 2025-06-15
Convert a string like " ", "~n", "~r~n", "~~", "~q", etc. to an array of char codes.
Uses StringToULong from stdlib.
@param str String to convert.
@return an array of Int
@example

```monkey2
Local delimArr:=StringToCharArray("~r~n")			' Returns [13,10]
Local delimArr2:=StringToCharArray(" ~n")			' Returns [32,10]
Local delimArr3:=StringToCharArray("XYZ")			' Returns [88,89,90]
Local delimArr4:=StringToCharArray("~q")			' Returns [34]
Local delimArr4:=StringToCharArray("XYZ~q~r~n")		' Returns [88,89,90,34,13,10]
```
#end
Function StringToCharArray:Int[]( str:String )
	
	Local codes:=New Int[0]
	Local i:=0
	
	While i<str.Length
		
		Local ch:=str[i]
		
		If ch=126 ' "~" for escape
			If i+1<str.Length
				Select str[i+1]
					Case 110	' "n"
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong("10",10)	' LF
						i+=2
					Case 114	' "r"
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong("13",10)	' CR
						i+=2
					Case 116	' "t"
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong("9",10)		' TAB
						i+=2
					Case 113	' "q"
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong("34",10)	' Q
						i+=2
					Case 126	' "~"
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong("126",10)	' literal ~
						i+=2
					Default
						' Unrecognized escape, treat as literal
						codes=codes.Resize( codes.Length+1 )
						codes[codes.Length-1]=StringToULong( String(str[i+1]), 10 )
						i+=2
				End
			Else
				' Lone ~ at end, treat as literal
				codes=codes.Resize( codes.Length+1 )
				codes[codes.Length-1]=StringToULong("126",10)
				i+=1
			End
		Else
			' Normal character
			codes=codes.Resize( codes.Length+1 )
			codes[codes.Length-1]=StringToULong( String(ch), 10 )
			i+=1
		End
	Wend
	
	Return codes
End
