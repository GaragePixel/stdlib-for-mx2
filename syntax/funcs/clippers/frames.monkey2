
Namespace stdlib.syntax.frames

'iDkP from GaragePixel
'2025-07-09
Function Frame<T>( from:T Ptr, atEnd:T Ptr, min:T Ptr, max:T Ptr ) Where T Implements INumeric Or T Implements IReal
	from[0]=Null ? min[0] Else from[0]
	atEnd[0]=Null ? max[0] Else atEnd[0]
End
