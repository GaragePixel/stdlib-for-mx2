
Namespace stdlib.syntax.wraps

#rem wraps minilibrary
@author iDkP from GaragePixel
@since 2011-xx-xx new version 2025-02-xx

## Notes on Implementation

- **Generic Functions**:  
	Both `Wrap` and `Wrap2` use Monkey2 generics (`<T>`) for broad type compatibility 
	(any type supporting arithmetic and comparison).
- **Non-zero-based Logic**:  
	Classic modulo is zero-based; these functions extend the logic to custom [min, max] intervals.
- **Recursive Counting**:  
	`Wrap2` recursively applies wrapping, incrementing `count` until `x` falls within bounds. 
	This is clear and elegant, but may not be optimal for extremely large deviations.
- **Private Utility**:  
	`Contains` is a concise utility for interval membership and marked as private for encapsulation.
- **Code Style**:  
	- Tabs only for indentation (Monkey2/Wonkey convention).
	- Clear commentary and examples.
	
## Technical Advantages & Detailed Explanations

- **Interval Flexibility**:  
	Unlike typical `mod` which wraps into `[0, n)`, these functions wrap into any `[min, max]` interval. 
	This is especially useful for graphics, circular buffers, or cyclic domain logic not anchored at zero.
- **Type Agnosticism**:  
	Use of generics allows these wrappers to be reused for any supported number-like type 
	(Int, Float, Double, etc.), reducing code duplication.
- **Counter Feature (`Wrap2`)**:  
	Providing the number of wraps is valuable for logic that cares about overflow/underflow events 
	or needs to adjust for multiple cycles (e.g., phase wrapping in audio, animation frame wrapping).
- **Recursive vs. Iterative**:  
	Recursion in `Wrap2` is convenient and clear for most practical cases, but could be replaced 
	with an iterative approach for performance if large jumps are expected.

@todo:
- **Negative Ranges**:  
	Confirm behavior is mathematically correct for intervals where `min > max` or for negative ranges.
#end

'#Import "../../../lang/lang"

'#Import "<monkey>"
'#Import "../../../types/composites/tuples/tuple2"

'Using monkey.types 'TOINTEGRATE
Using stdlib.types'.tuples.tuple2

Function Wrap<T>:T(x:T,min:T,max:T)
	' Wrap is more smart than Clamp or Mod
	' It works basically like mod, but not 0-based
	' Note:
	' 	New version 2025 (in order to prepare the public version of Aida)
	'	Old version undoned/cleaned
	Return (max-x Mod max-min)+min
End
Function Wrap2<T>:Tuple2<T,T>(x:T,min:T,max:T,count:Double=0)
	
	' Counts the number of time the wrap is done

	' Wrap2 is a counting version of Wrap
	' It returns a Wrap with a counter in order to know 
	' the number time it wraps
	'
	' Example :
	'	
	'   r=Wrap2(30,0,5)
	'
	'   print r -->> Tuple2.Item1 = 6
	'				 Tuple2.Item2 = 5
	
	If x<min 
		x=max-(min-x)
	Elseif x>max
		x=min+(x-max)
	End 
	If Contains(x,min,max)=False Return Wrap2(x,min,max,count+1)
	Return New Tuple2<T,T>(count,x)
End 
Private 
	'dependency
	'TODO: undo
	Function Contains<T>:Bool(x:T,fromN:T,toEndN:T)
		If x >= fromN And x <= toEndN Return True
		Return False
	End	
Public

Function WrapPct<T>:T(x:T)
	' Short version of Wrap working with the ratio 0-100
	Local a:T=0,b:T=100
	Return Wrap(x,a,b)
End 

Function WrapDeg<T>:T(x:T)
	' Short version of Wrap working with degres
	Local a:T=0,b:T=360
	Return Wrap(x,a,b)	
End

Function WrapRad<T>:T(x:T)
	' Short version of Wrap working with radians
	Local a:T=0,b:T=TwoPi	
	Return Wrap(x,a,b)
End

Function WrapMinute:Double(minutes:Double)
	Return Wrap(minutes,Double(0.0),Double(60.0))
End 

Function WrapHour:Double(hours:Double)
	Return Wrap(hours,Double(0.0),Double(24.0))
End 

Function WrapDay:Double(days:Double)
	Return Wrap(days,Double(0.0),Double(7.0))
End 

Function WrapMonth:Double(months:Double)
	Return Wrap(months,Double(0.0),Double(12.0))
End 

Function WrapMinute2:Double(minutes:Double)
	
	'Counts the number of time the wrap is done
 
	Local r:=Wrap2(minutes,Double(0.0),Double(60.0))
	Return Float(String(String(Int(r.Item1))+","+String(Int(r.Item2))))
End 

Function WrapHour2:Double(hours:Double)
	
	'Counts the number of time the wrap is done
	
	Local r:=Wrap2(hours,Double(0.0),Double(24.0))
	Return Float(String(String(Int(r.Item1))+","+String(Int(r.Item2))))
End 

Function WrapDay2:Double(days:Double)
	
	'Counts the number of time the wrap is done
	
	Local r:=Wrap2(days,Double(0.0),Double(7.0))
	Return Float(String(String(Int(r.Item1))+","+String(Int(r.Item2))))	
End 

Function WrapMonth2:Double(months:Double)
	
	'Counts the number of time the wrap is done
	
	Local r:=Wrap2(months,Double(0.0),Double(12.0))
	Return Float(String(String(Int(r.Item1))+","+String(Int(r.Item2))))	
End 

