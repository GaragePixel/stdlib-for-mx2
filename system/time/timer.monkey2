
#If __TARGET__="emscripten"

#Import "timer_emscripten"

#Else

Namespace stdlib.system.timer

Private

Using stdlib.system.time
Using stdlib.collections
Using stdlib.system.fiber

Public

#rem monkeydoc The Timer class.
#end
Class Timer

	#rem monkeydoc Creates a new Timer.
	
	Creates new timer with `hertz` frequency.
	
	The timer will continually invoke the `fired` function at the rate of `hertz` times per second.
	
	#end
	Method New( hertz:Double,fired:Void() )
	
		New Fiber( Lambda()
		
			Local period:=1/hertz
		
			Local timeout:=Now()+period
	
			While Not _cancelled
			
				Local now:=Now()
			
				Local sleep:=timeout-now
				If sleep>0
					Fiber.Sleep( sleep )
					Continue
				Endif
				
				If _cancelled Exit
				
				If Not _suspended fired()

				timeout+=period

			Wend
		
		End )

	End

	#rem monkeydoc Timer suspended state.
	#end
		
	Property Suspended:Bool()
	
		Return _suspended
	
	Setter( suspended:Bool )
	
		_suspended=suspended
	End
	
	#rem monkeydoc Cancels the timer.
	#end
	Method Cancel()
	
		_cancelled=True
	End
	
	Private
	
	Field _suspended:Bool
	
	Field _cancelled:Bool
End

#Endif

Class DeltaTimer
	
	'iDkP from GaragePixel
	'	Added because it was asked on Discord by Cyprus
    
    Field targetfps:Float = 60
    Field currentticks:Float
    Field lastticks:Float
    Field frametime:Float
    Field delta:Float
    
    Method New (fps:Float)
        targetfps = fps
        lastticks = time.Millisecs()
    End
    
    Method UpdateDelta()
        currentticks = time.Millisecs()
        frametime = currentticks - lastticks
        delta = frametime / (1000.0 / targetfps)
        lastticks = currentticks
    End
End
