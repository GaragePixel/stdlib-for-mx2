'==============================================================
' Monkey2 Wacom Tablet API
' Implementation: iDkP from GaragePixel
' 2025-03-17 Aida 4
'==============================================================

Namespace stdlib.io.tablet.api

Using stdlib.io.tablet

'--------------------------------------------------------------
' TabletEvent Class
'--------------------------------------------------------------
'
' The TabletEvent class completes the API by:
'
'   - Providing a complete encapsulation of tablet state at a point in time, 
'	making it easy to pass all relevant data as a single object
'
'   - Adding derived calculations like azimuth and altitude angles which are useful 
'	for advanced pen effects but not directly provided by the native API
'
'   - Supporting a more event-driven programming model where developers can handle discrete tablet events 
'	rather than polling individual properties
'
'   - Making it easier to store and process historical pen data for features like stroke smoothing, 
'	undo systems, or recording/playback features

Class TabletEvent
	Field x:Float             ' X position in screen coordinates
	Field y:Float             ' Y position in screen coordinates
	Field pressure:Float      ' Pressure value (0.0 - 1.0)
	Field tiltX:Float         ' X tilt in degrees (-60.0 to 60.0)
	Field tiltY:Float         ' Y tilt in degrees (-60.0 to 60.0)
	Field isEraser:Bool       ' True if using eraser end of pen
	Field buttonState:Int     ' Bit flags for buttons (bit 0=primary, bit 1=secondary, etc)
	Field deviceIndex:Int     ' Index of the tablet device
	
	Method New(x:Float, y:Float, pressure:Float, tiltX:Float, tiltY:Float)
		Self.x = x
		Self.y = y
		Self.pressure = pressure
		Self.tiltX = tiltX
		Self.tiltY = tiltY
	End
	
	' Calculate pen azimuth angle in radians
	Method GetAzimuth:Float()
		Return ATan2(tiltY, tiltX)
	End
	
	' Calculate pen altitude angle in radians
	Method GetAltitude:Float()
		Local tilt:Float = Sqrt(tiltX * tiltX + tiltY * tiltY)
		Return Pi/2 - tilt * Pi/180
	End
	
	' Get buttons as easily testable flags
	Method IsButtonPressed:Bool(buttonIndex:Int)
		Return (buttonState & (1 Shl buttonIndex)) <> 0
	End
End

'--------------------------------------------------------------
' TabletManager Class
'--------------------------------------------------------------

Class TabletManager
	
	Private 
	
	' Singleton instance
	Global _instance:TabletManager 
		
	Public
	
	' Get singleton instance
	Function GetInstance:TabletManager()
		If Not _instance Then _instance = New TabletManager
		Return _instance
	End
	
	' Initialize tablet system
	Method Initialize:Bool()
		Return astablet_init()
	End
	
	' Update tablet state, returns true if new events available
	Method UpdateTablet:Bool()
		Return astablet_update()
	End
	
	' Get tablet availability
	Method IsAvailable:Bool()
		Return astablet_is_available()
	End
	
	' Get number of connected tablet devices
	Method GetDeviceCount:Int()
		Return astablet_get_device_count()
	End
	
	' Get name of tablet device by index
	Method GetDeviceName:String(deviceIndex:Int=0)
		Local name:String = astablet_get_device_name(deviceIndex)
		Return name
	End
	
	' Get current pen X position
	Method GetX:Float()
		Return astablet_get_x()
	End
	
	' Get current pen Y position
	Method GetY:Float()
		Return astablet_get_y()
	End
	
	' Get current pressure (0.0-1.0)
	Method GetPressure:Float()
		Return astablet_get_pressure()
	End
	
	' Get X tilt angle in degrees
	Method GetTiltX:Float()
		Return astablet_get_tilt_x()
	End
	
	' Get Y tilt angle in degrees
	Method GetTiltY:Float()
		Return astablet_get_tilt_y()
	End
	
	' Check if button is pressed
	Method IsButtonPressed:Bool(button:Int)
		Return (astablet_get_button_state(0) & (1 Shl button)) <> 0
	End
	
	' Check if using eraser end
	Method IsEraser:Bool()
		Return astablet_is_eraser()
	End
	
	' Set tablet mapping to screen region
	Method SetMapping:Void(x:Float, y:Float, width:Float, height:Float)
		astablet_set_mapping(x, y, width, height)
	End
	
	' Set pressure response curve (Bezier control points)
	Method SetPressureCurve:Void(a:Float, b:Float, c:Float, d:Float)
		astablet_set_pressure_curve(a, b, c, d)
	End
	
	' Shutdown tablet system
	Method Shutdown:Void()
		astablet_shutdown()
	End
	
	'------------------------------------ If the API event is used:

	' Latest tablet event
	Field currentEvent:TabletEvent = New TabletEvent(0, 0, 0, 0, 0)
	
	' Event handler delegate type
	Alias TabletEventHandler:Void(event:TabletEvent)
	
	' Event handlers list
	Field eventHandlers:List<TabletEventHandler> = New List<TabletEventHandler>
	
	' Update tablet state, returns true if new events available
	Method Update:Bool()
		If astablet_update()
			' Update current event
			currentEvent.x = astablet_get_x()
			currentEvent.y = astablet_get_y()
			currentEvent.pressure = astablet_get_pressure()
			currentEvent.tiltX = astablet_get_tilt_x()
			currentEvent.tiltY = astablet_get_tilt_y()
			currentEvent.isEraser = astablet_is_eraser()
			currentEvent.buttonState = astablet_get_button_state(0)
			
			' Dispatch to handlers
			For Local handler:TabletEventHandler = Eachin eventHandlers
				handler(currentEvent)
			Next
			
			Return True
		End
		
		Return False
	End
	
	' Get current tablet event
	Method GetEvent:TabletEvent()
		Return currentEvent
	End
	
	' Add event handler
	Method AddEventHandler:Void(handler:TabletEventHandler)
		eventHandlers.AddLast(handler)
	End
	
	' Remove event handler
	Method RemoveEventHandler:Void(handler:TabletEventHandler)
		eventHandlers.RemoveEach(handler)
	End

End



'--------------------------------------------------------------
' Usage Example
'--------------------------------------------------------------
#rem
' Example usage function
Function TabletExample:Void()
	Local tablet:TabletManager = TabletManager.GetInstance()
	
	If Not tablet.Initialize()
		Print("Failed to initialize tablet system")
		Return
	End
	
	If Not tablet.IsAvailable()
		Print("No tablet devices found!")
		Return
	End
	
	Print("Found tablet: " + tablet.GetDeviceName())
	
	' Main loop would normally be here
	' You would call tablet.Update() each frame
	
	Local x:Float, y:Float, pressure:Float
	
	' Example loop
	For Local i:Int = 0 Until 100
		If tablet.UpdateTablet()
			x = tablet.GetX()
			y = tablet.GetY()
			pressure = tablet.GetPressure()
			
			Print("Pen at: " + x + "," + y + " with pressure: " + pressure)
			
			If tablet.IsEraser()
				Print("Using eraser")
			End
		End
		
		' Your app's drawing code would go here
	End
	
	tablet.Shutdown()
End
#end