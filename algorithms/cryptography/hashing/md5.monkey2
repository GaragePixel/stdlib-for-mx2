
Namespace stdlib.crypto.hashing.md5

Private

'#Import "utils"

Using stdlib.crypto.hashing.utils

'#Import "../../../io/stringio"

Using stdlib.stringio

'Legacy text (by Sibly):
'	Thanks to mx2 user Jesse for converting the original bmx code by bmx user Yan!
'Refactoring (iDkP from GaragePixel):
'	Thanks to Jesse for converting Yan's original bmx code to the new mx2 language!
 
Public

Function MD5:String( in:String )
	
	Local h0:Int = $67452301, h1:Int = $EFCDAB89, h2:Int = $98BADCFE, h3:Int = $10325476
    
	Local r:Int[] = New Int[](
		7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,  7, 12, 17, 22,
		5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,  5,  9, 14, 20,
		4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,  4, 11, 16, 23,
		6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21,  6, 10, 15, 21)
                
	Local k:Int[] = New Int[](
		$D76AA478, $E8C7B756, $242070DB, $C1BDCEEE, $F57C0FAF, $4787C62A,
		$A8304613, $FD469501, $698098D8, $8B44F7AF, $FFFF5BB1, $895CD7BE,
		$6B901122, $FD987193, $A679438E, $49B40821, $F61E2562, $C040B340,
		$265E5A51, $E9B6C7AA, $D62F105D, $02441453, $D8A1E681, $E7D3FBC8,
		$21E1CDE6, $C33707D6, $F4D50D87, $455A14ED, $A9E3E905, $FCEFA3F8,
		$676F02D9, $8D2A4C8A, $FFFA3942, $8771F681, $6D9D6122, $FDE5380C,
		$A4BEEA44, $4BDECFA9, $F6BB4B60, $BEBFBC70, $289B7EC6, $EAA127FA,
		$D4EF3085, $04881D05, $D9D4D039, $E6DB99E5, $1FA27CF8, $C4AC5665,
		$F4292244, $432AFF97, $AB9423A7, $FC93A039, $655B59C3, $8F0CCC92,
		$FFEFF47D, $85845DD1, $6FA87E4F, $FE2CE6E0, $A3014314, $4E0811A1,
		$F7537E82, $BD3AF235, $2AD7D2BB, $EB86D391)
                
	Local intCount:Int = (((in.Length + 8) Shr 6) + 1) Shl 4
  	Local data:Int[] = New Int[intCount]
  
	For Local c:Int=0 Until in.Length
		data[c Shr 2] = data[c Shr 2] | ((in[c] & $FF) Shl ((c & 3) Shl 3))
  	Next
  	
	data[in.Length Shr 2] = data[in.Length Shr 2] | ($80 Shl ((in.Length & 3) Shl 3)) 
	data[data.Length - 2] = (Long(in.Length) * 8) & $FFFFFFFF
	data[data.Length - 1] = (Long(in.Length) * 8) Shr 32
  
	For Local chunkStart:Int=0 Until intCount Step 16
		
		Local a:Int = h0, b:Int = h1, c:Int = h2, d:Int = h3
    
	    For Local i:Int=0 To 15
		    
			Local f:Int = d ~ (b & (c ~ d))
			Local t:Int = d
      
			d = c ; c = b
			b = Rol((a + f + k[i] + data[chunkStart + i]), r[i]) + b
			a = t
		Next
    
		For Local i:Int=16 To 31
			
			Local f:Int = c ~ (d & (b ~ c))
      		Local t:Int = d
 
			d = c ; c = b
			b = Rol((a + f + k[i] + data[chunkStart + (((5 * i) + 1) & 15)]), r[i]) + b
			a = t
		Next
    
		For Local i:Int=32 To 47
			
			Local f:Int = b ~ c ~ d
			Local t:Int = d
      
			d = c ; c = b
			b = Rol((a + f + k[i] + data[chunkStart + (((3 * i) + 5) & 15)]), r[i]) + b
			a = t
		Next
    
		For Local i:Int=48 To 63
			
			Local f:Int = c ~ (b | ~d)
			Local t:Int = d
      
			d = c ; c = b
			b = Rol((a + f + k[i] + data[chunkStart + ((7 * i) & 15)]), r[i]) + b
			a = t
		Next
    
		h0 += a 
		h1 += b
		h2 += c 
		h3 += d

	Next
  
	Return (LEHex(h0) + LEHex(h1) + LEHex(h2) + LEHex(h3)).ToLower()

End
 
Private

