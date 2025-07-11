
'Namespace std.types.wrapped.dotnet
Namespace stdlib.types

#rem
	MiniLibrary: word
		Long name: 
			microsoft word (datatype)
		Description: 
			microsoft's 16 bits word
			
	idKp for GaragePixel
	2024-02-02
	
	Definition from: https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-dtyp/262627d8-3418-4627-9218-4ffe110850b2
		A WORD is a 16-bit unsigned integer (range: 0 through 4294967295 decimal). 
		Because a DWORD is unsigned, its first bit (Most Significant Bit (MSB)) is 
		not reserved for signing.

	Explication by time context:
	
		16-bit era:
			MS-DOS and Windows 3.1 -> 16-bit mode
			Intel 8086 word -> 16 bits
			Typical compiler UINT -> 16 bits
			Microsoft WORD -> 16 bits
			Microsoft DWORD -> 32 bits

		32-bit era:
			Windows NT -> 32-bit mode
			Intel 80386 word -> 32 bits
			Typical compiler UINT -> 32 bits
			Microsoft WORD -> 16 bits
			Microsoft DWORD -> 32 bits

		64-bit era:
			Windows -> 64-bit mode
			Intel word -> 64 bits
			Typical compiler UINT -> 32, 64 bits... (will works without surprise)
			Typical compiler UINT32 -> 32 bits
			Microsoft WORD -> 16 bits
			Microsoft DWORD -> 32 bits

	Usage example:
	
		Namespace test
			
		Function Test( p:LPDWORD )
			    
		    Print p[0]
		End
			
		Function Main()
			    
		    Local t:DWORD=10
			    
		    Test( Varptr t )
		End
#end

#If __TARGET__="windows"

#Import "<windows.h>"

Extern

Alias WORD:UShort
Alias LPWORD:WORD Ptr ' Assumed Ptr type will by always 32-bits
Alias WORD_PTR:LPWORD

#Endif
