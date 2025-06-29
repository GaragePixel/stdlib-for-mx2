
Namespace stdlib.math.identities

' Implementation: iDkP from GaragePixel
' 2025-04-03 (Aida 4)

#rem monkeydoc Return if x is from the identities negative/positive infinity or Nan
@author iDkP from GaragePixel
@since 2025-04-03
#end 
Function isNormal<T>:Bool(x:T)
	' Inspirated from the std math of Zig :D https://ziglang.org/documentation/master/std/#std.math
    Return x=PositiveInfinity() Or x=NegativeInfinity() Or NaN() ? True Else False
End

#rem monkeydoc Special values created through division operations
@author iDkP from GaragePixel
@since 2025-04-03
#end 
Function PositiveInfinity:Float()
	Local a:Float = 1.0
	Local b:Float = 0.0
	Return a / b  ' Creates positive infinity through division by zero
End

#rem monkeydoc Negative Inifinity identity
@author iDkP from GaragePixel
@since 2025-04-03
#end 
Function NegativeInfinity:Float()
	Local a:Float = -1.0
	Local b:Float = 0.0
	Return a / b  ' Creates negative infinity through division by zero
End

#rem monkeydoc Produce a "Not a Number" identity
@author iDkP from GaragePixel
@since 2025-04-03
#end 
Function NaN:Float()
	Local a:Float = 0.0
	Local b:Float = 0.0
	Return a / b  ' Creates NaN through zero divided by zero
End
