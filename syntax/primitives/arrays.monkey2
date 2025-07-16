
Namespace stdlib.syntax

#rem MiniLibrary: Arrays
Since 2021? - 2025-02-02 - 2025-06-19 - 2025-06-21 (Aida 4)
Author: iDkP from GaragePixel

Purpose:
	Review and completeness assessment of the stdlib.syntax array minilibrary.

List of functionality:
	- Copying (CopyTo for inlined usage)
	- Reversal (full, subrange, pointer, inverse, pairwise, preserve)
	- Rotations (Rotate, Rot, RotL, RotR)
	- Scaling and tiling (Stretch, Scale, Tile)
	- Interleaving (Interleave)
	- Patterned rearrangement (Twirl, Swap)

TODO:
Missing or possible extensions:
	- Aggregation: Sum, Min, Max, Average.
	- Set operations: Union, Intersection, Difference, Unique/Distinct.
	- Chunking/Splitting: Split into fixed-size blocks, group by predicate.
	- Flatten/Concat: For arrays-of-arrays.
	- Fill: Fill with single value or pattern.
	- Clamp/Clip: Bound all elements to a range.
	- Sliding window: Windowed views for DSP, stats, ML.

Summary:
	- For core permutations, copying, and pattern generation, your library is **complete and even advanced**.
	- For full "batteries-included" status, add functional, searching, set, and chunking utilities.
	- For most projects—especially graphics, DSP, procedural, and systems—it is already a **top-tier array toolkit**.
	- Documentation and naming make it both accessible and powerful.
#end 

Function CopyTo<T>:T[]( this:T[], out:T[], srcOffset:Int=0, dstOffset:Int=0, count:Int=Null )
	'
	'A CopyTo who can be inlined
	'Usage example:
	'
	'	'It's impossible to inline the builtin CopyTo who do not returns any reference,
	'	'but with this CopyTo version, we can write, for example:
	'	Local out:= copy ? this.CopyTo( New T[],0,0,this.Length ) Else this
	'	Or with overloading:
	'	Local out:= copy ? this.CopyTo(New T[]) Else this

	If count=Null count=this.Length
	this.CopyTo( out,srcOffset,dstOffset,count )
	Return out
End

#rem monkeydoc @pro Return a copy of the array is needed
#end
Function Cpynd<T>:T[](data:T[],needed:Bool)
    'Both useful and elegant^^
    Return needed ? CopyTo(data,New T[data.Length]) Else data
End

#rem monkeydoc hidden Merges two sorted arrays into a single sorted array.
Merges the elements of arrays a and b, preserving order and stability.

On elements:
	a = [1, 3, 4]
	b = [2, 3, 5]

	Before:
		a: [1, 3, 4]
		b: [2, 3, 5]
	After:
		[1, 2, 3, 3, 4, 5]

@param a First array.
@param b Second array.
@return A new array containing all elements from a and b.
#end
Function Merge<T>:T[]( a:T[], b:T[] )
	Local na:Int = a.Length
	Local nb:Int = b.Length
	Local res:T[] = New T[na + nb]
	Local i:Int = 0, j:Int = 0, k:Int = 0
	While i < na And j < nb
		If a[i] <= b[j]
			res[k] = a[i]
			i += 1
		Else
			res[k] = b[j]
			j += 1
		End
		k += 1
	Wend
	While i < na
		res[k] = a[i]
		i += 1
		k += 1
	Wend
	While j < nb
		res[k] = b[j]
		j += 1
		k += 1
	Wend
	Return res
End

#rem monkeydoc Reverses an array in place.
Swaps elements from both ends toward the center, modifying the original array.
Used for reversing descending runs in TimSort_g and similar algorithms.

On elements [1, 2, 3, 4]

    Before: [1, 2, 3, 4]
    After: [4, 3, 2, 1]

@param arr Array to be reversed.
#end
Function Reverse<T>:T[]( arr:T[], copy:Bool=True )

	Local out:=Cpynd(arr, copy)
	
	Local left:Int = 0
	Local right:Int = out.Length-1
	While left < right
		Local tmp:T = out[left]
		out[left] = out[right]
		out[right] = tmp
		left += 1
		right -= 1
	Wend

	Return out
End

#rem monkeydoc Reverses a subrange of an array in place.
Swaps elements between the specified start and end indices, reversing the segment.
Useful for in-place reversal of partial runs or subsequences (e.g., in TimSort_g).

