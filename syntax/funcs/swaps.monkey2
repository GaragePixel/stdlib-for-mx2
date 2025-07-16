Namespace stdlib.syntax

#Import "../../types/types"

Using stdlib.types..

#Rem monkeydoc Swap
@author iDkP from GaragePixel
@since 2021
#end 	
Function Swap<T>( a:T Ptr,b:T Ptr )
	'-----------
	'Author : 
	'	Humanity, Adapted by iDkP for GaragePixel
	'Year : 2021
	'Usage Example:
	'	Swap<Int>( Varptr chars[0+n], Varptr chars[chars.Length-n-1] )
	'-----------
	Local t:=a[0]
	a[0]=b[0]
	b[0]=t
End

#Rem monkeydoc Swap 3x
@author iDkP from GaragePixel
@since 2025-02-14
#end 	
Function Swap<T>( a:T Ptr,b:T Ptr,c:T Ptr )

	'iDkP for GaragePixel
	'Year : 2025-02-14

	Local t:=a[0]
	a[0]=c[0]
	c[0]=t
End

#Rem monkeydoc Tuple's swaps
@author iDkP from GaragePixel
@since 2025-02-14
#end 	
Function Swap<T1,T2>( a:T1 Ptr,b:T2 Ptr )
	
	'iDkP from GaragePixel
	'2025-02-13
	'More bloodish that the normal version, the tuple swap!
	
	Local t:=a[0]
	a[0]=b[0]
	b[0]=t
End

Function Swap<T1,T2,T3>( a:T1 Ptr,b:T2 Ptr,c:T2 Ptr )
	
	'iDkP from GaragePixel
	'2025-02-14
	'Tuple3's swap
	
	Local t:=a[0]
	a[0]=c[0]
	c[0]=t
End

#Rem monkeydoc Dedidaced swaps to data types (long, short... )
@author iDkP from GaragePixel
@since 2025-02-14

Added from the original srd.stream.Stream
This is an important feature, it was private before.
It allows to swap the bytes within primitive data type.

Using this, we can play with the byte order for
implementing little/big endian order in any
user features. Please contribute to aida.std!
#end	
Function Swap2( v:Void Ptr )
	' 2 bytes swapping
	Local t:=Cast<UShort Ptr>( v )[0]
	Cast<UShort Ptr>( v )[0]=(t Shr 8 & $ff) | (t & $ff) Shl 8
End
	
Function Swap4( v:Void Ptr )
	' 4 bytes swapping
	Local t:=Cast<UInt Ptr>( v )[0]
	Cast<UInt Ptr>( v )[0]=(t Shr 24 & $ff) | (t & $ff) Shl 24 | (t Shr 8 & $ff00) | (t & $ff00) Shl 8
End
	
Function Swap8( v:Void Ptr )
	' 8 bytes swapping
	Local t:=Cast<ULong Ptr>( v )[0]
	Cast<ULong Ptr>( v )[0]=(t Shr 56 & $ff) | (t & $ff) Shl 56 | (t Shr 40 & $ff00) | (t & $ff00) Shl 40 | (t Shr 24 & $ff0000) | (t & $ff0000) Shl 24 | (t Shr 8 & $ff000000) | (t & $ff000000) Shl 8
End

#rem monkeydoc Swaps 2 elements in the stack, or 2 stacks.
@author iDkP from GaragePixel
@since 2025-06-21
This method can be used to either swap 2 elements in the stack, or 2 entire stacks.
In debug builds, a runtime error will occur if `index1` or `index2` is out of range.
Swapping entire stacks simply swaps the storage arrays and lengths of the 2 stacks, and is therefore very fast.
@param index1 The index of the first element.
@param index2 The index of the second element.
@param stack The stack to swap with.
#end
Function Swap<T>( this:Stack<T>, index1:Int,index2:Int ) 'iDkP: 32 bits!
	DebugAssert( index1>=0 And index1<_length And index2>=0 And index2<_length,"Stack index out of range" )
	
	Local t:=this.Data[index1]
	this.Data[index1]=this.Data[index2]
	this.Data[index2]=t
End

Function Swap<T>( a:Stack<T>, b:Stack<T> )
	Local data:=a.Data,length:=a.Length
	a.Data=b.Data
	a.SetLength=b.Length
	b.Data=data
	b.SetLength=length
End

