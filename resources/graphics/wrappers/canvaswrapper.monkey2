
Namespace stdlib.graphics

'==============================================================
' Image Wrapper - Low-level Graphics Resource Abstraction
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Image Wrapper is a kind of abstraction layer around Canvas objects.
' It enables swapping underlying rendering implementation 
' without code changes, it uses closures for customizable behavior 
' without inheritance, and it integrates smoothly with FrameBuffer 
' triple-buffer system of sdk_mojo/Aida 4.
'==============================================================

Class CanvasWrapper<C,I,T>

	Method New(canvas:C)
		_canvas = canvas
		InitializeHandlers()
	End
	
	'*******************************************
	' Drawing Operations
	'*******************************************
	
	' For use with ImageWrapper objects
	Method DrawImage:CanvasWrapper<C,I,T>(image:ImageWrapper<C,I,T>, x:Float, y:Float, rotation:Float=0.0, scaleX:Float=1.0, scaleY:Float=1.0)
		If _drawImageHandler<>Null Then _drawImageHandler(image, x, y, rotation, scaleX, scaleY)
		Return Self
	End
	
	' For use with regular Image objects
	Method DrawImage:CanvasWrapper<C,I,T>(image:Image, x:Float, y:Float, rotation:Float=0.0, scaleX:Float=1.0, scaleY:Float=1.0)
		If _drawDirectImageHandler<>Null Then _drawDirectImageHandler(image, x, y, rotation, scaleX, scaleY)
		Return Self
	End
	
	' Shape drawing operations - all use chainable return values
	Method DrawRect:CanvasWrapper<C,I,T>(x:Float, y:Float, width:Float, height:Float)
		If _drawRectHandler<>Null Then _drawRectHandler(x, y, width, height)
		Return Self
	End
	
	Method DrawOval:CanvasWrapper<C,I,T>(x:Float, y:Float, width:Float, height:Float)
		If _drawOvalHandler<>Null Then _drawOvalHandler(x, y, width, height)
		Return Self
	End
	
	Method DrawLine:CanvasWrapper<C,I,T>(x1:Float, y1:Float, x2:Float, y2:Float)
		If _drawLineHandler<>Null Then _drawLineHandler(x1, y1, x2, y2)
		Return Self
	End
	
	' Text drawing operations
	Method DrawText:CanvasWrapper<C,I,T>(text:String, x:Float, y:Float, xalign:Float=0.0, yalign:Float=0.0)
		If _drawTextHandler<>Null Then _drawTextHandler(text, x, y, xalign, yalign)
		Return Self
	End
	
	' Buffer clearing operation
	Method Clear:CanvasWrapper<C,I,T>(color:Color)
		If _clearHandler<>Null Then _clearHandler(color)
		Return Self
	End
	
	'*******************************************
	' State Management
	'*******************************************
	
	' Alpha transparency control
	Method Alpha:CanvasWrapper<C,I,T>(alpha:Float)
		If _alphaHandler<>Null Then _alphaHandler(alpha)
		Return Self
	End
	
	' Color setting
	Method Color:CanvasWrapper<C,I,T>(color:Color)
		If _colorHandler<>Null Then _colorHandler(color)
		Return Self
	End
	
	' Transform operations
	Method Scale:CanvasWrapper<C,I,T>(sx:Float, sy:Float)
		If _scaleHandler<>Null Then _scaleHandler(sx, sy)
		Return Self
	End
	
	Method Rotate:CanvasWrapper<C,I,T>(angle:Float)
		If _rotateHandler<>Null Then _rotateHandler(angle)
		Return Self
	End
	
	Method Translate:CanvasWrapper<C,I,T>(tx:Float, ty:Float)
		If _translateHandler<>Null Then _translateHandler(tx, ty)
		Return Self
	End
	
	' Matrix stack management
	Method PushMatrix:CanvasWrapper<C,I,T>()
		If _pushMatrixHandler<>Null Then _pushMatrixHandler()
		Return Self
	End
	
	Method PopMatrix:CanvasWrapper<C,I,T>()
		If _popMatrixHandler<>Null Then _popMatrixHandler()
		Return Self
	End
	
	'*******************************************
	' Handler Management
	'*******************************************
	
	' Image drawing handlers
	Method SetDrawImageHandler:Void(handler:Void(image:ImageWrapper<C,I,T>, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float))
		_drawImageHandler = handler
	End
	
	Method SetDrawDirectImageHandler:Void(handler:Void(image:Image, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float))
		_drawDirectImageHandler = handler
	End
	
	' Shape drawing handlers
	Method SetDrawRectHandler:Void(handler:Void(x:Float, y:Float, width:Float, height:Float))
		_drawRectHandler = handler
	End
	
	Method SetDrawOvalHandler:Void(handler:Void(x:Float, y:Float, width:Float, height:Float))
		_drawOvalHandler = handler
	End
	
	Method SetDrawLineHandler:Void(handler:Void(x1:Float, y1:Float, x2:Float, y2:Float))
		_drawLineHandler = handler
	End
	
	' Text drawing handlers
	Method SetDrawTextHandler:Void(handler:Void(text:String, x:Float, y:Float, xalign:Float, yalign:Float))
		_drawTextHandler = handler
	End
	
	' Buffer operation handlers
	Method SetClearHandler:Void(handler:Void(color:Color))
		_clearHandler = handler
	End
	
	' State management handlers
	Method SetAlphaHandler:Void(handler:Void(alpha:Float))
		_alphaHandler = handler
	End
	
	Method SetColorHandler:Void(handler:Void(color:Color))
		_colorHandler = handler
	End
	
	' Transform handlers
	Method SetScaleHandler:Void(handler:Void(sx:Float, sy:Float))
		_scaleHandler = handler
	End
	
	Method SetRotateHandler:Void(handler:Void(angle:Float))
		_rotateHandler = handler
	End
	
	Method SetTranslateHandler:Void(handler:Void(tx:Float, ty:Float))
		_translateHandler = handler
	End
	
	' Matrix stack handlers
	Method SetPushMatrixHandler:Void(handler:Void())
		_pushMatrixHandler = handler
	End
	
	Method SetPopMatrixHandler:Void(handler:Void())
		_popMatrixHandler = handler
	End

	'*******************************************
	' Pixel operations
	'*******************************************

	' Extract pixels from canvas to pixmap with region control
	Method CopyPixels:Void(rect:Recti, pixmap:Pixmap)
		If _copyPixelsHandler<>Null Then _copyPixelsHandler(rect, pixmap)
	End
	
	' Register CopyPixels handler
	Method SetCopyPixelsHandler:Void(handler:Void(rect:Recti, pixmap:Pixmap))
		_copyPixelsHandler = handler
	End
	
	' Initialize CopyPixels handler - called from InitializeHandlers method
	Method InitializeCopyPixelsHandler:Void()
		Local copyPixelsFunc:Void(rect:Recti, pixmap:Pixmap)
		copyPixelsFunc = Lambda:Void(rect:Recti, pixmap:Pixmap)
			_canvas.CopyPixels(rect, pixmap)
		End
		SetCopyPixelsHandler(copyPixelsFunc)
	End
	
	'*******************************************
	' Underlying Canvas Access
	'*******************************************
	Property Canvas:C()
		Return _canvas
	End
	
	Protected
	
	'*******************************************
	' Initialize Default Handlers
	'*******************************************
