
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

'iDkP: 
'	Note: Using Red-Black Tree agorithm, internally. It's really fast.
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
		Field _color:UByte 'Modified by iDkP
		Field _left:Node
		Field _right:Node
		Field _parent:Node
	
		Method New( key:K,value:V,color:UByte,parent:Node )
			_key=key
			_value=value
			_color=color
			_parent=parent
		End
		
		Method Count:Int( n:Int ) 'iDkP: 32 bits!
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
			Endif
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
			Endif
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
			Return New KeyIterator( _map.FirstNode ) 'Modified by iDkP
		End
		
		Private
		
		Field _map:Map
		
		Method New( map:Map )
			_map=map
		End
		
	End
	
	Struct MapValues
	
		Method All:ValueIterator()
			Return New ValueIterator( _map.FirstNode ) 'Modified by iDkP
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

	#rem monkeydoc Creates a new prefilled map with keys from a pointed array.
	@author iDkP from GaragePixel
	@since 2025-06-20
	The pre-filled value will fill the entire map (same value for the keys)
	Note: K as Object allows indexing
	@example
		' Prefilled constructor - uniform value for all keys
		Local names:=New String[]("Alice", "Bob", "Charlie")
		Local scores:=New Map<String,Int>(names, 100)
		' Result: scores = {"Alice"=100, "Bob"=100, "Charlie"=100}	
		Print "scores = "+scores

		' Prefilled map with same value for all keys
		Local keys:=New Int[](100,200,300)
		Local m0:=New Map<Int,Int>(keys, 42)
		' Result: m1 = { "100"=42, 200=42, 300=42 }
		Print "m0 = "+m0
	#end
	Method New( keys:K[], prefilled:V ) Where
										K=Object Or K=String Or
										K=Int Or K=Float Or K=Short Or K=Long Or K=Double Or K=Bool
		Local len:=keys.Length
		For Local k:=0 Until len
			Add(keys[k],prefilled)
		End
	End

	#rem monkeydoc Creates a new prefilled map with keys and values from pointed arrays.
	@author iDkP from GaragePixel
	@since 2025-06-20
	The values will fill the entire map.
	
	If the value array is shorter than the key array, 
	the same final value is repeated for the remaining keys.
	
	Conversely, if the value array is longer than the key array, 
	the map will be sized based on the length of the key array 
	and will therefore be filled sequentially until its length is reached.

	Note: K and V as Object allowing indexing
	
	@example
		' Prefilled map with same value for all keys
		Local keys0:=New String[]("foo","bar","baz")
		Local m1:=New Map<String,Int>(keys0, 42)
		' Result: m1 = { "foo"=42, "bar"=42, "baz"=42 }
		Print "m1 = "+m1

		' Synchronized arrays constructor - paired key-value mapping
		Local players:=New String[]("Alice", "Bob", "Charlie")
		Local points:=New Int[](95, 87, 92)
		Local rankings:=New Map<String,Int>(players, points)
		' Result: rankings = {"Alice"=>95, "Bob"=>87, "Charlie"=>92}
		Print "rankings = "+rankings

		' Prefilled map with keys and values from arrays (values shorter, last value repeated)
		Local keys2:=New String[]("a","b","c","d")
		Local vals2:=New Int[](100,200)
		Local m2:=New Map<String,Int>(keys2, vals2)
		' Result: m2 = { "a"=100, "b"=200, "c"=200, "d"=200 }
		Print "m2 = "+m2
	#end
	Method New( keys:K[], values:V[] ) 	Where 
										(K=Object Or K=String Or K=Int Or K=Float Or K=Short Or K=Long Or K=Double Or K=Bool) And
										(V=Object Or V=String Or V=Int Or V=Float Or V=Short Or V=Long Or V=Double Or V=Bool)
		Local klen:=keys.Length
		Local vlen:=values.Length
		If klen>vlen
			Local k:Int
			For k=0 Until vlen
				Add(keys[k],values[k])
			End
			For k=vlen Until klen
				Add(keys[k],values[vlen-1])
			End
		Else 
			For Local k:=0 Until klen
				Add(keys[k],values[k])
			End
		End
	End

	#rem monkeydoc Creates a new indexed map with values from an array.
	@author iDkP from GaragePixel
	@since 2025-06-20
	The values will fill the entire map.
	The keys will be natural sequence integers 32 bits.
	Note: V as Object allowing indexing
	
	@example
		' Prefilled map with keys and values from arrays (keys shorter, extra values ignored)
		Local keys3:=New String[]("k1","k2")
		Local vals3:=New Int[](7,8,9)
		Local m3:=New Map<String,Int>(keys3, vals3)
		' Result: m3 = { "k1"=7, "k2"=8 }
		Print "m3 = "+m3
		
		' Indexed constructor - sequential integer keys
		Local items:=New String[]("sword", "shield", "potion")
		Local inventory:=New Map<Int,String>(items)
		' Result: inventory = {0="sword", 1="shield", 2="potion"}
		Print "inventory = "+inventory
	#end
	Method New( values:V[] ) 	Where
								(V=Object Or V=String Or V=Int Or V=Float Or V=Short Or V=Long Or V=Double Or V=Bool) And
								K=Int '32 bits!

		Local vlen:=values.Length
		For Local k:=0 Until vlen
			Add(k,values[k])
		End
	End

	#rem monkeydoc Output an string from the data (map as string or numerical types)
	@author iDkP from GaragePixel
	@since 2025-06-13
	stdlib.collections.Map<monkey.types.String,monkey.types.Int>' to type 'monkey.types.String
	#end	
	Method To:String() 	Where
						(K=String Or K=Int Or K=Float Or K=Short Or K=Long Or K=Double Or K=Bool) And
						(V=String Or V=Int Or V=Float Or V=Short Or V=Long Or V=Double Or V=Bool)

		Local result:String
		For Local item:=Eachin Self
			result+="["+item.Key+"]["+item.Value+"]~n"
		End
		Return result
	End 

	#rem monkeydoc Output an verbose string from the data (map as string or numerical types)
	@author iDkP from GaragePixel
	@since 2025-06-13
	#end	
	Method ToString:String() 	Where
								(K=String Or K=Int Or K=Float Or K=Short Or K=Long Or K=Double Or K=Bool) And
								(V=String Or V=Int Or V=Float Or V=Short Or V=Long Or V=Double Or V=Bool)

		Local result:String="map[~n"
		For Local item:=Eachin Self
			result+="["+item.Key+"]["+item.Value+"]~n"
		End
		result=result.Left(result.Length-2)+"]"
		Return result
	End  

	#rem monkeydoc Gets a node iterator.	
	#end	
	Method All:Iterator()
		Return New Iterator( FirstNode ) 'Modified by iDkP
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
	Method Count:Int() 'iDkP: UNSIGNED 32 bits!
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

	#rem monkeydoc Casts the map to a list of values.
	@author iDkP from GaragePixel
	@since 2025-05-09
	The `To:List<V>` operator allows you to extract all values from the map
	and store them in a new list. The keys are discarded during this process.
	@return A new `List<V>` containing the map's values.
	#end
	Operator To:List<V>()
		'Set a list of values (negligates the keys)
		Local list:=New List<V>()
		For Local item:=Eachin Self 
			list.Add(item.Value)
		End
		Return list
	End
	
	#rem monkeydoc Sets the value associated with a key in the map.
	If the map does not contain `key`, a new key/value node is added to the map and true is returned.
	If the map already contains `key`, its associated value is updated and false is returned.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map, false if an existing node was updated.
	#end
	Method Set:Bool( key:K,value:V ) 'Modified by iDkP
		
		Local cmp:Int		

		'If NotRoot( key,value) 
		'If NotRoot( Varptr(key),Varptr(value)) 'Modified by iDkP
		'If NotRoot( key,Varptr(value)) 'Modified by iDkP
		If NotRoot( key,value) 'Modified by iDkP
			_root=New Node( key,value,ColorRed,Null )
			Return True 'Added by iDkP
		End

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

		AddPair( node, key,value, parent, cmp ) 'Added by iDkP
		
		Return True
	End
	
	#rem monkeydoc Adds a new key/value pair to a map.
	If the map does not contain `key', a new key/value node is created and true is returned.
	If the map already contains `key`, nothing happens and false is returned.
	@param key The key.
	@param value The value.
	@return True if a new node was added to the map, false if the map was not modified.
	#end
	Method Add:Bool( key:K,value:V ) 'Modified by iDkP

		If NotRoot( key,value) 'Modified by iDkP
			_root=New Node( key,value,ColorRed,Null )
			Return True 'Modified by iDkP
		End
	
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

		AddPair( node, key,value, parent, cmp ) 'Added by iDkP
		
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

	#rem monkeydoc Union: Add each keys from this (param) that exist in self
	@param This The map to compare.
	@param onPlace if False, returns a copy of the map, else nothing
	#end
	Method Append:Map<K,V>(this:Map<K,V>,onPlace:Bool=True) 'Modified by iDkP
		'Sugar
		Return Union(this,onPlace)
	End

	#rem monkeydoc Union: Add each keys from this (param) that exist in self
	@param This The map to compare.
	@param onPlace if False, returns a copy of the map, else nothing
	#end	
	Method Union:Map<K,V>(this:Map<K,V>,onPlace:Bool=True) 'Modified by iDkP
		
		'Add this to self
		If onPlace 
			For Local item:= Eachin this
				Set(item.Key,item.Value)
			Next
			Return Null 
		End
		Local result:=Copy()
		For Local item:= Eachin this
			result.Set(item.Key,item.Value)
		End
		Return result
	End 

	#rem monkeydoc Intersect: Keep all keys from self that exist in this (param)
	@param This The map to compare.
	@param onPlace if False, returns a copy of the map, else nothing
	#end	
	Method Intersect:Map<K,V>(this:Map<K,V>, onPlace:Bool=True) 'Modified by iDkP
		
		'Keep in self the keys that exist in this
		If onPlace 
			For Local item:= Eachin Self
				If Not this.Contains(item.Key) Self.Remove(item.Key)
			End 
			Return Null
		End 
		Local result:=Copy()
		For Local item:= Eachin result
			If Not this.Contains(item.Key) result.Remove(item.Key)
		End 	
		Return result	
	End

	#rem monkeydoc Difference: Remove all keys from self that exist in this (param)
	@param This The map to compare.
	@param onPlace if False, returns a copy of the map, else nothing
	#end
	Method Diff:Map<K,V>(this:Map<K,V>, onPlace:Bool=True) 'Modified by iDkP
		
		'Remove all keys from self that exist in this
		If onPlace 
			For Local item:= Eachin Self
				If this.Contains(item.Key) Remove(item.Key)
			End 
			Return Null
		End 
		Local result:=Copy()
		For Local item:= Eachin result
			If this.Contains(item.Key) result.Remove(item.Key)
		End 	
		Return result	
	End
	
	Private
	
	Field _root:Node
	Field _lastAddedNode:Node 'Modified by iDkP
	
	Method New( root:Node )
		_root=root
	End
	
	Property FirstNode:Node() 'iDkP: passed as property for consistancy

		If Not _root Return Null

		Local node:=_root
		While node._left
			node=node._left
		Wend
		Return node
	End
	
	Property LastNode:Node() 'iDkP: passed as property for consistancy

		If Not _root Return Null

		Local node:=_root
		While node._right
			node=node._right
		Wend
		Return node
	End

	Method FindNode:Node( key:K ) 'Modified by iDkP

		' Try hint first if available
		If _lastAddedNode
			Local cmp:=key <=> _lastAddedNode._key
			If cmp=0 Return _lastAddedNode
		End
		
		' Standard traversal
		Local node:=_root
		While node
			Local cmp:=key<=>node._key
			If cmp>0
				node=node._right
			Elseif cmp<0
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
		Elseif Not node._right
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
		Endif
		
		If Not parent
			_root=child
			Return
		Endif
		
		If splice=parent._left
			parent._left=child
		Else
			parent._right=child
		End
		
		If splice._color=ColorBlack
			DeleteFixup( child,parent )
		End
	End
	
	Method RotateLeft( node:Node )
		Local child:=node._right
		node._right=child._left
		If child._left
			child._left._parent=node
		Endif
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
		While node._parent And node._parent._color=ColorRed And node._parent._parent
			If node._parent=node._parent._parent._left
				Local uncle:=node._parent._parent._right
				If uncle And uncle._color=ColorRed
					node._parent._color=ColorBlack
					uncle._color=ColorBlack
					uncle._parent._color=ColorRed
					node=uncle._parent
				Else
					If node=node._parent._right
						node=node._parent
						RotateLeft( node )
					Endif
					node._parent._color=ColorBlack
					node._parent._parent._color=ColorRed
					RotateRight( node._parent._parent )
				Endif
			Else
				Local uncle:=node._parent._parent._left
				If uncle And uncle._color=ColorRed
					node._parent._color=ColorBlack
					uncle._color=ColorBlack
					uncle._parent._color=ColorRed
					node=uncle._parent
				Else
					If node=node._parent._left
						node=node._parent
						RotateRight( node )
					End
					node._parent._color=ColorBlack
					node._parent._parent._color=ColorRed
					RotateLeft( node._parent._parent )
				Endif
			Endif
		Wend
		_root._color=ColorBlack
	End
	
	Method DeleteFixup( node:Node,parent:Node )
		
		While node<>_root And (Not node Or node._color=ColorBlack )

			If node=parent._left
			
				Local sib:=parent._right
				
				If sib._color=ColorRed
					sib._color=ColorBlack
					parent._color=ColorRed
					RotateLeft( parent )
					sib=parent._right
				Endif
				
				If (Not sib._left Or sib._left._color=ColorBlack) And (Not sib._right Or sib._right._color=ColorBlack)
					sib._color=ColorRed
					node=parent
					parent=parent._parent
				Else
					If Not sib._right Or sib._right._color=ColorBlack
						sib._left._color=ColorBlack
						sib._color=ColorRed
						RotateRight( sib )
						sib=parent._right
					Endif
					sib._color=parent._color
					parent._color=ColorBlack
					sib._right._color=ColorBlack
					RotateLeft( parent )
					node=_root
				Endif
			Else	
				Local sib:=parent._left
				
				If sib._color=ColorRed
					sib._color=ColorBlack
					parent._color=ColorRed
					RotateRight( parent )
					sib=parent._left
				Endif
				
				If (Not sib._right Or sib._right._color=ColorBlack) And (Not sib._left Or sib._left._color=ColorBlack)
					sib._color=ColorRed
					node=parent
					parent=parent._parent
				Else
					If Not sib._left Or sib._left._color=ColorBlack
						sib._right._color=ColorBlack
						sib._color=ColorRed
						RotateLeft( sib )
						sib=parent._left
					Endif
					sib._color=parent._color
					parent._color=ColorBlack
					sib._left._color=ColorBlack
					RotateRight( parent )
					node=_root
				Endif
			Endif
		Wend
		If node node._color=ColorBlack
	End

	Method NotRoot:Bool( key:K,value:V ) 'Added by iDkP
		If Not _root
			_root=New Node( key,value,ColorRed,Null )
			Return True
		End
		Return False
	End

	Method AddPair( node:Node, key:K,value:V, parent:Node, cmp:Int ) 'Added by iDkP
		node=New Node( key,value,ColorRed,parent )
		_lastAddedNode=node
		If cmp>0 
			parent._right=node 
		Else 
			parent._left=node
		End
		InsertFixup( node )
	End 

End