On elements [1, 2, 3, 4] with start=1, atEnd=2

    Only elements at indices 1 and 2 (2 and 3) are swapped.
    Before: [1, 2, 3, 4]
    After: [1, 3, 2, 4]

@param data Array containing the range to reverse.
@param start Index of the first element in the range.
@param atEnd Index of the last element in the range (inclusive).
#end
Function Reverse<T>( data:T[], start:Int, atEnd:Int, copy:Bool=True )
	
	Local out:=Cpynd(data, copy)
	
	While start < atEnd
		Local temp:T = out[start]
		out[start] = out[atEnd]
		out[atEnd] = temp
		start += 1
		atEnd -= 1
	Wend

	Return out
End

Function Reverse<T>( data:T[], start:Int Ptr, atEnd:Int Ptr, copy:Bool=True )
	
	Local out:=Cpynd(data, copy)
	
	While start[0] < atEnd[0]
		Local temp:T = out[start]
		out[start] = out[atEnd]
		out[atEnd] = temp
		start[0] += 1
		atEnd[0] -= 1
	Wend
	
	Return out
End

Function Flip<T>:T[]( this:T[], copy:Bool=True )
	'Input:
	'123456789
	'Output:
	'987654321
	
	Local out:=Cpynd(this, copy)
	
	Local size:=this.Length-1
	Local halfsize:Int=size/2
	Local k:=0

	Repeat
		Swap( Varptr out[k],Varptr out[size-k] )
		k+=1
	Until k=halfsize

	Return out
End

Function Flipflap<T>:T[]( this:T[], preserve:Bool=False, copy:Bool=True )
	'Input (odd set):
	'123456789
	'Output with preserve=False (default):
	'21436587null
	'Output with preserve=True:
	'214365879
	
	'Input (even set):
	'12345678
	'Output:
	'21436587

	'Local out:= copy ? New T[this.Length] Else this

	Local size:=out.Length-1
	Local result:T[]
	Local last:T=this[size]
	Local ends:Int
	If copy
		result=New T[this.Length]
		this.CopyTo( result,0,0,this.Length )
	Else
		result=this
	End
	If this.Length Mod 2 'odd
		Local subber:Int
		#If __DEBUG__
			subber=4
		#Else
			subber=3
		#Endif
		ends=(size-subber)*2
		For Local n:=0 Until ends Step 2
			Swap( Varptr result[n],Varptr result[n+1] )
		Next
		#If __DEBUG__
			result[size]=null
		#Endif
		If preserve result[size]=this[size]
	Else 'even
		ends=(size-3)*2
		For Local n:=0 Until ends Step 2
			Swap( Varptr result[n],Varptr result[n+1] )
		Next
	End
	Return result
End

Function Rotate<T>:T[]( this:T[], pivot:Int=Null, copy:Bool=True )
	' Output (for pivot=4):
	' 123456789 (input)
	' 765432198
	
	' Note:
	'	Algo:
	'		Input(pivot): 	123456789 (4)
	'		Inverse:		987654321
	'		Rot(vec):		765432198 (-2)
	'		Output:  		765432198

	'		Input(pivot): 	123456789 (6)
	'		Inverse:		987654321
	'		Rot(vec):		219876543 (2)
	'		Output:  		219876543
	
	If pivot=Null Return Inverse( this, copy )
	Local size:=this.Length-1
	Local mid:Int=Ceil(Float(this.Length)/2)
	Local vec:=-((mid+(mid-pivot))-pivot) 'pivot's rotation & vector computation inlined
	If copy
		Local out:=Inverse(New T[this.Length])
		Return Rot( out,vec,True )
	End
	Inverse( this )
	Return Rot( this,vec,False )
End

Function Stretch<T>:T[]( this:T[], factor:Int=0, copy:Bool=True )
	Return Scale(this,factor,copy)
End