' Update the InitializeHandlers method to include CopyPixels handler
	Method InitializeHandlers:Void()
		' Existing handlers...
		
		' DrawImage handler - for wrapped images
		Local drawImgHandler:Void(image:ImageWrapper<C,I,T>, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
		drawImgHandler = Lambda(img:ImageWrapper<C,I,T>, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
			_canvas.DrawImage(img.Image, x, y, rotation, scaleX, scaleY)
		End
		SetDrawImageHandler(drawImgHandler)
		
		' DrawImage handler - for direct images
		Local drawDirectImgHandler:Void(image:Image, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
		drawDirectImgHandler = Lambda(img:Image, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
			_canvas.DrawImage(img, x, y, rotation, scaleX, scaleY)
		End
		SetDrawDirectImageHandler(drawDirectImgHandler)
		
		' DrawRect handler
		Local drawRectHandler:Void(x:Float, y:Float, width:Float, height:Float)
		drawRectHandler = Lambda(x:Float, y:Float, width:Float, height:Float)
			_canvas.DrawRect(x, y, width, height)
		End
		SetDrawRectHandler(drawRectHandler)
		
		' DrawOval handler
		Local drawOvalHandler:Void(x:Float, y:Float, width:Float, height:Float)
		drawOvalHandler = Lambda(x:Float, y:Float, width:Float, height:Float)
			_canvas.DrawOval(x, y, width, height)
		End
		SetDrawOvalHandler(drawOvalHandler)
		
		' DrawLine handler
		Local drawLineHandler:Void(x1:Float, y1:Float, x2:Float, y2:Float)
		drawLineHandler = Lambda(x1:Float, y1:Float, x2:Float, y2:Float)
			_canvas.DrawLine(x1, y1, x2, y2)
		End
		SetDrawLineHandler(drawLineHandler)
		
		' DrawText handler
		Local drawTextHandler:Void(text:String, x:Float, y:Float, xalign:Float, yalign:Float)
		drawTextHandler = Lambda(text:String, x:Float, y:Float, xalign:Float, yalign:Float)
			_canvas.DrawText(text, x, y, xalign, yalign)
		End
		SetDrawTextHandler(drawTextHandler)
		
		' Clear handler
		Local clearHandler:Void(color:Color)
		clearHandler = Lambda(color:Color)
			_canvas.Clear(color)
		End
		SetClearHandler(clearHandler)
		
		' Alpha handler
		Local alphaHandler:Void(alpha:Float)
		alphaHandler = Lambda(alpha:Float)
			_canvas.Alpha = alpha
		End
		SetAlphaHandler(alphaHandler)
		
		' Color handler
		Local colorHandler:Void(color:Color)
		colorHandler = Lambda(color:Color)
			_canvas.Color = color
		End
		SetColorHandler(colorHandler)
		
		' Scale handler
		Local scaleHandler:Void(sx:Float, sy:Float)
		scaleHandler = Lambda(sx:Float, sy:Float)
			_canvas.Scale(sx, sy)
		End
		SetScaleHandler(scaleHandler)
		
		' Rotate handler
		Local rotateHandler:Void(angle:Float)
		rotateHandler = Lambda(angle:Float)
			_canvas.Rotate(angle)
		End
		SetRotateHandler(rotateHandler)
		
		' Translate handler
		Local translateHandler:Void(tx:Float, ty:Float)
		translateHandler = Lambda(tx:Float, ty:Float)
			_canvas.Translate(tx, ty)
		End
		SetTranslateHandler(translateHandler)
		
		' PushMatrix handler
		Local pushMatrixHandler:Void()
		pushMatrixHandler = Lambda()
			_canvas.PushMatrix()
		End
		SetPushMatrixHandler(pushMatrixHandler)
		
		' PopMatrix handler
		Local popMatrixHandler:Void()
		popMatrixHandler = Lambda()
			_canvas.PopMatrix()
		End
		SetPopMatrixHandler(popMatrixHandler)
		
		' Add CopyPixels handler initialization
		Local copyPixelsHandler:Void(rect:Recti, pixmap:Pixmap)
		copyPixelsHandler = Lambda(rect:Recti, pixmap:Pixmap)
			_canvas.CopyPixels(rect, pixmap)
		End
		SetCopyPixelsHandler(copyPixelsHandler)
	End
	
	'*******************************************
	' Fields
	'*******************************************
	' The wrapped canvas instance
	Field _canvas:C
	
	' Drawing operation handlers
	Field _drawImageHandler:Void(image:ImageWrapper<C,I,T>, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
	Field _drawDirectImageHandler:Void(image:Image, x:Float, y:Float, rotation:Float, scaleX:Float, scaleY:Float)
	Field _drawRectHandler:Void(x:Float, y:Float, width:Float, height:Float)
	Field _drawOvalHandler:Void(x:Float, y:Float, width:Float, height:Float)
	Field _drawLineHandler:Void(x1:Float, y1:Float, x2:Float, y2:Float)
	Field _drawTextHandler:Void(text:String, x:Float, y:Float, xalign:Float, yalign:Float)
	Field _clearHandler:Void(color:Color)
	Field _copyPixelsHandler:Void(rect:Recti, pixmap:Pixmap)
	
	' State management handlers
	Field _alphaHandler:Void(alpha:Float)
	Field _colorHandler:Void(color:Color)
	Field _scaleHandler:Void(sx:Float, sy:Float)
	Field _rotateHandler:Void(angle:Float)
	Field _translateHandler:Void(tx:Float, ty:Float)
	Field _pushMatrixHandler:Void()
	Field _popMatrixHandler:Void()
End