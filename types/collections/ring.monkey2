

Namespace stdlib.types.collections

#Import "../../limits/limits"

Using stdlib.limits

Alias Ring8<T>:Ring<T,UByte> 'can contains 255 elements '231?
Alias Ring16<T>:Ring<T,UShort> 'can contains 16384 elements
Alias Ring32<T>:Ring<T,Int>  'can contains 2147483647 elements

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
Class Ring<T,L> Where L Implements IShort Or L Implements ICompact
	
	Method New( capacity:L )
		Reset( capacity )
	End

	Property Data:Deque<T>()
		Return _data
	End

	Property Capacity:L()
		Return _capacity
	End

	Property Length:Int()
		Return _data.Length
	End
	
	Property Empty:Bool()
		Return _data.Empty
	End
	
	Method Push( value:T )
		If _data.Length=_maxCapacity
			_data.RemoveLast()
		End
		_data.AddFirst( value )
	End

	Method Flush()
		Reset( _capacity )
	End
	
	Property Counts:Bool()
		Return All(_data)
		'Return _data.Length=0? True Else False
	End	
	
	Protected
	
	Method Pop:T()
		Return _data.RemoveFirst()
	End
	
	Private

	Method Reset( capacity:L )
		Clip(Varptr(capacity),0,Varptr(_maxCapacity))
		_capacity=capacity
		_maxCapacity=IntMax 'implicit casting
		_data=New Deque<T>()
		_data.Reserve( capacity )
	End
	
	Field _data:Deque<T>
	Field _capacity:L
	Field _maxCapacity:L=IntMax 'implicit casting
End
