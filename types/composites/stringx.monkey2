
Namespace stdlib.types

'---------------------------------- String Conversions

#rem
Author: iDkP for GaragePixel
Author: AdamRedwood for the instanciable content
Since: 2024-01
Update: 2025-06-17 - Added selection by reflection types

- Monkey2/Wonkey Strings are immutable; all mutation requires allocation of a new string.
- `Stringx<T>` allows direct, type-safe mutation of the underlying buffer (`T[]`)
#end

#rem
'Test
Function Main()
	#rem
    Local s := New String32("A")
    Local t := s + "A"

    Print s.Length
    Print s.Size
    Print s.Data
    Print s
    Print t.Length
    Print t.Size
    Print t.Data
    Print t
    #end

'    Local str8 := New String8("A")
'    Print str8

'    Local str16 := New String16("A")
'    Print str16
	
'    Local str32 := New String32("￰")
'    Print str32

	Local character:String  = "\U00013000" '//first ancient hieroglyph
	'//get the Unicode index
	'Encoding enc = new UTF32Encoding(false, true, true);
	'byte[] b = enc.GetBytes(single_character);
	'Int32 code = BitConverter.ToInt32(b, 0);
	'for (int i = 0; i < 10; i++)
	'{
	'   //convert from int Unicode index to display character
	'   string glyph = Char.ConvertFromUtf32(code); //single one
	'   textBox1.Text += glyph;
	'   code++;
	' }
    
    Local bytes:=StringToBytes(character)
    Print GetString(bytes)
    Print UBytesToString(bytes,4)
    Print UBytesToUInt32(bytes,4)
    'Print UBytesToUInt32(New UByte[]($FF,$FF,$FF,$00,$00,$00,$00,$00),1)
    Print UBytesToUInt64(New UByte[](32,0,0,42,0,65,0,125,0),1)
    
End
#end

'#Import "../../types/builtin"

Alias String8:Stringx<Byte>
Alias String16:Stringx<Short>
Alias String32:Stringx<Int>

Class Stringx<T>

	Method New()
	End
		
	Method New(input:String)
		Local length:=input.Length
		_data=New T[length]
		For Local n:=0 Until length
			_data[n]=Cast<T>(input[n])
		Next
	End

	Method New(input:String Ptr)
		Local length:=input[0].Length
		_data=New T[length]
		For Local n:=0 Until length
			_data[n]=Cast<T>(input[n])
		Next
	End

	Method New(data:T[])
		Local length:=data.Length
		_data=data
	End
	
	Property Data:String()
		Local result:String
		For Local n:=0 Until Size
			result+=_data[n]
		Next
		Return result
	End

	Property RawData:T[]()
		Return _data
	End
	
	Property Length:Int()
		Return _data.Length
	End
	
	Property Size:Int()
		Select Typeof(Self)
			Case __t_ubyte__
				Return Length
			Case __t_ushort__
				Return Length*2
			Case __t_uint__
				Return Length*4
		End
		Return Length'*4
	End

	Operator To:String()
		'Return the stringx as a String32
		Return ToInt32()
	End

	Method ToString:String()
		'Return the datas as a string
		Local result:String
		For Local n:=0 Until Size
			result+=_data[n]
		Next
		Return result
	End

	Operator+:Stringx<T>( rhs:Stringx<T> )
		Return New Stringx<T>(Data+rhs.Data)
	End
	Operator+:Stringx<T>( rhs:String )
		Local depth:Int
		Select Typeof(Self)
			Case __t_byte__
				depth=1
			Case __t_short__
				depth=2
			Case __t_int__
				depth=4
		End
		Local data:=_data
		'Local data := New T[Length]
		data.Resize(Length+(rhs.Length*depth))
		'For Local n:=_data.Length Until _data.Length+data.Length-2
'		For Local n:=0 Until Length
'	        data[n]=_data[n]
'	    Next
		For Local n:=0 Until rhs.Length
			data[Length+n*depth]=rhs[n]
		Next
		Return New Stringx<T>(data)
	End

	Method GetChar:T(index:Int)
		If index>Length Return Null
		Return _data[index]
	End
	
	Method SetChar(index:Int,char:T)
		_data[index]=char
	End
	
	Method ToInt32:String()
		Return String.FromChars(Convert())
	End 
	
	Private

	Method Convert:Int[]()
		'it's a cast mecanism, but I can't avoid it even for Int.
		'So printing results parsing the datas
		Local result:=New Int[Length]
		For Local n:=0 Until Length
			result[n]=_data[n]
		End 
		Return result
	End
	
	Field _data:T[]
	Field _length:Int = 0
End
