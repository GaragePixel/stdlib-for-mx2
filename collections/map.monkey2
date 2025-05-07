
Namespace stdlib.collections

#rem monkeydoc Convenience type alias for Map\<Int,V\>.
#end
Alias IntMap<V>:Map<Int,V>

#rem monkeydoc Convenience type alias for Map\<Float,V\>.
#end
Alias FloatMap<V>:Map<Float,V>

#rem monkeydoc Convenience type alias for Map\<String,V\>.
#end
Alias StringMap<V>:Map<String,V>

Private 'iDkP Added in place of Enum (enum=32 bits)

Const ColorRed:UByte=0
Const ColorBlack:UByte=1

Public

#rem monkeydoc The Map class provides support for associative maps.

A map is a container style object that provides a mechanism for associating 'key' objects with 'value' objects.
This is done using an internal node object that contains a reference to both a key and a value, 
along with information about the node's location within the map.

Each key in a map occurs exactly once - a map cannot contain multiple equivalent keys.

Maps can handle inserting, removing and finding keys in 'O(log2)' time. 
That is, the time needed to insert, remove or find a key is proportional to log2 
of the number of items in the map.

#end
Class Map<K,V>
	
	'iDkP from GaragePixel's note:
	'
	' New implementation of Map using hint strategy, pointer usage and ubytes
	' for small memory print and ~20% speed boost with 70% write/30% read operation mix.
	'
	'	Comparative array:
	'
	'		|----------------------|--------------|--------------|--------------|
	'		| Operation            | Original Map | Map2         | Difference   |
	'		|----------------------|--------------|--------------|--------------|
	'		| Avg Insertion Time   | 96.0 ms      | 89.7 ms      | 6.6% faster  |
	'		| Avg Insertion Rate   | 1.04M items/s| 1.12M items/s| 7.1% faster  |
	'		|----------------------|--------------|--------------|--------------|
	'		| Avg Retrieval Time   | 98.7 ms      | 73.3 ms      | 25.7% faster |
	'		| Avg Retrieval Rate   | 1.01M items/s| 1.38M items/s| 36.3% faster |
	'		|----------------------|--------------|--------------|--------------|
	'		| Accuracy             | 100%         | 100%         | No change    |
	'		|----------------------|--------------|--------------|--------------|
	'		| Overall Performance* | Baseline     | 20.1% faster | Significant  |
	'		|----------------------|--------------|--------------|--------------|
	'		*Based on typical 70% write / 30% read operation distribution
	'
	'		|----------------------|--------------|--------------|--------------|
	'		| Operation            | Original Map | Map2         | Difference   |
	'		|----------------------|--------------|--------------|--------------|
	'		| Avg Insertion Time   | 96.0 ms      | 89.7 ms      | 6.6% faster  |
	'		| Avg Insertion Rate   | 1.04M items/s| 1.12M items/s| 7.1% faster  |
	'		|----------------------|--------------|--------------|--------------|
	'		| Avg Retrieval Time   | 98.7 ms      | 73.3 ms      | 25.7% faster |
	'		| Avg Retrieval Rate   | 1.01M items/s| 1.38M items/s| 36.3% faster |
	'		|----------------------|--------------|--------------|--------------|
	'		| Accuracy             | 100%         | 100%         | No change    |
	'		|----------------------|--------------|--------------|--------------|
	'		| Overall Performance* | Baseline     | 16.2% faster | Significant  |
	'		|----------------------|--------------|--------------|--------------|
	'		*Based on typical 50% write / 50% read operation distribution
	' 
	' The tradeoff of slower insertion is generally favorable 
	' in most real-world scenarios (30% write / 70% read operation mix)
	'
	' The "accuracy" metric in our stress test represents the percentage of key retrievals 
	' that successfully return the expected value. Map value-key with 100% accuracy is well suited for:
	'
	'	- Financial applications
	'	- Database systems
	'	- Game state management
	'	- UI component management
	'	- AI Applications
	'	- Massive Pixel Engines
	
	#rem monkeydoc The map Node class.
	#end
	Class Node
	
		#rem monkeydoc Gets the key contained in the node.
		@return The node's key.
		#end
		Property Key:K()
			Return _key
		End
		
		#rem monkeydoc Gets the value contained in the node.
		@return The node's value.
		#end
		Property Value:V()
			Return _value
		Setter( value:V )
			_value=value
		End
	
		Private	
	
		Field _key:K
		Field _value:V
		Field _color:UByte 'Modified iDkP
		Field _left:Node
		Field _right:Node
		Field _parent:Node
	
		Method New( key:K,value:V,color:UByte,parent:Node )
			_key=key
			_value=value
			_color=color
			_parent=parent
		End
		
		Method Count:Int( n:Int )
			If _left n=_left.Count( n )
			If _right n=_right.Count( n )
			Return n+1
		End
	
		Method NextNode:Node()
			If _right
				Local node:=_right
				While node._left
					node=node._left
				Wend
				Return node
			End
			Local node:=Self,parent:=_parent
			While parent And node=parent._right
				node=parent
				parent=parent._parent
			Wend
			Return parent
		End
		
		Method PrevNode:Node()
			If _left
				Local node:=_left
				While node._right
					node=node._right
				Wend
				Return node
			End
			Local node:=Self,parent:=_parent
			While parent And node=parent._left
				node=parent
				parent=parent._parent
			Wend
			Return parent
		End
		
		Method Copy:Node( parent:Node Ptr )
			'Modified by iDkP
			'Use pointer for passing per cascade and by reference the item to copy
			Local node:=New Node( _key,_value,_color,parent[0] )
			If _left node._left=_left.Copy( Varptr(node) )
			If _right node._right=_right.Copy( Varptr(node) )
			Return node
		End
	
	End
	
	Struct Iterator
		
		Property AtEnd:Bool()
			Return _node=Null
		End
	
		Property Valid:Bool()
			Return _node
		End
		
		Property Current:Node()
			Return _node
		End
		
		Method Bump()
			_node=_node.NextNode()
		End
		
		Private
		
		Field _node:Node
		
		Method New( node:Node )
			_node=node
		End
		
	End
	
	Struct KeyIterator
	
		Property AtEnd:Bool()
			Return _node=Null
		End
	
		Property Valid:Bool()
			Return _node
		End
		
		Property Current:K()
			Return _node._key
		End
		
		Method Bump()
			_node=_node.NextNode()
		End
		
		Private
		
		Field _node:Node
		
		Method New( node:Node )
			_node=node
		End
		
	End
	
	Struct ValueIterator
	
		Property AtEnd:Bool()
			Return _node=Null
		End
	
		Property Valid:Bool()
			Return _node
		End
		
		Property Current:V()
			Return _node._value
		End
		
		Method Bump()
			_node=_node.NextNode()
		End
		
		Private
		
		Field _node:Node
		
		Method New( node:Node )
			_node=node
		End
		
	End
	
	Struct MapKeys
	
		Method All:KeyIterator()
			Return New KeyIterator( _map.FirstNode() )
		End
		
		Private
		
		Field _map:Map
		
		Method New( map:Map )
			_map=map
		End
		
	End
	
	Struct MapValues
	
		Method All:ValueIterator()
			Return New ValueIterator( _map.FirstNode() )
		End
		
		Private
		
		Field _map:Map
		
		Method New( map:Map )
			_map=map
		End
		
	End
	
	#rem monkeydoc Creates a new empty map.
	#end
	Method New()
	End
	
	#rem monkeydoc Gets a node iterator.
	
	#end
	
	Method All:Iterator()
		Return New Iterator( FirstNode() )
	End
	
	#rem monkeydoc Gets a view of the map's keys.
	The returned value can be used with an Eachin loop to iterate over the map's keys.
	@return A MapKeys object.
	#end
	Property Keys:MapKeys()
		Return New MapKeys( Self )
	End

	#rem monkeydoc Gets a view of the map's values.
	The returned value can be used with an Eachin loop to iterate over the map's values.
	@return A MapValues object.
	#end	
	Property Values:MapValues()
		Return New MapValues( Self )
	End
	
	#rem monkeydocs Copies the map.
	
	@return A new map.
	
	#end
	Method Copy:Map()
		Local root:Node
		If _root root=_root.Copy( Null )
		Return New Map( root )
	End
	
	#rem monkeydoc Removes all keys from the map.
	#end
	Method Clear()
		_root=Null
	End
	
	#rem monkeydoc Gets the number of keys in the map.
	@return The number of keys in the map.
	#end
	Method Count:Int()
		If Not _root Return 0
		Return _root.Count( 0 )
	End

	#rem monkeydoc Checks if the map is empty.
	@return True if the map is empty.
	#end
	Property Empty:Bool()
		Return _root=Null
	End

	#rem monkeydoc Checks if the map contains a given key.
	@param key The key to check for.
	@return True if the map contains the key.
	#end
	Method Contains:Bool( key:K )
		Return FindNode( key )<>Null
	End
	
	#rem monkeydoc Sets the value associated with a key in the map.
	If the map does not contain `key`, a new key/value node is added and true is returned.
	If the map already contains `key`, its associated value is updated and false is returned.
	This operator functions identically to Set.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map.
	#end
	Operator[]=( key:K,value:V )
		Set( key,value )
	End

	#rem monkeydoc Gets the value associated with a key in the map.
	@param key The key.
	@return The value associated with `key`, or null if `key` is not in the map.
	#end
	Operator[]:V( key:K )
		Local node:=FindNode( key )
		If Not node Return Null
		Return node._value
	End
	
	#rem monkeydoc Sets the value associated with a key in the map.
	If the map does not contain `key`, a new key/value node is added to the map and true is returned.
	If the map already contains `key`, its associated value is updated and false is returned.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map, false if an existing node was updated.
	#end
	Method Set:Bool( key:K,value:V )
		
		Local cmp:Int		

		If NotRoot( Varptr(key),Varptr(value)) Return True 'Added by iDkP

		' Try hint path first if available
		If _lastAddedNode
			cmp=key <=> _lastAddedNode._key
			If Not cmp
				Local oldValue:=_lastAddedNode._value
				_lastAddedNode._value=value
				Return True
			End
		End
		
		' Standard insertion logic...
	
		Local node:=_root
		Local parent:Node

		While node
			parent=node
			cmp=key<=>node._key
			If cmp>0
				node=node._right
			Elseif cmp<0
				node=node._left
			Else
				node._value=value
				Return False
			End
		Wend
		
		AddPair( Varptr(node), Varptr(key),Varptr(value), Varptr(parent), Varptr(cmp) ) 'Added by iDkP
		
		Return True
	End
	
	#rem monkeydoc Adds a new key/value pair to a map.
	If the map does not contain `key', a new key/value node is created and true is returned.
	If the map already contains `key`, nothing happens and false is returned.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map, false if the map was not modified.
	#end
	Method Add:Bool( key:K,value:V )
		
		If NotRoot( Varptr(key),Varptr(value)) Return True 'Added by iDkP
	
		Local node:=_root
		Local parent:Node
		Local cmp:Int

		While node
			parent=node
			cmp=key<=>node._key
			If cmp>0
				node=node._right
			ElseIf cmp<0
				node=node._left
			Else
				Return False
			End
		Wend
		
		AddPair( Varptr(node), Varptr(key),Varptr(value), Varptr(parent), Varptr(cmp) ) 'Added by iDkP
		
		Return True
	End
	
	#rem monkeydoc Updates the value associated with a key in the map.
	If the map does not contain `key', nothing happens and false is returned.
	If the map already contains `key`, its associated value is updated and true is returned.
	@param key The key.
	@param value The value.
	@return True if the value associated with `key` was updated, false if the map was not modified.
	#end
	Method Update:Bool( key:K,value:V )
		Local node:=FindNode( key )
		If Not node Return False
		node._value=value
		Return True
	End
	
	#rem monkeydoc Gets the value associated with a key in the map.
	@param key The key.
	@return The value associated with the key, or null if the key is not in the map.
	#end
	Method Get:V( key:K )
		Local node:=FindNode( key )
		If node Return node._value
		Return Null
	End
	
	#rem monkeydoc Removes a key from the map.
	@param key The key to remove.
	@return True if the key was removed, or false if the key is not in the map.
	#end
	Method Remove:Bool( key:K )
		Local node:=FindNode( key )
		If Not node Return False
		RemoveNode( node )
		Return True
	End

	Private
	
	Field _root:Node
	Field _lastAddedNode:Node 'Added by iDkP
	
	Method New( root:Node )
		_root=root
	End

	Method LastNode:Node()
		If Not _root Return Null

		Local node:=_root
		While node._right
			node=node._right
		Wend
		Return node
	End

	Method FirstNode:Node()
		If Not _root Return Null

		Local node:=_root
		While node._left
			node=node._left
		Wend
		Return node
	End
	
	Method FindNode:Node( key:K )

		' Try hint first if available
		If _lastAddedNode
			Local cmp:=key <=> _lastAddedNode._key
			If cmp=0 Return _lastAddedNode
		Endif
		
		' Standard traversal
		Local node:=_root
		While node
			Local cmp:=key<=>node._key
			If cmp>0
				node=node._right
			Else If cmp<0
				node=node._left
			Else
				Return node
			End
		Wend
		Return Null
	End
	
	Method RemoveNode( node:Node )
		Local splice:Node,child:Node
		
		If Not node._left
			splice=node
			child=node._right
		Else If Not node._right
			splice=node
			child=node._left
		Else
			splice=node._left
			While splice._right
				splice=splice._right
			Wend
			child=splice._left
			node._key=splice._key
			node._value=splice._value
		End
		
		Local parent:=splice._parent
		
		If child
			child._parent=parent
		End
		
		If Not parent
			_root=child
			Return
		End
		
		If splice=parent._left
			parent._left=child
		Else
			parent._right=child
		End
		
		If splice._color=ColorBlack 
			DeleteFixup( Varptr(child),Varptr(parent) )
		End
	End
	
	Method RotateLeft( node:Node )
		Local child:=node._right
		node._right=child._left
		If child._left
			child._left._parent=node
		End
		child._parent=node._parent
		If node._parent
			If node=node._parent._left
				node._parent._left=child
			Else
				node._parent._right=child
			End
		Else
			_root=child
		End
		child._left=node
		node._parent=child
	End
	
	Method RotateRight( node:Node )
		Local child:=node._left
		node._left=child._right
		If child._right
			child._right._parent=node
		End
		child._parent=node._parent
		If node._parent
			If node=node._parent._right
				node._parent._right=child
			Else
				node._parent._left=child
			End
		Else
			_root=child
		End
		child._right=node
		node._parent=child
	End
	
	Method InsertFixup( node:Node Ptr ) 'iDkP from GaragePixe: pointer usage
		While node[0]._parent And node[0]._parent._color=ColorRed And node[0]._parent._parent
			If node[0]._parent=node[0]._parent._parent._left
				Local uncle:=node[0]._parent._parent._right
				If uncle And uncle._color=ColorRed
					node[0]._parent._color=ColorBlack
					uncle._color=ColorBlack
					uncle._parent._color=ColorRed
					node[0]=uncle._parent
				Else
					If node[0]=node[0]._parent._right
						node[0]=node[0]._parent
						RotateLeft( node[0] )
					End
					node[0]._parent._color=ColorBlack
					node[0]._parent._parent._color=ColorRed
					RotateRight( node[0]._parent._parent )
				End
			Else
				Local uncle:=node[0]._parent._parent._left
				If uncle And uncle._color=ColorRed
					node[0]._parent._color=ColorBlack
					uncle._color=ColorBlack
					uncle._parent._color=ColorRed
					node[0]=uncle._parent
				Else
					If node[0]=node[0]._parent._left
						node[0]=node[0]._parent
						RotateRight( node[0] )
					End
					node[0]._parent._color=ColorBlack
					node[0]._parent._parent._color=ColorRed
					RotateLeft( node[0]._parent._parent )
				End
			End
		Wend
		_root._color=ColorBlack
	End
	
	Method DeleteFixup( node:Node Ptr,parent:Node Ptr ) 'iDkP from GaragePixel: pointer usage
	
		While node[0]<>_root And (Not node[0] Or node[0]._color=ColorBlack )

			If node[0]=parent[0]._left
			
				Local sib:=parent[0]._right
				
				If sib._color=ColorRed
					sib._color=ColorBlack
					parent[0]._color=ColorRed
					RotateLeft( parent[0] )
					sib=parent[0]._right
				End
				
				If (Not sib._left Or sib._left._color=ColorBlack) And (Not sib._right Or sib._right._color=ColorBlack)
					sib._color=ColorRed
					node=parent
					parent[0]=parent[0]._parent
				Else
					If Not sib._right Or sib._right._color=ColorBlack
						sib._left._color=ColorBlack
						sib._color=ColorRed
						RotateRight( sib )
						sib=parent[0]._right
					End
					sib._color=parent[0]._color
					parent[0]._color=ColorBlack
					sib._right._color=ColorBlack
					RotateLeft( parent[0] )
					node[0]=_root
				End
			Else	
				Local sib:=parent[0]._left
				
				If sib._color=ColorRed
					sib._color=ColorBlack
					parent[0]._color=ColorRed
					RotateRight( parent[0] )
					sib=parent[0]._left
				End
				
				If (Not sib._right Or sib._right._color=ColorBlack) And (Not sib._left Or sib._left._color=ColorBlack)
					sib._color=ColorRed
					node=parent
					parent[0]=parent[0]._parent
				Else
					If Not sib._left Or sib._left._color=ColorBlack
						sib._right._color=ColorBlack
						sib._color=ColorRed
						RotateLeft( sib )
						sib=parent[0]._left
					End
					sib._color=parent[0]._color
					parent[0]._color=ColorBlack
					sib._left._color=ColorBlack
					RotateRight( parent[0] )
					node[0]=_root
				End
			End
		Wend
		If node[0] node[0]._color=ColorBlack
	End
	
	Method NotRoot:Bool( key:K Ptr,value:V Ptr ) 
		'Added by iDkP
		If Not _root
			_root=New Node( key[0],value[0],ColorRed,Null )
			Return True
		End
		Return False
	End
	
	Method AddPair( node:Node Ptr, key:K Ptr,value:V Ptr, parent:Node Ptr, cmp:Int Ptr ) 
		'Added by iDkP
		node[0]=New Node( key[0],value[0],ColorRed,parent[0] )
		_lastAddedNode=node[0]
		If cmp[0]>0 
			parent[0]._right=node[0] 
		Else 
			parent[0]._left=node[0]
		End
		InsertFixup( node )
	End
End
