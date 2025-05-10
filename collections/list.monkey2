
Namespace stdlib.collections

#rem monkeydoc Convenience type alias for List\<Int\>.
#end
Alias IntList:List<Int>

#rem monkeydoc Convenience type alias for List\<Float\>.
#end
Alias FloatList:List<Float>

#rem monkeydoc Convenience type alias for List\<String\>.
#end
Alias StringList:List<String>

#rem monkeydoc The List class provides support for linked lists.

A linked list is a container style data structure that provides efficient support for the addition, removal and sequential traversal of objects.

A linked list works by connecting elements together with 'next' and 'previous' references, making it very efficient to get from one element to the next, but not so efficient for accessing arbitrary elements.

This connection between elements is achieved using separate Node objects (there is one per element) which contain references to the next and previous nodes in the list, as well as the actual object managed by the node.

Lists implements the [[IContainer]] interface so can be used with Eachin loops.

#end
Class List<T> Implements IContainer<T>

	#rem monkeydoc The List.Node class.
	#end
	Class Node
	
		Private
	
		Field _succ:Node
		Field _pred:Node
		Field _value:T
		
		Public

		#rem monkeydoc Creates a new node not in any list.
		#end		
		Method New( value:T )
			_value=value
			_succ=Self
			_pred=Self
		End
		
		#rem monkeydoc Creates a new node with the given successor node.
		
		Warning! No error checking is performed!
		
		This method should not be used while iterating over the list containing `succ`.
		
		#end
		Method New( value:T,succ:Node )
			_value=value
			_succ=succ
			_pred=succ._pred
			_pred._succ=Self
			succ._pred=Self
		End
		
		#rem monkeydoc Gets the node after this node.
		#end
		Property Succ:Node()
			Return _succ
		End
		
		#rem monkeydoc Gets the node before this node.
		#end
		Property Pred:Node()
			Return _pred
		End

		#rem monkeydoc Gets the value contained in this node.
		#end		
		Property Value:T()
			Return _value
		Setter( value:T )
			_value=value
		End
		
		#rem monkeydoc Removes this node.
		
		Warning! No error checking is performed!
		
		This method should not be used while iterating over the list containing this node.
		
		#end
		Method Remove()
			If _succ._pred<>Self Or _pred._succ<>Self Return
			_succ._pred=_pred
			_pred._succ=_succ
		End
		
		#rem monkeydoc Inserts the node before another node.
		
		If the node is already in a list, it is removed before insertion.
		
		This method should not be used while iterating over the list containing this node or `node`.
		
		#end
		Method InsertBefore( node:Node )
			Remove()
			'insert
			_succ=node
			_pred=node._pred
			_pred._succ=Self
			node._pred=Self
		End
		
		#rem monkeydoc Inserts the node after another node.
		
		If the node is already in a list, it is removed before insertion.
		
		This method should not be used while iterating over the list containing this node or `node`.
		
		#end
		Method InsertAfter( node:Node )
			Remove()
			'insert
			_pred=node
			_succ=node._succ
			_succ._pred=Self
			node._succ=Self
		End
		
	End
	
	#rem monkeydoc The List.Iterator struct.
	#end
	Struct Iterator
	
		Private
	
		Field _list:List
		Field _node:Node
		
		Method AssertCurrent()
			DebugAssert( _node<>_list._head,"Invalid list iterator" )
		End
		
		Public
		
		#rem monkeydoc Creates a new iterator.
		#end
		Method New( list:List,node:Node )
			_list=list
			_node=node
		End

		#rem monkeydoc Checks whether the iterator has reached the end of the list.
		#end
		Property AtEnd:Bool()
			Return _node=_list._head
		End
		
		#rem monkeydoc The value contained in the node pointed to by the iterator.
		#end
		Property Current:T()
			AssertCurrent()
			Return _node._value
			
		Setter( current:T )
			AssertCurrent()
			_node._value=current
		End
		
		#rem monkeydoc Bumps the iterator so it points to the next node in the list.
		#end
		Method Bump()
			AssertCurrent()
			_node=_node._succ
		End
		
		#rem monkeydoc Safely erases the node referenced by the iterator.
		
		After calling this method, the iterator will point to the node after the removed node.
		
		Therefore, if you are manually iterating through a list you should not call [[Bump]] after calling this method or you
		will end up skipping a node.
		
		#end
		Method Erase()
			AssertCurrent()
			_node=_node._succ
			_node._pred.Remove()
		End
		
		#rem monkeydoc Safely insert a value before the iterator.

		After calling this method, the iterator will point to the newly added node.
		
		#end
		Method Insert( value:T )
			_node=New Node( value,_node )
		End
	End
	
	#rem monkeydoc The List.BackwardsIterator struct.
	#end
	Struct BackwardsIterator
	
		Private
	
		Field _list:List
		Field _node:Node
		
		Method AssertCurrent()
			DebugAssert( _node<>_list._head,"Invalid list iterator" )
		End
		
		Public
		
		#rem monkeydoc Creates a new iterator.
		#end
		Method New( list:List,node:Node )
			_list=list
			_node=node
		End

		#rem monkeydoc Checks whether the iterator has reached the end of the list.
		#end
		Property AtEnd:Bool()
			Return _node=_list._head
		End
		
		#rem monkeydoc The value contained in the node pointed to by the iterator.
		#end
		Property Current:T()
			AssertCurrent()
			Return _node._value
			
		Setter( current:T )
			AssertCurrent()
			_node._value=current
		End
		
		#rem monkeydoc Bumps the iterator so it points to the next node in the list.
		#end
		Method Bump()
			AssertCurrent()
			_node=_node._pred
		End
		
		#rem monkeydoc Safely erases the node referenced by the iterator.
		
		After calling this method, the iterator will point to the node after the removed node.
		
		Therefore, if you are manually iterating through a list you should not call [[Bump]] after calling this method or you
		will end up skipping a node.
		
		#end
		Method Erase()
			AssertCurrent()
			_node=_node._pred
			_node._succ.Remove()
		End
		
		#rem monkeydoc Safely insert a value before the iterator.

		After calling this method, the iterator will point to the newly added node.
		
		#end
		Method Insert( value:T )
			_node=New Node( value,_node._succ )
		End
	End
	
	Private
	
	Field _head:Node
	
	Public
	
	#rem monkeydoc Creates a new list.
	
	New() create a new empty list.
	
	New( T[] ) creates a new list with the elements of an array.
	
	New( List<T> ) creates a new list with the contents of another list.
	
	New( Stack<T> ) create a new list the contents of a stack.
	
	@param values An existing array, list or stack.
	
	#end
	Method New()
		_head=New Node( Null )
	End

	Method New( values:T[] )
		Self.New()
		AddAll( values )
	End
	
	Method New( values:Stack<T> )
		Self.New()
		AddAll( values )
	End
	
	Method New( values:List<T> )
		Self.New()
		AddAll( values )
	End
	
	#rem monkeydoc Gets an iterator for visiting list values.
	
	Returns an iterator suitable for use with Eachin, or for manual iteration.
	
	@return A list iterator.
	
	#end
	Method All:Iterator()
		Return New Iterator( Self,_head._succ )
	End

	#rem monkeydoc Gets an iterator for visiting list values in reverse order.
	
	Returns an iterator suitable for use with Eachin, or for manual iteration.
	
	@return A backwards list iterator.
	
	#end	
	Method Backwards:BackwardsIterator()
		Return New BackwardsIterator( Self,_head._pred )
	End
	
	#rem monkeydoc Checks whether the list is empty.
	
	@return True if the list is empty.
	
	#end
	Property Empty:Bool()
		Return _head._succ=_head
	End
	
	#rem monkeydoc Counts the number of values in the list.
	
	Note: This method can be slow when used with large lists, as it must visit each value. If you just
	want to know whether a list is empty or not, use [[Empty]] instead.

	@return The number of values in the list.
	
	#end
	Method Count:UInt() 'iDkP: UNSIGNED 32 bits!
		Local node:=_head._succ,n:=0
		While node<>_head
			node=node._succ
			n+=1
		Wend
		Return n
	End
	
	#rem monkeydoc Converts the list to an array.
	
	@return An array containing the items in the list.
	
	#end
	Method ToArray:T[]()
		Local n:=Count()
		Local data:=New T[n],node:=_head._succ
		For Local i:=0 Until n
			data[i]=node._value
			node=node._succ
		Next
		Return data
	End
	
	#rem monkeydoc Gets the first value in the list.
	
	In debug builds, a runtime error will occur if the list is empty.
	
	@return The first value in the list.
	
	#end
	Property First:T()
		DebugAssert( Not Empty )
		
		Return _head._succ._value
	End
	
	#rem monkeydoc Gets the last value in the list
	
	In debug builds, a runtime error will occur if the list is empty.
	
	@return The last value in the list.
	
	#end
	Property Last:T()
		DebugAssert( Not Empty )
		
		Return _head._pred._value
	End
	
	#rem monkeydoc Removes all values from the list.
	
	#end
	Method Clear()
		_head._succ=_head
		_head._pred=_head
	End
	
	#rem monkeydoc Adds a value to the start of the list.
	
	@param value The value to add to the list.
	
	@return A new node containing the value.

	#end
	Method AddFirst:Node( value:T )
		Local node:=New Node( value,_head._succ )
		Return node
	End
	
	#rem monkeydoc Adds a value to the end of the list.

	@param value The value to add to the list.
	
	@return A new node containing the value.

	#end
	Method AddLast:Node( value:T )
		Local node:=New Node( value,_head )
		Return node
	End
	
	#rem monkeydoc Removes the first value in the list equal to a given value.
	
	@param value The value to remove.

	@return True if a value was removed.
		
	#end
	Method Remove:Bool( value:T )
		Local node:=FindNode( value )
		If Not node Return False
		node.Remove()
		Return True
	End
	
	#rem monkeydoc Removes the last value in the list equal to a given value.
	
	@param value The value to remove.
	
	@return True if a value was removed.
		
	#end
	Method RemoveLast:Bool( value:T )
		Local node:=FindLastNode( value )
		If Not node Return False
		node.Remove()
		Return True
	End
	
	#rem monkeydoc Removes all values in the list equal to a given value.
	
	@param value The value to remove.
	
	@return The number of values removed.
	
	#end
	Method RemoveEach:Int( value:T )
		Local node:=_head._succ,n:=0
		While node<>_head
			If node._value=value
				node=node._succ
				node._pred.Remove()
				n+=1
			Else
				node=node._succ
			Endif
		Wend
		Return n
	End
	
	#rem monkeydoc Removes all values in the list that fulfill a condition.
	
	@param cond Condition to test.
	
	@return The number of values removed.
	
	#end
	Method RemoveIf:Int( condition:Bool( value:T ) )
		Local node:=_head._succ,n:=0
		While node<>_head
			If condition( node._value )
				node=node._succ
				node._pred.Remove()
				n+=1
			Else
				node=node._succ
			Endif
		Wend
		Return n
	End
	
	#rem monkeydoc Removes and returns the first value in the list.
	
	In debug builds, a runtime error will occur if the list is empty.
	
	@return The value removed from the list.

	#end
	Method RemoveFirst:T()
		DebugAssert( Not Empty )
		
		Local value:=_head._succ._value
		_head._succ.Remove()
		Return value
	End
	
	#rem monkeydoc Removes and returns the last value in the list.
	
	In debug builds, a runtime error will occur if the list is empty.
	
	@return The value removed from the list.

	#end
	Method RemoveLast:T()
		DebugAssert( Not Empty )
		
		Local value:=_head._pred._value
		_head._pred.Remove()
		Return value
	End
	
	#rem monkeydoc Adds a value to the end of the list.
	
	This method behaves identically to AddLast.
	
	@param value The value to add.
	
	#end
	Method Add( value:T )
		AddLast( value )
	End

	#rem monkeydoc Adds all values in an array or container to the end of the list.
	
	@param values The values to add.
	
	@param values The values to add.
	
	#end
	Method AddAll( values:T[] )
		For Local value:=Eachin values
			AddLast( value )
		Next
	End

	Method AddAll<C>( values:C ) Where C Implements IContainer<T>
		For Local value:=Eachin values
			AddLast( value )
		Next
	End
	
	#rem monkeydoc Sorts the list.
	
	@param ascending True to sort the stack in ascending order, false to sort in descending order.
	
	@param compareFunc Function to be used to compare values when sorting.
	
	#end
	Method Sort( ascending:Int=True )
	
		If ascending
			Sort( Lambda:Int( x:T,y:T )
				Return x<=>y
			End )
		Else
			Sort( Lambda:Int( x:T,y:T )
				Return -(x<=>y)
			End )
		Endif
	End

	Method Sort( compareFunc:Int( x:T,y:T ) )
	
		Local insize:=1
		
		Repeat
		
			Local merges:=0
			Local tail:=_head
			Local p:=_head._succ

			While p<>_head
				merges+=1
				Local q:=p._succ,qsize:=insize,psize:=1
				
				While psize<insize And q<>_head
					psize+=1
					q=q._succ
				Wend

				Repeat
					Local t:Node
					If psize And qsize And q<>_head
						Local cc:=compareFunc( p._value,q._value )
						If cc<=0
							t=p
							p=p._succ
							psize-=1
						Else
							t=q
							q=q._succ
							qsize-=1
						Endif
					Else If psize
						t=p
						p=p._succ
						psize-=1
					Else If qsize And q<>_head
						t=q
						q=q._succ
						qsize-=1
					Else
						Exit
					Endif
					t._pred=tail
					tail._succ=t
					tail=t
				Forever
				p=q
			Wend
			tail._succ=_head
			_head._pred=tail

			If merges<=1 Return

			insize*=2
		Forever

	End
	
	#rem monkeydoc Joins the values in the string list.
	
	@param sepeator The separator to be used when joining values.
	
	@return The joined values.
	
	#end
	Method Join:String( separator:String="" ) Where T=String
		Return separator.Join( ToArray() )
	End

	#rem monkeydoc Gets the head node of the list.
	#end
	Method HeadNode:Node()
		Return _head
	End
	
	#rem monkeydoc Gets the first node in the list.
	
	@return The first node in the list, or null if the list is empty.
	
	#end
	Method FirstNode:Node()
		If Not Empty Return _head._succ
		Return Null
	End
	
	#rem monkeydoc Gets the last node in the list.
	
	@return The last node in the list, or null if the list is empty.
	
	#end
	Method LastNode:Node()
		If Not Empty Return _head._pred
		Return Null
	End
	
	#rem monkeydoc Finds the first node in the list containing a value.
	
	@param value The value to find.
	
	@return The first node containing the value, or null if the value was not found.
	
	#end
	Method FindNode:Node( value:T )
		Local node:=_head._succ
		While node<>_head
			If node._value=value Return node
			node=node._succ
		Wend
		Return Null
	End
	
	#rem monkeydoc Finds the last node in the list containing a value.
	
	@param value The value to find.
	
	@return The last node containing the value, or null if the value was not found.
	
	#end
	Method FindLastNode:Node( value:T )
		Local node:=_head._pred
		While node<>_head
			If node._value=value Return node
			node=node._pred
		Wend
		Return Null
	End

	#rem monkeydoc Return a copy of the list
	@return Copy of the list
	#end
	Method Copy:List<T>() 'Added by iDkP from GaragePixel
		'Added for consistency (there is an operator to copy a list, 
		'but it is not obvious for a new user of the library)
		Return New List<T>( Self )
	End

	'----------------------------------------------
	' Extension: List As Queue
	' iDkP from GaragePixel
	' 2024-11
	'
	'List with the Queue instructions' set
	'
	'Note: 
	'	Should we use Deque to implement a similar instruction set?	
	'
	'	FIFO Operations:
	'		Possible usage of the list as queue is the implementation of BFS (Breadth-First Search).
	'----------------------------------------------

	#rem monkeydoc Same than AddFirst, but return nothing.
	@param value The value to add to the list.
	#end
	Method Enqueue(n:T)
		AddFirst(n)
	End 

	#rem monkeydoc Same than RemoveFirst.
	@param value The value to add to the list.
	#end	
	Method Dequeue:T()
		Return RemoveFirst()
	End

	'----------------------------------------------
	' Mini-library: Set (math) functions with List
	' 2025-05-10 - Added by iDkP from GaragePixel
	'
	' MakeUnique, MakeUniqueFast, MakeUniqueType
	' Contains, Append, Union, Intersect, Diff
	'----------------------------------------------
		
	#rem monkeydoc Make the items (only internal type accepted) of the list unique, keep the original order. 
	@param onPlace if False, return a copy of the List
	@return Copy of the list or Null
	#end
	Method MakeUnique:List<T>(onPlace:Bool=True) Where T=IReal Or T=INumeric Or T=String Or T=Byte Or T=Bool Or T=Variant 'Added by iDkP from GaragePixel
		
		' iDkP from GaragePixel
		' 2025-05-10 - Original algorithm for stdlib: 
		' https://github.com/GaragePixel/stdlib-for-mx2/tree/main
		'
		' Note: 
		'	- The algorithm uses a 32 bit enumerator, it's okay
		' 	- Hyper fast algorithm using the red-black tree implementation of map (see note under)
		' 	Source red-black tree: https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
		'
		' Info:
		'	In MaxScript, there was a function called MakeUniqueName() 
		'	to ensure that a node was instantiated with a unique label. 
		'	You can now enjoy that with this language.

		Local map:=New Map<T,UInt>() 'Hash Key calculated from the T value, value as 32 bit marked
		Local listItem:List<T>.Node=FirstNode() 'A node from List
		Local listValue:T 'A value from List
		Local value:UInt '32 bit marker
		Local result:=New List<T> 'pruned list
		Local op:UInt 'The list is defined as quasicircular (no root, but floating head) so we need a tracker
		
		'Map the values and note how many times they appear in the list
		Repeat
			
			listValue=map.Get(listItem.Value)
			
			If listValue<>Null
				map.Set(listItem.Value,map.Get(listItem.Value)+1)
			End
			
			listItem=listItem.Succ
			op+=1
			
		Until listItem=HeadNode()
		
		'As a backward iteration, put the value marked 1 in the result list, otherwise decrement
		listItem=LastNode()
		Repeat
			
			value=map.Get(listItem.Value)
			
			If value=1
				result.AddFirst(listItem.Value)
			Else 
				map.Set(listItem.Value,value-1)
			End 
			
			listItem=listItem.Pred
			op-=1
			
		Until op=0
		
		'Finaly, if onPlace, set the actual self
		
		If onPlace 
		
			'As an extension, the self list should be refilled
