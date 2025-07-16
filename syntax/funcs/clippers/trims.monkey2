'Trims

Namespace stdlib.syntax.trims

'#Import "../../../lang/lang"

'#Import "<monkey>"

'Using monkey.types 'TOINTEGRATE

#Rem
	Function Main()
		Local n:Int=5
		Print "value: "+n
		Trim(Varptr n, 0, 10 )
		print "trimmed between [0 - 100] = "+n
		n=15
		Print "value: "+n
		Trim(Varptr n, 0, 10 )
		print "trimmed between [0 - 100] = "+n
		n=-5
		Print "value: "+n
		Trim(Varptr n, 0, 10 )
		print "trimmed between [0 - 100] = "+n
	end
#end
		
Function Trim<T>:T( value:T, min:T, max:T )
	' Value version
	Return value<min? min Else (value>max? max Else value)
End
	
Function Trim<T>( value:T Ptr, min:T, max:T )
	' Pointer version
	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
End

'Function Trim<T>( value:UInt Ptr, min:T, max:T ) 'UNDONED
'	' Pointer version
'	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
'End

Function Trim<T1,T2>( value:T1 Ptr, min:T2, max:T2 ) 'New style 2025!
	' Product typed & Pointer version
	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
End

Function Trim<T1,T2,T3>( value:T1 Ptr, min:T2, max:T3 ) 'New style 2025!
	' Product typed & Pointer version
	value[0]=value[0]<min? min Else (value[0]>max? max Else value[0])
End
