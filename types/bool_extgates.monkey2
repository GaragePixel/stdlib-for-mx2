
Namespace std.types.AOI

'------------------------------------------------ Logical: Bool
' Added 2024 by iDkP from GaragePixel
' dependency: 
'	bool8
'---------------------- Logical Gates

'Logical operators, in Infix notation:
'		Composed Logical operators:
'			AOI-Gates:
'				Precoded AOI gates:
'					Squared gates:
'		 				AOI_2_2Bool, AOI_3_3Bool, AOI_4_4Bool, AOI_8_8Bool, AOI_16_16Bool
'					Custom gates:
'						AOI_2_1Bool, AOI_4_3_2Bool, AOI_5_4_3_2Bool
'				Helpers to build any custom AOI gates:
'					AOI_Buff_2Bool, AOI_Buff_3Bool, AOI_Buff_4Bool, 
'					AOI_Buff_5Bool, AOI_Buff_6Bool, AOI_Buff_7Bool, AOI_Buff_8Bool
'			OAI-Gates:
'				Precoded OAI gates:
'					Squared gates:
'		 				OAI_2_2Bool, OAI_3_3Bool, OAI_4_4Bool, OAI_8_8Bool, OAI_16_16Bool
'					Custom gates:
'						OAI_2_1Bool, OAI_4_3_2Bool, OAI_5_4_3_2Bool
'				Helpers to build any custom OAI gates:
'					OAI_Buff_2Bool, OAI_Buff_3Bool, OAI_Buff_4Bool, 
'					OAI_Buff_5Bool, OAI_Buff_6Bool, OAI_Buff_7Bool, OAI_Buff_8Bool
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

'---------------------- Logical AOI-Gates: Old Bool type

'---------------------- Bool - AOI-Gates

Function AOI_2_1Bool<T>:Bool(		a:T,b:T,c:T	)
	' Added 2024 by iDkP
	' Its logic table would have 3 entries and 8 possible outputs and 3 opening	
	Return Not((a And b) Or c)
End 

Function AOI_2_2Bool<T>:Bool(		a:T,b:T,c:T, d:T	)
	' Added 2024 by iDkP
	' Its logic table would have 4 entries and 16 possible outputs and 9 openings.
	Return Not((a And b) Or (c And b))
End 

Function AOI_3_3Bool<T>:Bool(		a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	' Its logic table would have 6 entries and 64 possible outputs.
	Return Not((a And b And c) Or (d And e And f))
End

Function AOI_4_4Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' Its logic table would have 8 entries, 256 possible outputs.
	Return Not((a And b And c And d) Or (e And f And g And h))
End

Function AOI_8_8Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, h:T,
									i:T, j:T, k:T, l:T,
									m:T, n:T, o:T, p:T	)
	' Added 2024 by iDkP
	' Its logic table would have 16 entries, 65536 possible outputs.
	Local m0:=(a And b And c And d) Or (e And f And g And h)
	Local m1:=(i And j And k And l) Or (m And n And o And p)
	Return Not(m0 Or m1)
End

Function AOI_16_16Bool<T>:Bool(		a:T,b:T,c:T, d:T, 
									e:T, f:T, g:T, h:T,
									i:T, j:T, k:T, l:T,
									m:T, n:T, o:T, p:T,
									q:T, r:T, s:T, t:T,
									u:T, v:T, w:T, x:T,
									y:T, z:T, aa:T, ab:T,
									ac:T, ad:T, ae:T, af:T)
	' Added 2024 by iDkP
	' Its logic table would have 32 entries, 1048576 possible outputs (32*32=1024, 1024*1024=1048576).
							
	Local m0:=(a And b And c And d) Or (e And f And g And h)
	Local m1:=(i And j And k And l) Or (m And n And o And p)
	Local m2:=(q And r And s And t) Or (u And v And w And x)
	Local m3:=(y And z And aa And ab) Or (ac And ad And ae And af)
	Return Not(m0 Or m1 Or m2 Or m3)
End