Function Scale<T>:T[]( this:T[], factor:Int=0, copy:Bool=True )
	' Element-wise stretch/shrink of an array.
	' Expansion: repeats each element by 'factor'.
	' Contraction: keeps every abs(factor)-th element, always preserves first and last.
	' It the equivalent of Py's repeat: np.repeat([1,2,3], 3) → [1,1,1,2,2,2,3,3,3]
	' Examples:
	'  with [1,2,3], Stretch(3) → [1,1,1,2,2,2,3,3,3]
	'  with [1,2,3], Stretch(-2) → [1,3]
	'  with [1,2,3,4,5,6,7,8], Stretch(-2) → [1,3,5,8]
	'  with [1,2,3,4,5,6], Stretch(-2) → [1,3,6]

	Local n:=this.Length
	If factor=0 Or n=0
		Return New T[0]
	Elseif factor=1
		If copy
			Local out:=New T[n]
			this.CopyTo(out,0,0,n)
			Return out
		Else
			Return this
		End
	Elseif factor > 1
		Local out:=New T[n*factor]
		Local k:=0
		For Local i:=0 Until n
			For Local j:=0 Until factor
				out[k]=this[i]
				k+=1
			End
		End
		Return out
	Else ' factor < 0
		Local stride:= -factor
		If stride < 2 stride=2 'minimum stride is 2 to always include first/last
		' Compute output length: always includes first and last
		Local outlen:=1
		If n>1
			outlen = ((n-2)/stride)+2
		End
		Local out:=New T[outlen]
		Local k:=0
		For Local i:=0 Until n
			If i=0 Or i=n-1 Or (i Mod stride=0 And i<n-1)
				out[k]=this[i]
				k+=1
			End
		End
		' Ensure last element is set (in case stride doesn't land exactly on last element)
		If k<outlen out[outlen-1]=this[n-1]
		Return out
	End
End

Function Tile<T>:T[]( this:T[], factor:Int=0, copy:Bool=True )
	' Expands or contracts the array by a scale factor.
	' Examples:
	'  with [1,2,3], Tile(3) → [1,2,3,1,2,3,1,2,3]
	'  with [1,2,3], Tile(-2) → [1,2]
	'  with [1,2,3], Tile(0) → []
	'  with [1,2,3], Tile(1) → [1,2,3] (copy if copy=True, else original)

	Local out:T[]
	Local n:=this.Length

	If factor=0
		out = New T[0]
		Return out
	Elseif factor=1
		If copy
			out = New T[n]
			this.CopyTo( out, 0, 0, n )
			Return out
		Else
			Return this
		End
	Elseif factor > 1
		out = New T[n * factor]
		For Local k:=0 Until factor
			this.CopyTo( out, 0, k*n, n )
		End
		Return out
	Else ' factor < 0
		Local newlen := -factor
		If newlen > n newlen = n
		out = New T[newlen]
		this.CopyTo( out, 0, 0, newlen )
		Return out
	End
	Return this
End

#rem monkeydoc Rot - Cyclically rotates an array left/right by shift
@author: iDkP for GaragePixel,
@since 2021?
#end
Function Rot<T>:T[]( arr:T[], shift:Int, copy:Bool=True )
'	' this = "123456789"
'	' Print Rot( this, -3 )
'	' Output:
'	' 456789123
	If arr.Length=0 Or shift=0 Return arr
	Local n:=arr.Length
	Local vec:Int = shift Mod n
	If vec<0 vec = n+vec
	' Now vec is always in [0, n)
	Local result:T[] = New T[n]
	Local k:Int = 0
	' Copy from vec to end
	For Local i:=vec Until n
		result[k]=arr[i]
		k+=1
	End
	' Copy from 0 to vec-1
	For Local i:=0 Until vec
		result[k]=arr[i]
		k+=1
	End
	'We can replace the copy loop and conditional with a concise one-liner from the new ToCopy:
	Return copy ? result Else CopyTo(result,arr,0,0,result.Length)
End

Function RotL<T>:T[]( this:T[],offset:Int=Null,copy:Bool=True )
	' this = "123456789"
	' Output (offset=6)
	' 678912345
	Local size:=this.Length
	If offset=Null offset=size/2
	Local result:T[]=New T[size]
	Local k:=0, n:Int
	Local offsetsub1:=offset-1
	For n=offsetsub1 Until size 'after
		result[k]=this[n]
		k+=1
	Next
	For n=0 Until offsetsub1 'before
		result[k]=this[n]
		k+=1
	Next
	If Not copy
		this=result
		result=this
	End
	Return result
End

Function RotR<T>:T[]( this:T[],offset:Int=Null,copy:Bool=True )
	' this = "123456789"
	' Output (offset=6)
	' 678912345
	Local size:=this.Length
	If offset=Null offset=size/2
	Local result:T[]=New T[size]
	Local k:=0, n:Int
	For n=offset Until size 'after
		result[k]=this[n]
		k+=1
	Next
	For n=0 Until offset 'before
		result[k]=this[n]
		k+=1
	Next
	If Not copy
		this=result
		result=this
	End
	Return result
End

