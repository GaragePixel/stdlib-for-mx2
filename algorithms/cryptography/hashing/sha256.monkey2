
Namespace stdlib.crypto.hashing.sha256

Private

'#Import "utils"

Using stdlib.crypto.hashing.utils

Public

Function SHA256:String( in:String )
	
	Local h0:Int = $6A09E667, h1:Int = $BB67AE85, h2:Int = $3C6EF372, h3:Int = $A54FF53A
	Local h4:Int = $510E527F, h5:Int = $9B05688C, h6:Int = $1F83D9AB, h7:Int = $5BE0CD19
  
	Local k:Int[] = New Int[](
		$428A2F98, $71374491, $B5C0FBCF, $E9B5DBA5, $3956C25B, $59F111F1,
		$923F82A4, $AB1C5ED5, $D807AA98, $12835B01, $243185BE, $550C7DC3,
		$72BE5D74, $80DEB1FE, $9BDC06A7, $C19BF174, $E49B69C1, $EFBE4786,
		$0FC19DC6, $240CA1CC, $2DE92C6F, $4A7484AA, $5CB0A9DC, $76F988DA,
		$983E5152, $A831C66D, $B00327C8, $BF597FC7, $C6E00BF3, $D5A79147,
		$06CA6351, $14292967, $27B70A85, $2E1B2138, $4D2C6DFC, $53380D13,
		$650A7354, $766A0ABB, $81C2C92E, $92722C85, $A2BFE8A1, $A81A664B,
		$C24B8B70, $C76C51A3, $D192E819, $D6990624, $F40E3585, $106AA070,
		$19A4C116, $1E376C08, $2748774C, $34B0BCB5, $391C0CB3, $4ED8AA4A,
		$5B9CCA4F, $682E6FF3, $748F82EE, $78A5636F, $84C87814, $8CC70208,
		$90BEFFFA, $A4506CEB, $BEF9A3F7, $C67178F2)
 
	Local intCount:Int = (((in.Length + 8) Shr 6) + 1) Shl 4
	Local data:Int[] = New Int[intCount]
  
	For Local c:Int=0 Until in.Length
		data[c Shr 2] = (data[c Shr 2] Shl 8) | (in[c] & $FF)
	Next
	
	data[in.Length Shr 2] = ((data[in.Length Shr 2] Shl 8) | $80) Shl ((3 - (in.Length & 3)) Shl 3) 
	data[data.Length - 2] = (Long(in.Length) * 8) Shr 32
	data[data.Length - 1] = (Long(in.Length) * 8) & $FFFFFFFF
  
	For Local chunkStart:Int=0 Until intCount Step 16
		
		Local a:Int = h0, b:Int = h1, c:Int = h2, d:Int = h3, e:Int = h4, f:Int = h5, g:Int = h6, h:Int = h7
 
		Local w:=data.Slice(chunkStart,chunkStart+16).Resize(64)
    
		For Local i:Int=16 To 63
			w[i] = w[i - 16] + (Ror(w[i - 15], 7) ~ Ror(w[i - 15], 18) ~ ( UShr(w[i - 15],3) ))+
            w[i - 7] + (Ror(w[i - 2], 17) ~ Ror(w[i - 2], 19) ~ ( UShr(w[i - 2],10) ))
		Next
    
		For Local i:Int=0 To 63
			Local t0:Int = (Ror(a, 2) ~ Ror(a, 13) ~ Ror(a, 22)) + ((a & b) | (b & c) | (c & a))
			Local t1:Int = h + (Ror(e, 6) ~ Ror(e, 11) ~ Ror(e, 25)) + ((e & f) | (~e & g)) + k[i] + w[i]
      
			h = g ; g = f ; f = e ; e = d + t1
			d = c ; c = b ; b = a ;  a = t0 + t1  
		Next
    
		h0 += a ; h1 += b ; h2 += c ; h3 += d
		h4 += e ; h5 += f ; h6 += g ; h7 += h
	Next
  
	Return (Hex(UInt(h0)) + Hex(UInt(h1)) + Hex(UInt(h2)) + Hex(UInt(h3)) + Hex(UInt(h4)) + Hex(UInt(h5)) + Hex(UInt(h6)) + Hex(UInt(h7))).ToLower()
	
End
