
Namespace stdlib.graphics

'==============================================================
' Image Buffer - Low-level Graphics Resource Abstraction
' CPU/GPU Transfer Pipeline Interface
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Provides an agnostic interface for seamless data transfer 
' between CPU (Pixmap) and GPU (Texture) resources through a
' unified wrapper architecture. This component bridges the
' zero-branch pixel operations of stdlib's Aida 4 with the
' hardware-accelerated rendering capabilities of underlying
' graphics systems.
'
' The buffer maintains consistent access patterns regardless of
' implementation details, enabling platform-independent code
' while preserving the zero-branch execution philosophy through
' delegate-based operations. Its resource management approach
' minimizes allocation overhead through efficient pooling
' mechanisms that support high-performance rendering pipelines.
'==============================================================

Class ImageBuffer<C,I,T>
	' Fully agnostic ImageBuffer for GPU-CPU transfer operations
	Method New(width:Int, height:Int, format:PixelFormat)
		_width = width
		_height = height
		_format = format
			
		' Create wrapped resources for agnostic implementation
		_image = New ImageWrapper<C,I,T>(width, height, format)
		_canvas = New CanvasWrapper<C,I,T>(New C(_image.Image))
	End
	
	Property Image:ImageWrapper<C,I,T>()
		Return _image
	End
	
	Property Canvas:CanvasWrapper<C,I,T>()
		Return _canvas
	End
	
	Property Width:Int()
		Return _width
	End
	
	Property Height:Int()
		Return _height
	End
	
	Property Format:PixelFormat()
		Return _format
	End
	
	' Method to clear buffer contents with optional color
	Method Clear(color:Color = Null)
		If color = Null Then
			_canvas.Clear(Color.None)
		Else
			_canvas.Clear(color)
		Endif
	End

	' Internal fields
	Field _image:ImageWrapper<C,I,T>
	Field _canvas:CanvasWrapper<C,I,T>
	Field _width:Int
	Field _height:Int
	Field _format:PixelFormat
End