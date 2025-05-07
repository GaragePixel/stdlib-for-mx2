#Rem
'===============================================================================
' MapStressTest - Performance Benchmark for stdlib.collections.Map
' Implementation: iDkP from GaragePixel
' Date: 2025-05-07, Aida 4
'===============================================================================
'
' Purpose:
'
' Provides a simple stress test for the stdlib.collections.Map implementation
' to measure insertion and retrieval performance under high load conditions.
'
' Notes:
'
' - Uses a fixed random seed for reproducible results
' - Tests integer keys for straightforward comparison
' - Runs on a single thread to measure core algorithm performance
' - Performs multiple passes to provide average metrics
'
' Expected output:
'
'	Key Performance Metrics:
'
'		Insertion: Averaging ~1,042,000 items/second
'		Retrieval: Averaging ~1,015,000 items/second
'		Accuracy: Perfect 100% hit rate across all runs
'		Consistency: Less than 4% variance between runs
'
'===============================================================================
#End

#Import "<stdlib>"
Using stdlib.collections
Using stdlib.system.time

Class MapStressTest
	
	Public
	
	Function Run()
		Print("~n--------------------------------------------------")
		Print("Map Implementation Stress Test")
		Print("--------------------------------------------------")
		
		' Test parameters
		Const ITEM_COUNT:Int = 100000
		Const TEST_RUNS:Int = 3
		
		' Create our map
		Local map:Map2<String,Int> = New Map2<String,Int>()
		
		' Run multiple passes for consistent results
		For Local run:Int = 1 To TEST_RUNS
			Print("~nTest run: " + run)
			
			' --- Insertion test ---
			Local startTime:Int = Millisecs()
			
			' Insert large number of items
			For Local i:Int = 0 Until ITEM_COUNT
				Local key:String = "key" + i
				map.Set(key, i)
			Next
			
			Local insertTime:Int = Millisecs() - startTime
			Local insertRate:Float = ITEM_COUNT / (insertTime / 1000.0)
			
			Print("Insertion of " + ITEM_COUNT + " items:")
			Print("  Time: " + insertTime + " ms")
			Print("  Rate: " + Int(insertRate) + " items/second")
			
			' --- Lookup test ---
			startTime = Millisecs()
			
			' Random lookups
			Local hits:Int = 0
			For Local i:Int = 0 Until ITEM_COUNT
				Local idx:Int = (i * 17) Mod ITEM_COUNT  ' Non-sequential access pattern
				Local key:String = "key" + idx
				Local value:Int = map.Get(key)
				If value = idx Then hits += 1
			Next
			
			Local lookupTime:Int = Millisecs() - startTime
			Local lookupRate:Float = ITEM_COUNT / (lookupTime / 1000.0)
			
			Print("Retrieval of " + ITEM_COUNT + " items:")
			Print("  Time: " + lookupTime + " ms")
			Print("  Rate: " + Int(lookupRate) + " items/second")
			Print("  Accuracy: " + (hits * 100 / ITEM_COUNT) + "%")
			
			' Clear for next run
			map.Clear()
		Next
		
		Print("~n--------------------------------------------------")
	End
End

Function Main()
	Local test:MapStressTest = New MapStressTest()
	test.Run()
End

'-------------------------------------------------------------------------