Function AOI_Buff_2Bool<T>:Bool(	a:T, b:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b
End
Function AOI_Buff_3Bool<T>:Bool(	a:T, b:T, c:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c
End
Function AOI_Buff_4Bool<T>:Bool(	a:T, b:T, c:T, d:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c And d
End
Function AOI_Buff_5Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c And e
End
Function AOI_Buff_6Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c And e And f
End
Function AOI_Buff_7Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T, g:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c And e And f And g
End
Function AOI_Buff_8Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return a And b And c And e And f And g And h
End

Function AOI_4_3_2Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, 
									h:T, i:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 576 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not((a And b And c And d) Or (e And f And g) Or (h And i))
End
Function AOI_5_4_3_2Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, 
									f:T, g:T, h:T, i:T,
									j:T, k:T, l:T,
									m:T, n:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 14400 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not(AOI_Buff_5Bool(a,b,c,d,e) Or AOI_Buff_4Bool(f,g,h,i) Or AOI_Buff_3Bool(j,k,l) Or AOI_Buff_2Bool(m,n))
End

'---------------------- Bool - OAI-Gates

Function OAI_2_1Bool<T>:Bool(a:T,b:T,c:T)
	' Added 2024 by iDkP
	' Its logic table would have 3 entries and 8 possible outputs and 3 opening
	Return Not((a Or b) And c)
End 

Function OAI_2_2Bool<T>:Bool(a:T,b:T,c:T, d:T)
	' Added 2024 by iDkP
	' Its logic table would have 4 entries and 16 possible outputs and 9 openings.
	Return Not((a Or b) And (c Or b))
End 

Function OAI_3_3Bool<T>:Bool(a:T, b:T, c:T, d:T, e:T, f:T)
	' Added 2024 by iDkP
	' Its logic table would have 6 entries and 64 possible outputs.
	Return Not((a Or b Or c) And (d Or e Or f))
End

Function OAI_4_4Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	' Its logic table would have 8 entries, 256 possible outputs.
	Return Not((a Or b Or c Or d) And (e Or f Or g Or h))
End

Function OAI_8_8Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, h:T,
									i:T, j:T, k:T, l:T,
									m:T, n:T, o:T, p:T	)
	' Added 2024 by iDkP
	' Its logic table would have 16 entries, 65536 possible outputs.
	Local m0:=(a Or b Or c Or d) And (e Or f Or g Or h)
	Local m1:=(i Or j Or k Or l) And (m Or n Or o Or p)
	Return Not(m0 And m1)
End

Function OAI_16_16Bool<T>:Bool(		a:T,b:T,c:T, d:T, 
									e:T, f:T, g:T, h:T,
									i:T, j:T, k:T, l:T,
									m:T, n:T, o:T, p:T,
									q:T, r:T, s:T, t:T,
									u:T, v:T, w:T, x:T,
									y:T, z:T, aa:T, ab:T,
									ac:T, ad:T, ae:T, af:T)
	' Added 2024 by iDkP
	Local m0:=(a Or b Or c Or d) And (e Or f Or g Or h)
	Local m1:=(i Or j Or k Or l) And (m Or n Or o Or p)
	Local m2:=(q Or r Or s Or t) And (u Or v Or w Or x)
	Local m3:=(y Or z Or aa Or ab) And (ac Or ad Or ae Or af)
	Return Not(m0 And m1 And m2 And m3)
End

Function OAI_Buff_2Bool<T>:Bool(	a:T, b:T	)
	' Added 2024 by iDkP
	Return a Or b
End
Function OAI_Buff_3Bool<T>:Bool(	a:T, b:T, c:T	)
	' Added 2024 by iDkP
	Return a Or b Or c
End
Function OAI_Buff_4Bool<T>:Bool(	a:T, b:T, c:T, d:T	)
	' Added 2024 by iDkP
	Return a Or b Or c Or d
End
Function OAI_Buff_5Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T	)
	' Added 2024 by iDkP
	Return a Or b Or c Or e
End
Function OAI_Buff_6Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T	)
	' Added 2024 by iDkP
	Return a Or b Or c Or e Or f
End
Function OAI_Buff_7Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T, g:T	)
	' Added 2024 by iDkP
	Return a Or b Or c Or e Or f Or g
End
Function OAI_Buff_8Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, f:T, g:T, h:T	)
	' Added 2024 by iDkP
	Return a Or b Or c Or e Or f Or g Or h
End
Function OAI_4_3_2Bool<T>:Bool(		a:T, b:T, c:T, d:T, 
									e:T, f:T, g:T, 
									h:T, i:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 576 entries.
	Return Not((a Or b Or c Or d) And (e Or f Or g) And (h Or i))
End
Function OAI_5_4_3_2Bool<T>:Bool(	a:T, b:T, c:T, d:T, e:T, 
									f:T, g:T, h:T, i:T,
									j:T, k:T, l:T,
									m:T, n:T 	)
	' Added 2024 by iDkP
	' Its logic table would have 14400 entries.
	' To know the number of entries, sum the magnitude of each buffer and square it
	' Example, for this AOI_5_4_3_2 : (5*4*3*2)*(5*4*3*2)
	Return Not(AOI_Buff_5Bool(a,b,c,d,e) And AOI_Buff_4Bool(f,g,h,i) And AOI_Buff_3Bool(j,k,l) And AOI_Buff_2Bool(m,n))
End
