

Namespace stdlib.types.collections

#Import "../../limits/limits"

Using stdlib.limits

Alias IntRing<T>:Ring32<Int>
Alias FloatRing<T>:Ring32<Float>
Alias StringRing<T>:Ring32<String>

Alias Ring<T>:Ring32<T>

Alias Ring8<T>:RingB<T,UByte> 	'can contains 255 elements '231?
Alias Ring16<T>:RingB<T,UShort> 'can contains 16384 elements
Alias Ring32<T>:RingB<T,Int>  	'can contains 2147483647 elements

#rem monkeydoc The Ring class - A fixed-size circular buffer wrapper over Deque<T>.
@author iDkP from GaragePixel
@since 2025-07-11
A Ring is a fixed-capacity circular buffer that automatically overwrites the oldest elements 
when new elements are added beyond capacity.
Rings are ideal for streaming data, logging systems, and any scenario where you need 
a bounded memory footprint with automatic oldest-element eviction.
The Ring internally uses a Deque<T> for efficient O(1) operations at both ends 
while enforcing strict capacity constraints.
#end
Class RingB<T,B> Implements IContainerB<T,B> Where B Implements IShort Or B Implements ICompact

	#rem monkeydoc The Ring.Iterator struct.
	#end
	Struct Iterator Implements IIteratorB<T,B>
	
		Private
		
		Field _ring:RingB
		Field _index:Int
		Field _count:Int
		
		Public
		
		Method AssertCurrent()
			DebugAssert( Not AtEnd, "Invalid ring iterator" )
		End
		
		Method New( ring:RingB,index:B )
			_ring = ring
			_count = 0
			_index = _ring.Data.Tail
			If _index = 0 _index = _ring.Capacity - 1 Else _index -= 1
		End
		
		#rem monkeydoc Checks if the iterator has reached the end of the ring.
		#end
		Property AtEnd:Bool()
			Return _count >= _ring.Length-1
		End
		
		#rem monkeydoc The value currently pointed to by the iterator.
		#end
		Property Current:T()
			AssertCurrent()
			Return _ring.Data[_index]
		Setter( current:T )
			AssertCurrent()
			_ring.Data[_index]=current
		End
		
		#rem monkeydoc Bumps the iterator so it points to the next value in the ring.
		#end
		Method Bump()
			AssertCurrent()
			_count+=1
			_index = (_index - 1 + _ring.Capacity) Mod _ring.Capacity
		End
		
		Method Erase()
			RuntimeError( "Erase not supported for Rings" )
		End
		
		#rem monkeydoc Safely inserts a value before the value pointed to by the iterator.
		After calling this method, the iterator will point to the newly added value.
		#end
		Method Insert( value:T )
			RuntimeError( "Insert not supported for Rings" )
		End
	End
	
	Method New( capacity:B )
		Init( capacity )
	End

	Property Data:Deque<T>()
		Return _data
	End

	Property Capacity:B()
		Return _capacity
	End

	Property Length:B()
		Return _data.Length
	End
	
	Property Empty:Bool()
		Return _data.Empty
	End

	#rem monkeydoc Gets an iterator for visiting ring values.	
	Returns an iterator suitable for use with Eachin, or for manual iteration.	
	@return A ring iterator.	
	#end
	Method All:Iterator()
		'Return New Iterator( Self,_data.Head )
		Return New Iterator( Self,_data.Tail )
	End
	
	Method Push( value:T )
		If _data.Length=_maxCapacity
			_data.RemoveLast()
		End
		_data.AddFirst( value )
	End
	
	Method Push:T[]( values:T[] )
		'Local remainder:T[quantity]
		Return Null'the remainder
	End

	Method Push:T[]( values:T[], do:T(n:B,value:T) )
		'Local remainder:T[quantity]
		Push(values)
		For Local n:B=0 Until values.Length-1
			do(n,values[n])
		End 
		Return Null'the remainder
	End

	Method Flush()
		Init( _capacity )
	End
	
	Property Counts:Bool()
		Return stdlib.types.bools.All(_data)
		'Return _data.Length=0? True Else False
	End	
	
	Method Pop:T()
		Return _data.RemoveFirst()
	End
	
	Method Pop:T[](quantity:B)
		Local remainder:T[]=New T[quantity]
		For Local n:=0 Until quantity
			remainder[n]=_data.RemoveFirst()
		End 
		Return remainder
	End

	Method Pop:T[](quantity:B, do:T(n:Int,value:T) )
		Local remainder:T[]=New T[quantity]
		For Local n:=0 Until quantity
			remainder[n]=_data.RemoveFirst()
			do(n,remainder[n])
		End 
		Return remainder
	End
	#rem monkedoc Gets the value of a ring element.
	In debug builds, a runtime error will occur if `index` is less than 0, 
	or greater than or equal to the length of the ring.	
	#end
	Operator[]:T( index:Int )
		DebugAssert( index>=0 And index<Length,"Ring index out of range" )
		Return _data.Data[ index ]
	End
	
	#rem monkedoc Sets the value of a ring element.
	In debug builds, a runtime error will occur if `index` is less than 0, 
	or greater than or equal to the length of the ring.
	#end
	Operator[]=( index:Int,value:T )
		DebugAssert( index>=0 And index<Length,"Ring index out of range" )
		_data.Data[index]=value
	End
	
	Private

	Method Init( capacity:B )
		Clip(Varptr(capacity),0,Varptr(_maxCapacity))
		_capacity=capacity
		_maxCapacity=IntMax 'implicit casting
		_data=New Deque<T>()
		_data.Reserve( capacity )
	End
	
	Field _data:Deque<T>
	Field _capacity:B
	Field _maxCapacity:B=IntMax 'implicit casting
End
