
Namespace stdlib.syntax

#rem monkeydoc @pro @sugar SearchIn collections functions.
@author iDkP from GagagePixel
@since 2025-07-18
#end 
Function SearchIn<K,V>:Int( map:Map<K,V>,key:K,values:Stack<V> )
	Return map.Search( key, values.Data )
End

Function SearchIn<K,V>:Int( map:Map<K,V>,key:K,values:V[] )
	Return map.Search( key, values )
End

Function SearchIn<K,V>:Int( map:Map<K,V>,key:K,values:List<V> )
	Return map.Search( key, values )
End
