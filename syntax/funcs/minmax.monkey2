
Namespace stdlib.syntax

'Minilib minmax
'iDkP from GaragePixel
'Since 2018-2025

'Note: In monkey library, the bad implemented min/max functions must be deactivated
'in order to make the multitypes min/max functions to works

Function Min<T>:T(a:T,b:T)	 								Where 	T Implements INumeric 
	'the limit value, if returned, is casted to the initial type
	Return a<b ? a Else b
End

Function Min<T1,T2>:T1(a:T1,b:T2) 							Where 	T1 Implements INumeric And 
																	T2 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a<b ? a Else b)
End


Function Min<T>:T Ptr(a:T Ptr,b:T Ptr) 						Where 	T Implements INumeric

	Return a[0]<b[0] ? a Else b
End

Function Min<T>:T(a:T Ptr,b:T Ptr) 							Where 	T Implements INumeric
	'return type overload?
	Return a[0]<b[0] ? a[0] Else b[0]
End

Function Min<T1,T2>:T1(a:T1 Ptr,b:T2 Ptr)		 			Where 	T1 Implements INumeric And 
																	T2 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a[0]<b[0] ? a[0] Else b[0])
End

Function Min<T>:T(a:T,b:T,c:T) 								Where 	T Implements INumeric
	
	'3 arguments breaks the overloading of the language min/max stuff
	'So the language library non-native stuff was undoned,
	'and in the the word we'll have peace!

	Return a<b ? (a<c ? a Else c) Else (b<c ? c Else b)
End

Function Min<T>:T Ptr(a:T Ptr,b:T Ptr,c:T Ptr) 				Where 	T Implements INumeric

	Return a[0]<b[0] ? (a[0]<c[0] ? c Else a) Else (b[0]<c[0] ? c Else b)
End

Function Min<T1,T2,T3>:T1(a:T1,b:T2,c:T3) 					Where 	T1 Implements INumeric And 
																	T2 Implements INumeric And
																	T3 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a<b ? (a<c ? a Else c) Else (b<c ? b Else c))
End

Function Min<T1,T2,T3>:T1(a:T1 Ptr,b:T2 Ptr,c:T3 Ptr) 		Where 	T1 Implements INumeric And 
																	T2 Implements INumeric And
																	T3 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a[0]<b[0] ? (a[0]<c[0] ? a[0] Else c[0]) Else (b[0]<c[0] ? b[0] Else c[0]))
End

Function Max<T>:T(a:T,b:T) 									Where 	T Implements INumeric
	Return a<b ? b Else a
End

Function Max<T1,T2>:T1(a:T1,b:T2) 							Where 	T1 Implements INumeric And 
																	T2 Implements INumeric
	Return a<b ? b Else a
End

Function Max<T>:T Ptr(a:T Ptr,b:T Ptr) 						Where 	T Implements INumeric

	Return a[0]<b[0] ? b Else a
End

Function Max<T1,T2>:T1(a:T1 Ptr,b:T2 Ptr) 					Where 	T1 Implements INumeric And 
																	T2 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a[0]<b[0] ? b[0] Else a[0])
End

Function Max<T>:T(a:T,b:T,c:T) 								Where 	T Implements INumeric

	Return a<b ? (b<c ? c Else b) Else (a<c ? c Else a)
End

Function Max<T>:T(a:T Ptr,b:T Ptr,c:T Ptr) 					Where 	T Implements INumeric

	Return a[0]<b[0] ? (b[0]<c[0] ? c Else b) Else (a[0]<c[0] ? c[0] Else a[0])
End

Function Max<T1,T2,T3>:T1(a:T1,b:T2,c:T3) 					Where 	T1 Implements INumeric And 
																	T2 Implements INumeric And
																	T3 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	Return Cast<T1>(a<b ? (b<c ? c Else b) Else (a<c ? c Else a))
End

Function Max<T1,T2,T3>:T1(a:T1 Ptr,b:T2 Ptr,c:T3 Ptr) 		Where 	T1 Implements INumeric And 
																	T2 Implements INumeric And
																	T3 Implements INumeric
	'the limit value, if returned, is casted to the initial type
	'Note that byte with int,float,double are incompatible
	Return Cast<T1>(a[0]<b[0] ? (b[0]<c[0] ? c[0] Else b[0]) Else (a[0]<c[0] ? c[0] Else a[0]))
End
