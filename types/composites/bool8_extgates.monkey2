
Namespace stdib.types.bool8.AOI

'------------------------------------------------ Logical: Bool8
' Added 2024 by iDkP from GaragePixel
' dependency: 
'	bool8
'---------------------- Logical Gates

'Logical operators, in Infix notation:
'		Composed Logical operators:
'			AOI-Gates:
'				Precoded AOI gates:
'					Squared gates:
'		 				AOI_2_2, AOI_3_3, AOI_4_4, AOI_8_8, AOI_16_16
'					Custom gates:
'						AOI_2_1, AOI_4_3_2, AOI_5_4_3_2
'				Helpers to build any custom AOI gates:
'					AOI_Buff_2, AOI_Buff_3, AOI_Buff_4, 
'					AOI_Buff_5, AOI_Buff_6, AOI_Buff_7, AOI_Buff_8
'			OAI-Gates:
'				Precoded OAI gates:
'					Squared gates:
'		 				OAI_2_2, OAI_3_3, OAI_4_4, OAI_8_8, OAI_16_16
'					Custom gates:
'						OAI_2_1, OAI_4_3_2, OAI_5_4_3_2
'				Helpers to build any custom OAI gates:
'					OAI_Buff_2, OAI_Buff_3, OAI_Buff_4, 
'					OAI_Buff_5, OAI_Buff_6, OAI_Buff_7, OAI_Buff_8
'
' Quick true table:
'
'AOI_2_1
	' A B C	OUTPUT
	' 0	0 0	1
	' 0	0 1	0
	' 0	1 0	1
	' 0	1 1	0
	' 1	0 0	1
	' 1	0 1	0
	' 1	1 0	0
	' 1	1 1	0	
'AOI_2_2
	' A B C D	OUTPUT
	' 0	0 0	0	1
	' 0	0 0	1	1
	' 0	0 1	0	1
	' 0	0 1	1	0
	' 0	1 0	0	1
	' 0	1 0	1	1
	' 0	1 1	0	1
	' 0	1 1	1	0
	' 1	0 0	0	1
	' 1	0 0	1	1
	' 1	0 1	0	1
	' 1	0 1	1	0
	' 1 1 0	0	0
	' 1 1 0	1	0
	' 1 1 1	0	0
	' 1 1 1	1	0

'#Import "bool8"

Using stdlib.types.bool8

'---------------------- Bool8 - AOI-Gates

Function AOI_2_1<T>:Bool8(		a:T,b:T,c:T	)
	' Added 2024 by iDkP
	' Its logic table would have 3 entries and 8 possible outputs and 3 opening	
	Return Not8((a & b) | c)
End 

Function AOI_2_2<T>:Bool8(		a:T,b:T,c:T, d:T	)
	' Added 2024 by iDkP
	' Its logic table would have 4 entries and 16 possible outputs and 9 openings.
	Return Not8((a & b) | (c & b))
End 

