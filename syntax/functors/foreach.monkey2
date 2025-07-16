
Namespace stdlib.syntax

#rem MiniLibrary: Arrays
Since 025-07-16 (Aida 4)
Author: iDkP from GaragePixel
#end

#rem wonkeydoc @pro The ForEach function - A generic iteration utility with callback execution.
@author iDkP from GaragePixel
@since 2025-07-16
A ForEach provides a functional approach to array iteration with custom callback processing.
The ForEach function executes a provided callback for each element within a specified range,
enabling functional programming patterns while maintaining Wonkey's type safety through generics.
#end
Function ForEach<T,B>:T[]( 	values:T[], 
							callback:Void(index:B,value:T), 
							from:B=0, atEnd:B=Null )  Where 	B Implements IShort Or 
																B Implements ICompact	
	If atEnd=Null atEnd=values.Length 'Auto
		
	For Local index:B=from Until atEnd
		callback(index,values[index])
	End
	
	Return values
End
