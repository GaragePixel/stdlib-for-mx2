
Namespace stdlib.crypto.hashing.sha1

Private

#Import "utils"

Using stdlib.crypto.hashing.utils

Public

Function SHA1:String( in:String )
	
	Local h0:Int = $67452301, h1:Int = $EFCDAB89, h2:Int = $98BADCFE, h3:Int = $10325476, h4:Int = $C3D2E1F0
  
	Local intCount:Int = (((in.Length + 8) Shr 6) + 1) Shl 4
	Local data:Int[] = New Int[intCount]
  
	For Local c:Int=0 Until in.Length
		data[c Shr 2] = (data[c Shr 2] Shl 8) | (in[c] & $FF)
 	Next
 	
	data[in.Length Shr 2] = ((data[in.Length Shr 2] Shl 8) | $80) Shl ((3 - (in.Length & 3)) Shl 3) 
	data[data.Length - 2] = (Long(in.Length) * 8) Shr 32
	data[data.Length - 1] = (Long(in.Length) * 8) & $FFFFFFFF
  
	For Local chunkStart:Int=0 Until intCount Step 16
		
		Local a:Int = h0, b:Int = h1, c:Int = h2, d:Int = h3, e:Int = h4
 
		Local w := data.Slice(chunkStart,chunkStart+16).Resize(80)
    
		For Local i:Int=16 To 79
			w[i] = Rol(w[i - 3] ~ w[i - 8] ~ w[i - 14] ~ w[i - 16], 1)
		Next
    
		For Local i:Int=0 To 19
			Local t:Int = Rol(a, 5) + (d ~ (b & (c ~ d))) + e + $5A827999 + w[i]
      
			e = d ; d = c
			c = Rol(b, 30)
			b = a ; a = t
		Next
    
		For Local i:Int=20 To 39
			Local t:Int = Rol(a, 5) + (b ~ c ~ d) + e + $6ED9EBA1 + w[i]
      
			e = d ; d = c
			c = Rol(b, 30)
			b = a ; a = t
		Next
    
		For Local i:Int=40 To 59
			Local t:Int = Rol(a, 5) + ((b & c) | (d & (b | c))) + e + $8F1BBCDC + w[i]
      
			e = d ; d = c
			c = Rol(b, 30)
			b = a ; a = t
		Next
 
		For Local i:Int=60 To 79
			Local t:Int = Rol(a, 5) + (b ~ c ~ d) + e + $CA62C1D6 + w[i]
      
			e = d ; d = c
			c = Rol(b, 30)
			b = a ; a = t
		Next
    
		h0 += a
		h1 += b
		h2 += c
		h3 += d
		h4 += e
	Next
  
	Return (Hex(UInt(h0)) + Hex(UInt(h1)) + Hex(UInt(h2)) + Hex(UInt(h3)) + Hex(UInt(h4))).ToLower()

End