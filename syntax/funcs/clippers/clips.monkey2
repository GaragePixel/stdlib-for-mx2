
Namespace stdlib.syntax.clips

'-------------------------- Clip (replace Trim: deprecated)

Function Clip<T>:T( value:T, min:T, max:T )
	' Reference version
	' Clip is alike Clamp, but it's more optimized, and has a pointer version
	Return value<min? min Else (value>max? max Else value)
End
	
Function Clip<T>( value:T Ptr, min:T, max:T )
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
End

Function Clip<T>( value:T Ptr, min:T Ptr, max:T )
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	value[0]=value[0]<min[0]? min[0] Else (value[0]>max? max Else value[0])
End

Function Clip<T>( value:T Ptr, min:T, max:T Ptr )
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	value[0]=value[0]<min? min Else (value[0]>max[0]? max[0] Else value[0])
End

Function Clip<T>( value:T Ptr, min:T Ptr, max:T Ptr )
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	value[0]=value[0]<min[0]? min[0] Else (value[0]>max[0]? max[0] Else value[0])
End

Function Clip<T1,T2,T3>:T1( value:T1, min:T2, max:T3 ) 'New style 2025!
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	' Product typed & Pointer version
	Return value<min? min Else (value>max? max Else value)
End

Function Clip<T1,T2,T3>( value:T1 Ptr, min:T2, max:T3 ) 'New style 2025!
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	' Product typed & Pointer version
	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
End

Function Clip<T1,T2,T3>( value:T1 Ptr, min:T2 Ptr, max:T3 ) 'New style 2025!
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	' Product typed & Pointer version
	value[0]=value[0]<min[0]? min[0] Else (value[0]>max? max Else value[0])
End 

Function Clip<T1,T2,T3>( value:T1 Ptr, min:T2, max:T3 Ptr ) 'New style 2025!
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	' Product typed & Pointer version
	value[0]=value[0]<min? min Else (value[0]>max[0]? max[0] Else value[0])
End 

Function Clip<T1,T2,T3>( value:T1 Ptr, min:T2 Ptr, max:T3 Ptr ) 'New style 2025!
	' Pointer version
	' Clip is alike Clamp, but it's more optimized
	' Product typed & Pointer version
	value[0]=value[0]<min[0]? min[0] Else (value[0]>max? max Else value[0])
End

Function ClipL<T>:T( value:T, lim:T )
	' Only clip the value if inferior to a minimal value
	Return value<lim? lim Else value
End

Function ClipL<T>( value:T Ptr, lim:T )
	' Only clip the value if inferior to a minimal value
	value[0]=value[0]<lim? lim Else value[0]
End

Function ClipL<T>( value:T Ptr, lim:T Ptr )
	' Only clip the value if inferior to a minimal value
	value[0]=value[0]<lim[0]? lim[0] Else value[0]
End

Function ClipH<T>:T( value:T, lim:T )
	' Only clip the value if superior to a minimal value
	Return value>lim? lim Else value
End

Function ClipH<T>:T( value:T Ptr, lim:T )
	' Only clip the value if superior to a minimal value
	value[0]=value[0]>lim? lim Else value[0]
End

Function ClipH<T>( value:T Ptr, lim:T Ptr )
	' Only clip the value if superior to a minimal value
	value[0]=value[0]>lim[0]? lim[0] Else value[0]
End

Function ClipUnder<T>:T( value:T, lim:T )
	' Sugar
	' Added iDkP 2025-07-09
	' Only clip the value if superior to a minimal value
	Return ClipH(value,lim)
End

Function ClipUnder<T>( value:T Ptr, lim:T )
	' Sugar
	' Added iDkP 2025-07-09
	' Pointer version
	' Only clip the value if superior to a minimal value
	ClipH(value,lim)
End

Function ClipUnder<T>( value:T Ptr, lim:T Ptr )
	' Sugar
	' Added iDkP 2025-07-11
	' Only clip the value if superior to a minimal value
	ClipH(value,lim)
End

Function ClipOver<T>:T( value:T, lim:T )
	' Sugar
	' Added iDkP 2025-07-09
	' Only clip the value if inferior to a minimal value
	Return ClipL(value,lim)
End

Function ClipOver<T>( value:T Ptr, lim:T )
	' Sugar
	' Added iDkP 2025-07-09
	' Pointer version
	' Only clip the value if inferior to a minimal value
	ClipL(value,lim)
End

Function ClipOver<T>( value:T Ptr, lim:T Ptr )
	' Sugar
	' Added iDkP 2025-07-09
	' Only clip the value if inferior to a minimal value
	ClipL(value,lim)
End
