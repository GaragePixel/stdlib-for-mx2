'==============================================================
' Monkey2 Wacom Tablet API
' Implementation: iDkP from GaragePixel
' 2025-03-17 Aida 4
'==============================================================

#Rem
The MIT License (MIT)

Copyright (c) 2025 iDkP from GaragePixel

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#End

Namespace stdlib.io.tablet

'--------------------------------------------------------------
' Library Overview
'--------------------------------------------------------------

' Purpose:
' This lightweight API provides Monkey2 applications with access
' to pressure-sensitive drawing tablet devices such as Wacom tablets.
' It wraps native tablet APIs through a simple and consistent interface
' that works across Windows, macOS and Linux platforms.
'
' Functionality:
' - Detection of pen tablet devices (Wacom, Huion, XP-Pen)
' - Access to tablet properties (resolution, active area)
' - Real-time pen input data (position, pressure, tilt)
' - Support for multiple stylus buttons
' - Eraser detection on compatible pens
' - Integrated event handling compatible with Monkey2 events
' - Control over cursor visibility
' - Access to device-specific capabilities
'
' Notes:
' The implementation uses OS-specific tablet APIs under the hood:
' Windows: Wintab API
' macOS: NSEvent tablet data
' Linux: X11 XInput2 extension
'
' Cross-platform compatibility is achieved by normalizing values
' and providing a consistent event model regardless of underlying
' API differences. Pressure is always normalized to 0.0-1.0 range.
'
' Technical advantages:
' - Non-blocking event handling that integrates with Monkey2's event system
' - Low overhead C wrapper with minimal dependencies
' - Support for multitouch and tablet gestures where available
' - Auto-detection of tablet connection/disconnection
' - Calibration options for pressure curves and tablet mapping
' - Fallback to mouse input when tablet not available
' - Memory-efficient design with small footprint
' - Thread-safe implementation for asynchronous tablet events

'--------------------------------------------------------------
' C API Bindings
'--------------------------------------------------------------

Using stdlib.plugins.libc

#Import "api.monkey2"

' External C functions

#Import "native/astablet.h"

#If __TARGET__="windows"
	#Import "native/astablet_win32.cpp"
#Elseif __TARGET__="macos"
	#Import "native/astablet_macos.mm" 
#Elseif __TARGET__="linux"
	#Import "native/astablet_linux.cpp"
#Endif

Extern

' Core tablet functions
Function astablet_init:Bool()="astablet_init"
Function astablet_shutdown:Void()="astablet_shutdown"
Function astablet_update:Bool()="astablet_update"
	
' Tablet device functions
Function astablet_is_available:Bool()="astablet_is_available"
Function astablet_get_device_count:Int()="astablet_get_device_count"
Function astablet_get_device_name:CString(deviceIndex:Int)="astablet_get_device_name"
	
' Tablet properties
Function astablet_get_width:Float()="astablet_get_width"
Function astablet_get_height:Float()="astablet_get_height"
Function astablet_get_resolution:Float()="astablet_get_resolution"
Function astablet_get_pressure_levels:Int()="astablet_get_pressure_levels"
	
' Input state
Function astablet_get_x:Float()="astablet_get_x"
Function astablet_get_y:Float()="astablet_get_y"
Function astablet_get_pressure:Float()="astablet_get_pressure"
Function astablet_get_tilt_x:Float()="astablet_get_tilt_x"
Function astablet_get_tilt_y:Float()="astablet_get_tilt_y"
Function astablet_get_button_state:Int(button:Int)="astablet_get_button_state"
Function astablet_is_eraser:Bool()="astablet_is_eraser"
	
' Configuration
Function astablet_set_mapping:Void(x:Float, y:Float, width:Float, height:Float)="astablet_set_mapping"
Function astablet_set_pressure_curve:Void(a:Float, b:Float, c:Float, d:Float)="astablet_set_pressure_curve"