#rem monkeydoc Swaps 2 elements in the array, or 2 array.
@author iDkP from GaragePixel
@since 2025-06-21
This method can be used to either swap 2 elements in the array, or 2 entire array.
In debug builds, a runtime error will occur if `index1` or `index2` is out of range.
@param index1 The index of the first element.
@param index2 The index of the second element.
@param array The array to swap with.
#end
Function Swap<T>( this:T[], index1:Int,index2:Int ) 'iDkP: 32 bits!
	DebugAssert( index1>=0 And index1<this.Length And index2>=0 And index2<this.Length,"Array index out of range" )
	
	Local t:=this[index1]
	this[index1]=this[index2]
	this[index2]=t
End
	
#rem monkeydoc Swaps 2 elements in the array, or 2 array.
@author iDkP from GaragePixel
@since 2025-06-21
This method can be used to either swap 2 elements in the array, or 2 entire array.
#end
Function Swap<T>( a:T[], b:T[] )
	Local data:=a
	a=b
	b=data
End

#rem monkeydoc pro Swaps 2 elements in the array, or 2 array.
@author iDkP from GaragePixel
@since 2025-06-21
This method can be used to either swap 2 elements in the array, or 2 entire array.
#end
Function Swap<T1,T2>( a:T1[], b:T2[] )
	Local data:=a
	a=b
	b=data
End

#rem monkeydoc Swap two characters in a string
@author iDkP from GaragePixel
@since 2025-06-23
Efficiently swaps characters at two indices in a normal (immutable) String.
Monkey2/Wonkey Strings are immutable, so any "mutation" creates a new string.
Suitable for swapping any two (distinct) indices, even if they are adjacent or at string boundaries.
Recommended for:
Single swaps or infrequent mutation on normal Strings. For batch swaps, see Stringx<T> pattern.
#end
Function Swap(str:String Ptr, index1:UInt, index2:UInt)

'	Old implementation:
'	Local ct:=str[0][offset1]
'	Local c1:=String.FromChar(str[0][offset2])
'	Local c2:=String.FromChar(ct)
'	Overrides(str,Varptr(c1),offset1)
'	Overrides(str,Varptr(c2),offset2)

	'New implementation, faster!

	If index1>index2
		' Always swap so index1 < index2 for easier slicing
		Local tmp:=index1
		index1=index2
		index2=tmp
	End

	'Slices in Monkey2/Wonkey are views into the same string memory (unless we force a copy), 
	'so this method is memory-efficient.

	Local p1:=str[0].Slice( 0,index1 )
	Local p2:=str[0].Slice( index1,index1+1 )
	Local p3:=str[0].Slice( index1+1,index2 )
	Local p4:=str[0].Slice( index2,index2+1 )
	Local p5:=str[0].Slice( index2+1 )
	
	'Recombining with + causes a new string allocation, 
	'but all slices themselves are just pointer/range bookkeeping,
	'no data is copied until we build the final result.
	
	'str[0]=p1+p4+p3+p2+p5

	'But we need to optimize the usage of string, because without optimization:  
	'	- The expression is parsed as nested binary operations:
	'		- `(((((p1+p4)+p3)+p2)+p5))`
	'
	'	- This means:
	'		1. First, 'p1+p4' → creates a new string (`tmp1`)
	'		2. Then, 'tmp1+p3' → creates `tmp2`
	'		3. Then, 'tmp2+p2' → creates `tmp3`
	'		4. Finally, 'tmp3+p5' → creates the out string
	'
	'	- For each '+', a new string is allocated and previous temporaries are used as sources.
	
	'So we will use Join:
	str[0]="".Join( New String[](p1,p4,p3,p2,p5) )
	'Internally, the method precomputes the total length and allocates the result in one pass
	'avoiding multiple temporary string allocations that happen with chained '+'.
End

#Rem monkeydoc Swap two strings
@author iDkP from GaragePixel
@since 2025-06-23
#End
Function Swap(a:String Ptr, b:String Ptr)	
	Local t:=a[0]
	a[0]=b[0]
	b[0]=t
End

#Rem monkeydoc Swap two characters in a stringx
Much faster than the same operation in built-in string.
@author iDkP from GaragePixel
@since 2025-06-23
#End
Function Swap<T>(str:Stringx<T> Ptr, index1:UInt, index2:UInt)
	Local t:=str[0].GetChar(index1)
	str[0].SetChar(index1,str[0].GetChar(index2))
	str[0].SetChar(index2,t)
End 

#Rem monkeydoc Swap two stringx
@author iDkP from GaragePixel
@since 2025-06-23
#End
Function Swap<T>(a:Stringx<T> Ptr, b:Stringx<T> Ptr)	
	Local t:=a[0]
	a[0]=b[0]
	b[0]=t
End