Function Interleave<T>:T[]( this:T[],bidirectional:Bool=False,copy:Bool=True )
	' Output (for offset=4):
	' 123456789 (input)
	' 162738495 (bidirectional=False, unidirectional)
	' 192837465 (bidirectional=True, bidirectional)
	Local size:=this.Length
	Local halfsize:Int=Floor(size/2)
	Local result:T[]=New T[size]
	If bidirectional
		If size Mod 2
			halfsize=Ceil(size/2)+1 'odd
			size-=1
			For Local n:=0 Until halfsize
				result[n*2]=this[n]
				If size-n<=size-1 result[n*2-1]=this[size-n+1]
			Next
		Else 'even
			For Local n:=0 Until halfsize
				result[n*2]=this[n]
				result[n*2+1]=this[size-n-1]
			Next
		End
	Else
		If this.Length Mod 2 halfsize+=1 'odd
		For Local n:=0 Until halfsize
			result[n*2]=this[n]
			If n+halfsize<=size-1
				result[n*2+1]=this[n+halfsize]
			End
		Next
	End
	If Not copy
		this=result
		result=this
	End
	Return result
End

Function Twirl<T>:T[]( this:T[],offset:Int=Null,symmetry:Bool=False,copy:Bool=True	)
	' Original function's name and concept by iDkP for GaragePixel

	' No standard library in Python, JavaScript, C++, or .NET provides a function
	' with this exact mix of behaviors or the name Twirl.
	' "Twirl" as a name and this behavior is original, as far as I know.

	' The name and (especially) the behavior (with offset insertion)
	' are unique to GaragePixel's stdlib.
	' The symmetry mode-partial segment mirror-is really inventive, it can be
	' interesting for pattern generation or data shaping.
	'
	' Technical advantages & detailed explanations:
	'
	'- Pattern Generation:
	'	- Useful for generating palindromic or mirrored sequences,
	'	such as constructing symmetric numeric or character arrays
	'	for visual or audio pattern synthesis.
	'
	'- Data Shaping:
	'	- Can reshape time-series or spatial data for algorithms that require
	'	symmetric boundary conditions (e.g., in signal processing or cellular automata).
	'
	'- Testing & Debugging:
	'	- Generates controlled, mirrored test datasets to verify the correctness of algorithms
	'	sensitive to symmetric input.
	'
	'- Graphics & Procedural Content:
	'	- Creates symmetric patterns for procedural textures, tilemaps,
	'	or effects needing mirrored halves (e.g., vertical/horizontal symmetry
	'	in sprites or backgrounds).
	'
	'- Genetics & Algorithms:
	'	- Simulates chromosomal inversion or crossover operations
	'	where a segment of data is reversed and rejoined, as in genetic algorithms or bioinformatics.
	'
	'- Puzzle & Game Mechanics:
	'	- Produces symmetric game board states or mirrored move lists for puzzle generation,
	'	analysis, or fairness checks.
	'
	'- Encryption & Obfuscation (toy examples):
	'	- Prepares mirrored data blocks as a lightweight form of obfuscation or as a step
	'	in custom encoding/decoding pipelines.
	
	' Output (for offset=4, symmetry=false):
	' 567894123
	' Output (for offset=4, symmetry=true):
	' 123456789
	' 987654123
	Local size:=this.Length
	If offset=Null offset=size/2
	Local result:T[]=New T[size]
	Local k:=0, n:Int
	Local offsetsub1:=offset-1
	If symmetry
		Local offsetsub2:=offsetsub1-1
		n=size-1
		Repeat
			result[k]=this[n]
			k+=1
			n-=1
		Until n=offsetsub2
		For n=0 Until offsetsub1
			result[k]=this[n]
			k+=1
		Next
	Else
		For n=offset Until size 'after
			result[k]=this[n]
			k+=1
		Next
		result[k]=offset 'line
		k+=1
		For n=0 Until offsetsub1 'before
			result[k]=this[n]
			k+=1
		Next
		If Not copy
			this=result
			result=this
		End
	End
	Return result
End

Function RotateByOffset<T>:T[]( this:T[],offset:Int=Null,copy:Bool=True )
	
	' Output (for offset=4):
	' 456789123
	
	Local size:=this.Length
	If offset=Null offset=size/2
	Local result:T[]=New T[size]
	Local n:Int, k:=0
	
	For n=offset-1 Until size
		result[k]=this[n]
		k+=1
	End
	
	For n=0 Until offset-1
		result[k]=this[n]
		k+=1
	End
	
	If Not copy 
		this=result
		result=this
	End
	
	Return result
End
