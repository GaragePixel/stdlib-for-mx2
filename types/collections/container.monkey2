
Namespace stdlib.types.collections

#rem monkeydoc The IContainer interface is a 'dummy' interface that container classes should implement for compatibility with Eachin loops.

IContainer does not actually declare any members, but a class that implements IContainer should implement the follow methods:

`Method All:IteratorType()` - Gets an iterator to all values in the container.

...where `IteratorType` is a class or struct type that implements the following properties and methods:

`Property Current:ValueType()` - The current value pointed to by the iterator.

`Property AtEnd:bool()` - true if iterator is at end of container.

`Method Bump()` - Bumps the iterator so it points to the next value in the container.

...where 'ValueType' is the type of the values contained in the container.

With these conditions met, a container can be used with eachin loops. Monkey2 will automatically convert code like this:

```
For Local value:=Eachin container

	...loop code here...

Next
```

...to this...


```
Local iterator:=container.All()

While Not iterator.AtEnd

	Local value:=iterator.Current
	
	...loop code here...
	
	iterator.Bump()
Wend
```

Iterators may also provide methods for inserting and removing items...

Containers should not be modified while eachin is being used to loop through the values in the container as this can put the container into an inconsistent state. If you need to do this, you should use these optional iterator methods instead of modifying the container:

`Method Erase:Void()` - Erase the iterator from the container.

`Method Insert:Void( value:ValueType )` - Insert a value before the iterator.

For example:

```
Local iterator:=container.All()

While Not iterator.AtEnd

	Local value:=iterator.Current

	Local eraseMe:=false

    ...loop code here - may set eraseMe to true to erase current value...

	If eraseMe

		iterator.Erase()

	Else

		iterator.Bump()
	Endif
Wend
```

Note that if you erase a value, you should NOT bump the iterator - erase implicitly does this for you.

Finally, IContainer is not a 'real' interface because Monkey2 does not yet support generic interface methods. This feature is planned for a future version of monkey2.

Added iDkP:
Since 2025-07-13
The IContainerB<T> interface provides implementation for multityped Class<A,B>
#end
Interface IContainer<T>

	'Property Empty:Bool()
	
	'Method All:IIterator<T>()

	
	'Sequence methods
	
	'Method Add( value:T )
	
	'Method AddAll( value:T[] )
	
	'Method AddAll<C>( values:C )
	
	'Method Contains:Bool( value:T )
	
	'Method Remove:Bool( value:T )
	
	'Method RemoveLast:Bool( value:T )
	
	'Method RemoveEach:Int( value:T )
	
	'Method RemoveIf:Int( condition:Bool( value:T ) )
	
End
Interface IContainerB<T,B>

	'Property Empty:Bool()
	
	'Method All:IIterator<T>()

	
	'Sequence methods
	
	'Method Add( value:T )
	
	'Method AddAll( value:T[] )
	
	'Method AddAll<C>( values:C )
	
	'Method Contains:Bool( value:T )
	
	'Method Remove:Bool( value:T )
	
	'Method RemoveLast:Bool( value:T )
	
	'Method RemoveEach:Int( value:T )
	
	'Method RemoveIf:Int( condition:Bool( value:T ) )
End

#rem monkeydoc IIterator interface.
Added iDkP:
Since 2025-07-13
The IIteratorB<T> interface provides implementation for multityped Class<A,B>
#end
Interface IIterator<T>

	'Property AtEnd:Bool()
	
	'Property Current:T()
	
	'Method Bump()
	
	
	'Sequence methods
	
	'Method Erase()
	
	'Method Insert( value:T )
End
Interface IIteratorB<T,B>

	'Property AtEnd:Bool()
	
	'Property Current:T()
	
	'Method Bump()
	
	
	'Sequence methods
	
	'Method Erase()
	
	'Method Insert( value:T )
End
