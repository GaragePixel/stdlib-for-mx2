
Namespace stdlib.graphics

'==============================================================
' Canvas Wrapper - Low-level Graphics Resource Abstraction
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Canvas Wrapper is a kind of abstraction layer around Canvas objects.
' It enables swapping underlying rendering implementation 
' without code changes, it uses closures for customizable behavior 
' without inheritance, and it integrates smoothly with FrameBuffer 
' triple-buffer system of sdk_mojo/Aida 4.
'==============================================================

Class CanvasWrapper<C,I,T>
	
	' Constructor
	Method New(canvas:C)
		_canvas = canvas
	End

	' Drawing operations that exist on Mojo's Canvas
	Method DrawImage:Void(
		image:I, 
		x:Float, y:Float, 
		rotation:Float=0, 
		scaleX:Float=1, scaleY:Float=1)
		
		_canvas.DrawImage(image, x, y, rotation, scaleX, scaleY)
	End
	
	' Additional drawing method for ImageWrapper convenience
	Method DrawImage:Void(
		image:ImageWrapper<C,I,T>, 
		x:Float, y:Float, 
		rotation:Float=0, 
		scaleX:Float=1, scaleY:Float=1)
		
		'_canvas.DrawImage(image.Image, x, y, rotation, scaleX, scaleY)
		_canvas.DrawImage(image, x, y, rotation, scaleX, scaleY)
	End
	
	'_f.DrawImage( _frontBuffer._i, _position.x, _position.y, _angle, _scale.x, _scale.y )
	
	Method DrawRect:Void(x:Float, y:Float, width:Float, height:Float)
		_canvas.DrawRect(x, y, width, height)
	End
	
	Method DrawOval:Void(x:Float, y:Float, width:Float, height:Float)
		_canvas.DrawOval(x, y, width, height)
	End
	
	Method DrawLine:Void(x1:Float, y1:Float, x2:Float, y2:Float)
		_canvas.DrawLine(x1, y1, x2, y2)
	End
	
	Method DrawText:Void(text:String, x:Float, y:Float, xalign:Float=0, yalign:Float=0)
		_canvas.DrawText(text, x, y, xalign, yalign)
	End
	
	Method Clear:Void(color:Color)
		_canvas.Clear(color)
	End
	
	' Getter/Setter properties
	Property Alpha:Float()
		Return _canvas.Alpha
	Setter(alpha:Float)
		_canvas.Alpha = alpha
	End
	
	Property Color:Color()
		Return _canvas.Color
	Setter(color:Color)
		_canvas.Color = color
	End
	
	' Transform operations
	Method Scale:Void(sx:Float, sy:Float)
		_canvas.Scale(sx, sy)
	End
	
	Method Rotate:Void(angle:Float)
		_canvas.Rotate(angle)
	End
	
	Method Translate:Void(tx:Float, ty:Float)
		_canvas.Translate(tx, ty)
	End
	
	Method PushMatrix:Void()
		_canvas.PushMatrix()
	End
	
	Method PopMatrix:Void()
		_canvas.PopMatrix()
	End
	
	Method Flush:Void()
		_canvas.Flush()
	End

	Method CopyPixmap:Pixmap( rect:Recti )
		Return _canvas.CopyPixmap(rect)
	End
	
	Method CopyPixels( rect:Recti,pixmap:Pixmap,dstx:Int=0,dsty:Int=0 )
		_canvas.CopyPixels(rect,pixmap,dstx,dsty)
	End
	
	' Direct access to underlying canvas
	Method Canvas:C()
		Return _canvas
	End
	
	Protected 
	
	Field _canvas:C
End
