Class Map2<K,V>
	
	'iDkP: The upgrade by iDkP from GaragePixel
	'	Metric			Without Hinting		With Hinting		Improvement
	'	Insertion Rate	~1,042,000 ops/s	~1,095,350 ops/s	+5.1%
	'	Retrieval Rate	~1,015,000 ops/s	~1,263,384 ops/s	+24.5%
	'	Accuracy		100%				99%					-1%	

	'	Metric			Without Hinting		With Hinting		Improvement
	'	Insertion Rate	~1,042,000 ops/s	~1,185,866 ops/s	+13.8%
	'	Retrieval Rate	~1,015,000 ops/s	~1,253,317 ops/s	+23.5%
	'	Accuracy		100%				99%					-1%

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
		
		Const ColorRed:Byte=0 'Added by iDkP (changed the slow 32 bits value with 8 bit value)
		Const ColorBlack:Byte=1 'Added by iDkP (changed the slow 32 bits value with 8 bit value)
	
'		Enum Color
'			Red
'			Black
'		End
	
		Field _key:K
		Field _value:V
		'Field _color:Color
		Field _color:Byte 'Added by iDkP (changed the slow 32 bits value with 8 bit value)
		Field _left:Node
		Field _right:Node
		Field _parent:Node
	
		Method New( key:K,value:V,color:Byte,parent:Node )
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
		
		Method Copy:Node( parent:Node )
			Local node:=New Node( _key,_value,_color,parent )
			If _left node._left=_left.Copy( node )
			If _right node._right=_right.Copy( node )
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
		
		Field _map:Map2
		
		Method New( map:Map2 )
			_map=map
		End
		
	End
	
	Struct MapValues
	
		Method All:ValueIterator()
			Return New ValueIterator( _map.FirstNode() )
		End
		
		Private
		
		Field _map:Map2
		
		Method New( map:Map2 )
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
	Method Copy:Map2()
		Local root:Node
		If _root root=_root.Copy( Null )
		Return New Map2( root )
	End
	
	#rem monkeydoc Removes all keys from the map.
	#end
	Method Clear()
		_root=Null
		_lastInsertedNode = Null 'added by iKdP
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
		' If tree is empty, create root - Refactorized by iDkP
		If Not _root
			_root=New Node( key,value,Node.ColorRed,Null )
			_lastInsertedNode = _root
			Return True
		Endif
		
		'Refactorized by iDkP
		Local node:=_root
		Local parent:Node
		Local cmp:Int
		
		' Try to use hint for faster insertion - Added by iDkP
		If _lastInsertedNode
			cmp = key <=> _lastInsertedNode._key
			If cmp = 0
				Local oldValue:=_lastInsertedNode._value
				_lastInsertedNode._value = value
				Return True
			End
			
			' Use hint as starting point if useful
			If cmp < 0 And _lastInsertedNode._left
				node = _lastInsertedNode._left
			Elseif cmp > 0 And _lastInsertedNode._right
				node = _lastInsertedNode._right
			Else
				node = _root
			End
		End
		
		' Find insertion point
		Repeat
			parent = node
			cmp = key <=> node._key
			If cmp < 0
				node = node._left
			Elseif cmp > 0
				node = node._right
			Else
				Local oldValue:=node._value 'Added by iDkP
				node._value = value
				Return False
			Endif
		Until Not node
		
		' Create new node
		node=New Node( key,value,Node.ColorRed,parent )
		
		' Insert node
		If cmp>0 parent._right=node Else parent._left=node
		
		' Fix red/black tree
		InsertFixup(node)
		
		' Update hint
		_lastInsertedNode = node
		
		Return value
	End
	
	#rem monkeydoc Adds a new key/value pair to a map.
	If the map does not contain `key', a new key/value node is created and true is returned.
	If the map already contains `key`, nothing happens and false is returned.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map, false if the map was not modified.
	#end
	Method Add:Bool( key:K,value:V )
		If Not _root
			_root=New Node( key,value,Node.ColorRed,Null )
			Return True
		End
	
		Local node:=_root,parent:Node,cmp:Int

		While node
			parent=node
			cmp=key<=>node._key
			If cmp>0
				node=node._right
			Else If cmp<0
				node=node._left
			Else
				Return False
			End
		Wend
		
		node=New Node( key,value,Node.ColorRed,parent )
		
		If cmp>0 parent._right=node Else parent._left=node
		
		InsertFixup( node )
		
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
	Field _lastInsertedNode:Node 'Added by iDkP
	Private
	
	Field _root:Node
	
	
	Method New( root:Node )
		_root=root
	End
	
	Method FirstNode:Node()
		If Not _root Return Null

		Local node:=_root
		While node._left
			node=node._left
		Wend
		Return node
	End
	
	Method LastNode:Node()
		If Not _root Return Null

		Local node:=_root
		While node._right
			node=node._right
		Wend
		Return node
	End
	
	Method FindNode:Node( key:K )
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
		
		If splice._color=Node.ColorBlack 
			DeleteFixup( child,parent )
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
	
	Method InsertFixup( node:Node )
		While node._parent And node._parent._color=Node.ColorRed And node._parent._parent
			If node._parent=node._parent._parent._left
				Local uncle:=node._parent._parent._right
				If uncle And uncle._color=Node.ColorRed
					node._parent._color=Node.ColorBlack
					uncle._color=Node.ColorBlack
					uncle._parent._color=Node.ColorRed
					node=uncle._parent
				Else
					If node=node._parent._right
						node=node._parent
						RotateLeft( node )
					End
					node._parent._color=Node.ColorBlack
					node._parent._parent._color=Node.ColorRed
					RotateRight( node._parent._parent )
				End
			Else
				Local uncle:=node._parent._parent._left
				If uncle And uncle._color=Node.ColorRed
					node._parent._color=Node.ColorBlack
					uncle._color=Node.ColorBlack
					uncle._parent._color=Node.ColorRed
					node=uncle._parent
				Else
					If node=node._parent._left
						node=node._parent
						RotateRight( node )
					End
					node._parent._color=Node.ColorBlack
					node._parent._parent._color=Node.ColorRed
					RotateLeft( node._parent._parent )
				End
			End
		Wend
		_root._color=Node.ColorBlack
	End
	
	Method DeleteFixup( node:Node,parent:Node )
	
		While node<>_root And (Not node Or node._color=Node.ColorBlack )

			If node=parent._left
			
				Local sib:=parent._right
				
				If sib._color=Node.ColorRed
					sib._color=Node.ColorBlack
					parent._color=Node.ColorRed
					RotateLeft( parent )
					sib=parent._right
				End
				
				If (Not sib._left Or sib._left._color=Node.ColorBlack) And (Not sib._right Or sib._right._color=Node.ColorBlack)
					sib._color=Node.ColorRed
					node=parent
					parent=parent._parent
				Else
					If Not sib._right Or sib._right._color=Node.ColorBlack
						sib._left._color=Node.ColorBlack
						sib._color=Node.ColorRed
						RotateRight( sib )
						sib=parent._right
					End
					sib._color=parent._color
					parent._color=Node.ColorBlack
					sib._right._color=Node.ColorBlack
					RotateLeft( parent )
					node=_root
				End
			Else	
				Local sib:=parent._left
				
				If sib._color=Node.ColorRed
					sib._color=Node.ColorBlack
					parent._color=Node.ColorRed
					RotateRight( parent )
					sib=parent._left
				End
				
				If (Not sib._right Or sib._right._color=Node.ColorBlack) And (Not sib._left Or sib._left._color=Node.ColorBlack)
					sib._color=Node.ColorRed
					node=parent
					parent=parent._parent
				Else
					If Not sib._left Or sib._left._color=Node.ColorBlack
						sib._right._color=Node.ColorBlack
						sib._color=Node.ColorRed
						RotateLeft( sib )
						sib=parent._left
					End
					sib._color=parent._color
					parent._color=Node.ColorBlack
					sib._left._color=Node.ColorBlack
					RotateRight( parent )
					node=_root
				End
			End
		Wend
		If node node._color=Node.ColorBlack
	End
End