Function AOI_3_3<T>:Bool8(		a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	' Its logic table would have 6 entries and 64 possible outputs.
	Return Not8((a & b & c) | (d & e & f))
End

Function AOI_4_4<T>:Bool8(		a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' Its logic table would have 8 entries, 256 possible outputs.
	Return Not8((a & b & c & d) | (e & f & g & h))
End

Function AOI_8_8<T>:Bool8(		a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, h:T,
								i:T, j:T, k:T, l:T,
								m:T, n:T, o:T, p:T	)
	' Added 2024 by iDkP
	' Its logic table would have 16 entries, 65536 possible outputs.
	Local m0:=(a & b & c & d) | (e & f & g & h)
	Local m1:=(i & j & k & l) | (m & n & o & p)
	Return Not8(m0 | m1)
End

Function AOI_16_16<T>:Bool8(	a:T,b:T,c:T, d:T, 
								e:T, f:T, g:T, h:T,
								i:T, j:T, k:T, l:T,
								m:T, n:T, o:T, p:T,
								q:T, r:T, s:T, t:T,
								u:T, v:T, w:T, x:T,
								y:T, z:T, aa:T, ab:T,
								ac:T, ad:T, ae:T, af:T)
	' Added 2024 by iDkP
	' Its logic table would have 32 entries, 1048576 possible outputs (32*32=1024, 1024*1024=1048576).
							
	Local m0:=(a & b & c & d) | (e & f & g & h)
	Local m1:=(i & j & k & l) | (m & n & o & p)
	Local m2:=(q & r & s & t) | (u & v & w & x)
	Local m3:=(y & z & aa & ab) | (ac & ad & ae & af)
	Return Not8(m0 | m1 | m2 | m3)
End

Function AOI_Buff_2<T>:Bool8(	a:T, b:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b
End
Function AOI_Buff_3<T>:Bool8(	a:T, b:T, c:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c
End
Function AOI_Buff_4<T>:Bool8(	a:T, b:T, c:T, d:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c & d
End
Function AOI_Buff_5<T>:Bool8(	a:T, b:T, c:T, d:T, e:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c & e
End
Function AOI_Buff_6<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c & e & f
End
Function AOI_Buff_7<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T, g:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c & e & f & g
End
Function AOI_Buff_8<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a & b & c & e & f & g & h
End

Function AOI_4_3_2<T>:Bool8(	a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, 
								h:T, i:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 576 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not8((a & b & c & d) | (e & f & g) | (h & i))
End
Function AOI_5_4_3_2<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, 
								f:T, g:T, h:T, i:T,
								j:T, k:T, l:T,
								m:T, n:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 14400 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not8(AOI_Buff_5(a,b,c,d,e) | AOI_Buff_4(f,g,h,i) | AOI_Buff_3(j,k,l) | AOI_Buff_2(m,n))
End

'---------------------- Bool8 - OAI-Gates

Function OAI_2_1<T>:Bool8(a:T,b:T,c:T)
	' Added 2024 by iDkP
	' Its logic table would have 3 entries and 8 possible outputs and 3 opening
	Return Not8((a | b) & c)
End 

Function OAI_2_2<T>:Bool8(a:T,b:T,c:T, d:T)
	' Added 2024 by iDkP
	' Its logic table would have 4 entries and 16 possible outputs and 9 openings.
	Return Not8((a | b) & (c | b))
End 

Function OAI_3_3<T>:Bool8(a:T, b:T, c:T, d:T, e:T, f:T)
	' Added 2024 by iDkP
	' Its logic table would have 6 entries and 64 possible outputs.
	Return Not8((a | b | c) & (d | e | f))
End

Function OAI_4_4<T>:Bool8(		a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' Its logic table would have 8 entries, 256 possible outputs.
	Return Not8((a | b | c | d) & (e | f | g | h))
End

Function OAI_8_8<T>:Bool8(		a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, h:T,
								i:T, j:T, k:T, l:T,
								m:T, n:T, o:T, p:T	)
	' Added 2024 by iDkP
	' Its logic table would have 16 entries, 65536 possible outputs.
	Local m0:=(a | b | c | d) & (e | f | g | h)
	Local m1:=(i | j | k | l) & (m | n | o | p)
	Return Not8(m0 & m1)
End

Function OAI_16_16<T>:Bool8(	a:T,b:T,c:T, d:T, 
								e:T, f:T, g:T, h:T,
								i:T, j:T, k:T, l:T,
								m:T, n:T, o:T, p:T,
								q:T, r:T, s:T, t:T,
								u:T, v:T, w:T, x:T,
								y:T, z:T, aa:T, ab:T,
								ac:T, ad:T, ae:T, af:T)
	' Added 2024 by iDkP
	Local m0:=(a | b | c | d) & (e | f | g | h)
	Local m1:=(i | j | k | l) & (m | n | o | p)
	Local m2:=(q | r | s | t) & (u | v | w | x)
	Local m3:=(y | z | aa | ab) & (ac | ad | ae | af)
	Return Not8(m0 & m1 & m2 & m3)
End

Function OAI_Buff_2<T>:Bool8(	a:T, b:T	)
	' Added 2024 by iDkP
	Return a | b
End
Function OAI_Buff_3<T>:Bool8(	a:T, b:T, c:T	)
	' Added 2024 by iDkP
	Return a | b | c
End
Function OAI_Buff_4<T>:Bool8(	a:T, b:T, c:T, d:T	)
	' Added 2024 by iDkP
	Return a | b | c | d
End
Function OAI_Buff_5<T>:Bool8(	a:T, b:T, c:T, d:T, e:T	)
	' Added 2024 by iDkP
	Return a | b | c | e
End
Function OAI_Buff_6<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	Return a | b | c | e | f
End
Function OAI_Buff_7<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T, g:T	)
	' Added 2024 by iDkP
	Return a | b | c | e | f | g
End
Function OAI_Buff_8<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	Return a | b | c | e | f | g | h
End
Function OAI_4_3_2<T>:Bool8(	a:T, b:T, c:T, d:T, 
								e:T, f:T, g:T, 
								h:T, i:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 576 entries.
	Return Not8((a | b | c | d) & (e | f | g) & (h | i))
End
Function OAI_5_4_3_2<T>:Bool8(	a:T, b:T, c:T, d:T, e:T, 
								f:T, g:T, h:T, i:T,
								j:T, k:T, l:T,
								m:T, n:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 14400 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not8(AOI_Buff_5(a,b,c,d,e) & AOI_Buff_4(f,g,h,i) & AOI_Buff_3(j,k,l) & AOI_Buff_2(m,n))
End