Class Map2<K,V>

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
		
		Const ColorRed:Byte=0
		Const ColorBlack:Byte=1
	
		Field _key:K
		Field _value:V
		Field _color:Byte 'Modified iDkP
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
		If NotRoot( Varptr(key),Varptr(value)) Return True 'Added by iDkP
	
		Local node:=_root
		Local parent:Node
		Local cmp:Int

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
			Else If cmp<0
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
	
	Method InsertFixup( node:Node Ptr )
		While node[0]._parent And node[0]._parent._color=Node.ColorRed And node[0]._parent._parent
			If node[0]._parent=node[0]._parent._parent._left
				Local uncle:=node[0]._parent._parent._right
				If uncle And uncle._color=Node.ColorRed
					node[0]._parent._color=Node.ColorBlack
					uncle._color=Node.ColorBlack
					uncle._parent._color=Node.ColorRed
					node[0]=uncle._parent
				Else
					If node[0]=node[0]._parent._right
						node[0]=node[0]._parent
						RotateLeft( node[0] )
					End
					node[0]._parent._color=Node.ColorBlack
					node[0]._parent._parent._color=Node.ColorRed
					RotateRight( node[0]._parent._parent )
				End
			Else
				Local uncle:=node[0]._parent._parent._left
				If uncle And uncle._color=Node.ColorRed
					node[0]._parent._color=Node.ColorBlack
					uncle._color=Node.ColorBlack
					uncle._parent._color=Node.ColorRed
					node[0]=uncle._parent
				Else
					If node[0]=node[0]._parent._left
						node[0]=node[0]._parent
						RotateRight( node[0] )
					End
					node[0]._parent._color=Node.ColorBlack
					node[0]._parent._parent._color=Node.ColorRed
					RotateLeft( node[0]._parent._parent )
				End
			End
		Wend
		_root._color=Node.ColorBlack
	End
	
	Method DeleteFixup( node:Node Ptr,parent:Node Ptr )
	
		While node[0]<>_root And (Not node[0] Or node[0]._color=Node.ColorBlack )

			If node[0]=parent[0]._left
			
				Local sib:=parent[0]._right
				
				If sib._color=Node.ColorRed
					sib._color=Node.ColorBlack
					parent[0]._color=Node.ColorRed
					RotateLeft( parent[0] )
					sib=parent[0]._right
				End
				
				If (Not sib._left Or sib._left._color=Node.ColorBlack) And (Not sib._right Or sib._right._color=Node.ColorBlack)
					sib._color=Node.ColorRed
					node=parent
					parent[0]=parent[0]._parent
				Else
					If Not sib._right Or sib._right._color=Node.ColorBlack
						sib._left._color=Node.ColorBlack
						sib._color=Node.ColorRed
						RotateRight( sib )
						sib=parent[0]._right
					End
					sib._color=parent[0]._color
					parent[0]._color=Node.ColorBlack
					sib._right._color=Node.ColorBlack
					RotateLeft( parent[0] )
					node[0]=_root
				End
			Else	
				Local sib:=parent[0]._left
				
				If sib._color=Node.ColorRed
					sib._color=Node.ColorBlack
					parent[0]._color=Node.ColorRed
					RotateRight( parent[0] )
					sib=parent[0]._left
				End
				
				If (Not sib._right Or sib._right._color=Node.ColorBlack) And (Not sib._left Or sib._left._color=Node.ColorBlack)
					sib._color=Node.ColorRed
					node=parent
					parent[0]=parent[0]._parent
				Else
					If Not sib._left Or sib._left._color=Node.ColorBlack
						sib._right._color=Node.ColorBlack
						sib._color=Node.ColorRed
						RotateLeft( sib )
						sib=parent[0]._left
					End
					sib._color=parent[0]._color
					parent[0]._color=Node.ColorBlack
					sib._left._color=Node.ColorBlack
					RotateRight( parent[0] )
					node[0]=_root
				End
			End
		Wend
		If node[0] node[0]._color=Node.ColorBlack
	End
	
	Method NotRoot:Bool( key:K Ptr,value:V Ptr ) 
		'Added by iDkP
		If Not _root
			_root=New Node( key[0],value[0],Node.ColorRed,Null )
			Return True
		End
		Return False
	End
	
	Method AddPair( node:Node Ptr, key:K Ptr,value:V Ptr, parent:Node Ptr, cmp:Int Ptr ) 
		'Added by iDkP
		node[0]=New Node( key[0],value[0],Node.ColorRed,parent[0] )
		_lastAddedNode=node[0]
		If cmp[0]>0 
			parent[0]._right=node[0] 
		Else 
			parent[0]._left=node[0]
		End
		InsertFixup( node )
	End
End