'			Clear() 
'			For Local i:=Eachin result 
'				Add(result.FindNode(i).Value)
'			End

			'But since the method was integrated, we can directly set self
			_head=result._head
			
			Return Null
			
		' Else return Result if not onPlace
		End
		
		Return result
	End 

	#rem monkeydoc Make the items (only internal type accepted) of the list unique, 
	but do not keep the original order (faster).
	@param onPlace if False, return a copy of the List
	@return Copy of the list or Null
	#end
	Method MakeUniqueFast:List<T>(onPlace:Bool=True) Where T=IReal Or T=INumeric Or T=String Or T=Byte Or T=Bool Or T=Variant 'Added by iDkP from GaragePixel
		
		'iDkP from GaragePixel
		'2025-05-10 - Original algorithm for stdlib: 
		'https://github.com/GaragePixel/stdlib-for-mx2/tree/main
		'
		' Note: 
		' 	- Hyper fast algorithm using the red-black tree implementation of map (see note under)
		' 	Source red-black tree: https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
		'
		' 	- This method only takes internal type because:
		' 		- To make a key from map, the type must be an internal type, not a custom type
		'
		'	- Do not need to be output in the exact same order from the input
		'
		' Info:
		'	In MaxScript, there was a function called MakeUniqueName()
		'	to ensure that a node was instantiated with a unique label. 
		'	You can now enjoy that with this language. If the item's order
		'	don't makes a deal, you can use this faster version of MakeUnique().

		Local map:=New Map<T,T>() 'Hash Key calculated from the T value, value as T
		Local listItem:List<T>.Node=FirstNode() 'A node from List
		Local result:=New List<T> 'pruned list
		
		'Put in the map the list's values (will be set one time by value)
		Repeat
			
			map.Set(listItem.Value,listItem.Value)
			listItem=listItem.Succ
			
		Until listItem=HeadNode()
		
		'Retrieve the map's values:
		
		'Finaly, if onPlace, set the actual self
		If onPlace 
		
			Clear()
			For Local n:=Eachin map
				Add(n.Value)
			Next
			
			Return Null
		End 
			
		'Else return Result if not onPlace
		For Local n:=Eachin map
			result.Add(n.Value)
		Next
		
		Return result
	End

	#rem monkeydoc Make the items (any custom type accepted) of the list unique, keep the original order.
	@param onPlace if False, return a copy of the List
	@return Copy of the list or Null
	#end
	Method MakeUniqueType:List<T>(onPlace:Bool=True) 'Added by iDkP from GaragePixel

		' iDkP from GaragePixel
		' 2025-05-11 - Original algorithm

		Local currList:= onPlace ? Self Else Copy()
		
		Local count:=currList.Count()
		If count=1 Return currList
		
		Local firstNode:List<T>.Node=currList.FirstNode()

		If count=2
			If firstNode.Value=firstNode.Succ.Value
				firstNode.Succ.Remove()
				Return currList
			Else 
				Return currList
			End 
		End 

		'Global loop
		Local node:=firstNode 'Used to parse the list. Because FirstNode() has a guard we don't want, we call it only one time
		Local nodeItem:=firstNode 'Current treated item
		Local nodeToCompare:=firstNode 'Second item to compare with the current treated item
		Local lastNode:=currList.LastNode() 'memoirize that
		
		'Inner loop
		Local occurance:UInt '32 bits - count the number of duplicates in a list for the on-going treated item
		Local actCount:=count '32 bits - active count, keep track of the number of items
		Local lp:UInt=count+1 '32 bits - loop left, sets on the active count
		Local comps:UInt '32 bits - used for the matching loop
		Local op:UInt '32 bits - used for counting the deletions to perform
		
		'Speed up
		Local lastHead:=lastNode '32 bits - used to stick the head on the last duplicate detected
		Local lastCnt:UInt '32 bits - used to calculate the head from the number of planned deletions

		Repeat

			occurance=0
			nodeToCompare=firstNode
			comps=actCount
			
			lastCnt=0
			Repeat
				
				'we need to compare the node's value, where T could be from any type
				If nodeToCompare.Value=nodeItem.Value 
					occurance+=1
					lastHead=nodeToCompare
					lastCnt-=1
				End
				nodeToCompare=nodeToCompare.Succ
				comps-=1
				lastCnt+=1

			Until comps=0
			
			If occurance>1

				op=count-lastCnt
				node=lastHead

				Repeat
					'same than above, we need to compare the node's value, where T could be from any type
					If node.Value=nodeItem.Value
						node=node.Pred
						node.Succ.Remove()
						occurance-=1						
						actCount-=1
						op-=1
						lp-=1
					End 

					node=node.Pred
					op-=1

				Until op=1 Or occurance=1 'Stop without checking the whole list if we know it was the last one duplicate

			End 

			nodeItem=nodeItem.Succ

		lp-=1
		Until lp=0

		Return currList
	End

	#rem monkeydoc Finds the first node in the list containing a value.
	@param value The value to find.
	@return The first node containing the value, or null if the value was not found.
	#end	
	Method Contains:Node( value:T ) 'Added by iDkP from GaragePixel
		'iDkP: Added as sugar for front-end consistance with map
		Return FindNode(value)
	End

	#rem monkeydoc Add each keys from this (param) to self
	@param This The list to compare.
	@param onPlace if False, returns a copy of the list, else nothing
	#end
	Method Append:List<T>(this:List<T>,onPlace:Bool=True) 'Added by iDkP from GaragePixel
		'Sugar
		If onPlace 
			Self.AddAll(this)
			Return Null
		End
		Local result:=Copy()
		result.AddAll(this)
		Return result
	End

	#rem monkeydoc Add each item from this (param) that exist in self. 
	Each item will be unique and in the same order from the two original lists. 
	Note: Make also unique the items in the two original list.
	@param This The list to compare.
	@param onPlace if False, returns a copy of the list, else nothing
	#end	
	Method Union:List<T>(this:List<T>,onPlace:Bool=True) Where T=IReal Or T=INumeric Or T=String Or T=Byte Or T=Bool Or T=Variant 'Added by iDkP from GaragePixel
		'
		' iDkP from GaragePixel
		' 2025-05-10 - Original algorithm for stdlib: 
		' https://github.com/GaragePixel/stdlib-for-mx2/tree/main
		'
		' Description:
		' 	Add this to self, do not keep doublons in the output list.
		'
		' Note:
		' 	Hyper fast algorithm using the red-black tree implementation of map (see note under)
		'		Source red-black tree: https://en.wikipedia.org/wiki/Red%E2%80%93black_tree
		'
		' 	This method only takes internal type because:
		' 		- To make a key from map, the type must be an internal type, not a custom type
		'
		If onPlace 
			Self.AddAll(this)

			'--------------------------
			'
			'Strange bug:  
			'	Can't find overload for 'MakeUnique' with argument types (monkey.types.Bool)
			'
			'Return MakeUnique(True) 'Strange bug:  Can't find overload for 'MakeUnique' with argument types (monkey.types.Bool)
			'
			'--------------------------

			' Need to un-inlined because the strange bug
			Local map:=New Map<T,UInt>() 'Hash Key calculated from the T value, value as 32 bit marked
			Local listItem:List<T>.Node=FirstNode() 'A node from List
			Local listValue:T 'A value from List
			Local value:UInt '32 bit marker
			Local out:=New List<T> 'pruned list
			Local op:UInt 'The list is defined as quasicircular (no root, but floating head) so we need a tracker
			
			'Map the values and note how many times they appear in the list
			Repeat
				
				listValue=map.Get(listItem.Value)
				
				If listValue<>Null
					map.Set(listItem.Value,map.Get(listItem.Value)+1)
				End
				
				listItem=listItem.Succ
				op+=1
				
			Until listItem=HeadNode()
			
			'As a backward iteration, put the value marked 1 in the out list, otherwise decrement
			listItem=LastNode()
			Repeat
				
				value=map.Get(listItem.Value)
				
				If value=1
					out.AddFirst(listItem.Value)
				Else 
					map.Set(listItem.Value,value-1)
				End 
				
				listItem=listItem.Pred
				op-=1
				
			Until op=0
			
			'Finaly, directly set self
			_head=out._head
				
			Return Null
			
		End 'onPlace version
		
		'------------------------- "returns a copy of the list" Version
		
		Local result:=Copy()
		result.AddAll(this)

		'--------------------------
		'
		'Strange bug:  
		'	Can't find overload for 'MakeUnique' with argument types (monkey.types.Bool)
		'
		'result.MakeUnique(True) 
		'Return result
		'
		'--------------------------

		' Need to un-inlined because the strange bug
		Local map:=New Map<T,UInt>() 'Hash Key calculated from the T value, value as 32 bit marked
		Local listItem:List<T>.Node=result.FirstNode() 'A node from List
		Local listValue:T 'A value from List
		Local value:UInt '32 bit marker
		Local out:=New List<T> 'pruned list
		Local op:UInt 'The list is defined as quasicircular (no root, but floating head) so we need a tracker
		
		'Map the values and note how many times they appear in the list
		Repeat
			
			listValue=map.Get(listItem.Value)
			
			If listValue<>Null
				map.Set(listItem.Value,map.Get(listItem.Value)+1)
			End
			
			listItem=listItem.Succ
			op+=1
			
		Until listItem=result.HeadNode()
		
		'As a backward iteration, put the value marked 1 in the out list, otherwise decrement
		listItem=result.LastNode()
		Repeat
			
			value=map.Get(listItem.Value)
			
			If value=1
				out.AddFirst(listItem.Value)
			Else 
				map.Set(listItem.Value,value-1)
			End 
			
			listItem=listItem.Pred
			op-=1
			
		Until op=0
		
		'Finaly, return result
		Return out
	End

	#rem monkeydoc Keep all keys from self that exist in this (param)
	@param This is the list to compare.
	@param onPlace if False, returns a copy of the list, else nothing
	#end	
	Method Intersect:List<T>(this:List<T>, onPlace:Bool=True) 'Added by iDkP from GaragePixel
		'Keep in self the keys that exist in this
		If onPlace 
			For Local item:= Eachin Self
				If this.FindNode(item)=Null Self.RemoveEach(item)
			End
			Return Null
		End 
		Local result:=Copy()
		For Local item:= Eachin result
			If this.FindNode(item)=Null result.RemoveEach(item)
		End 	
		Return result	
	End

	#rem monkeydoc Remove all keys from self that exist in this (param)
	@param This is the list to compare.
	@param onPlace if False, returns a copy of the list, else nothing
	#end
	Method Diff:List<T>( this:List<T>, onPlace:Bool=True ) 'Added by iDkP from GaragePixel
		'Remove all keys from self that exist in this
		If onPlace 
			For Local item:= Eachin Self
				If this.FindNode(item)<>Null Self.RemoveEach(item)
			End
			Return Null
		End 
		Local result:=Copy()
		For Local item:= Eachin result
			If this.FindNode(item)<>Null result.RemoveEach(item)
		End 	
		Return result		
	End
End
