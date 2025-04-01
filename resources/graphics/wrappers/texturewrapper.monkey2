
Namespace stdlib.graphics

'==============================================================
' Texture Wrapper - Low-level Graphics Resource Abstraction
' Implementation: iDkP from GaragePixel
' 2025-03-31 (Aida 4)
'==============================================================
' Provides a delegate-based abstraction around Texture objects
' enabling zero-branch execution paths through function delegation.
' This wrapper maintains the Aida 4 pipeline's philosophy of
' runtime-configurable behavior without inheritance or conditional
' branching in critical rendering paths.
'==============================================================

Class TextureWrapper<T>

	Method New(texture:T)
		_texture = texture
		InitializeHandlers()
	End
	
	Method New(width:Int, height:Int, format:PixelFormat=PixelFormat.RGBA8, flags:TextureFlags=TextureFlags.FilterMipmap)
		' This assumes T has a compatible constructor - might not work for all generic types
		' For specialized implementations, this constructor can be overridden
		_texture = New T(width, height, format, flags)
		InitializeHandlers()
	End
	
	'*******************************************
	' Core Texture Properties
	'*******************************************

	Property Size:Vec2i()
		If _sizeHandler<>Null Then Return _sizeHandler()
		Return Null
	End
	
	Property Width:Int()
		If _widthHandler<>Null Then Return _widthHandler()
		Return 0
	End
	
	Property Height:Int()
		If _heightHandler<>Null Then Return _heightHandler()
		Return 0
	End
	
	Property Format:PixelFormat()
		If _formatHandler<>Null Then Return _formatHandler()
		Return PixelFormat.Unknown
	End
	
	Property Flags:TextureFlags()
		If _flagsHandler<>Null Then Return _flagsHandler()
		Return TextureFlags.None
	End
	
	'*******************************************
	' Pixmap Integration
	'*******************************************
	
	Method PastePixmap:Void(pixmap:Pixmap, x:Int=0, y:Int=0)
		If _pastePixmapHandler<>Null Then _pastePixmapHandler(pixmap, x, y)
	End
	
	'*******************************************
	' Resource Operations
	'*******************************************

	Method Load:Bool(path:String)
		If _loadHandler<>Null Then Return _loadHandler(path)
		Return False
	End

	Method LoadNormal:Bool(path:String, textureFlags:TextureFlags=TextureFlags.FilterMipmap, specular:String="", specularScale:Float=1, flipNormalY:Bool=True)
		If _loadNormalHandler<>Null Then Return _loadNormalHandler(path, textureFlags, specular, specularScale, flipNormalY)
		Return False
	End
	
	Method ColorTexture:Void(color:Color)
		If _colorTextureHandler<>Null Then _colorTextureHandler(color)
	End
	
	Method FlatNormal:Void()
		If _flatNormalHandler<>Null Then _flatNormalHandler()
	End
	
	Method GLTarget:Int()
		If _glTargetHandler<>Null Then Return _glTargetHandler()
		Return 0
	End
	
	Method Modified:Void(r:Recti)
		If _modifiedHandler<>Null Then _modifiedHandler(r)
	End
	
	Method Bind:Void(unit:Int=0)
		If _bindHandler<>Null Then _bindHandler(unit)
	End
	
	Method ValidateGLTexture:Bool()
		If _validateGLTextureHandler<>Null Then Return _validateGLTextureHandler()
		Return False
	End
	
	Method OnDiscard:Void()
		If _onDiscardHandler<>Null Then _onDiscardHandler()
	End

	Method OnFinalize:Void()
		If _onFinalizeHandler<>Null Then _onFinalizeHandler()
	End
	
	Method UploadTexImage2D:Void(target:Int, pixmap:Pixmap, mipLevel:Int=0)
		If _uploadTexImage2DHandler<>Null Then _uploadTexImage2DHandler(target, pixmap, mipLevel)
	End
	
	Method ClearTexImage2D:Void(target:Int, mipLevel:Int, format:PixelFormat, type:Int, color:Color)
		If _clearTexImage2DHandler<>Null Then _clearTexImage2DHandler(target, mipLevel, format, type, color)
	End
	
	Method OpenTexture:Bool(path:String)
		If _openTextureHandler<>Null Then Return _openTextureHandler(path)
		Return False
	End
	
	' Direct access to the underlying texture
	Property Texture:T()
		Return _texture
	End
	
	'*******************************************
	' Handler Management
	'*******************************************
	
	' Property handlers
	Method SetSizeHandler:Void(handler:Vec2i())
		_sizeHandler = handler
	End
	
	Method SetWidthHandler:Void(handler:Int())
		_widthHandler = handler
	End
	
	Method SetHeightHandler:Void(handler:Int())
		_heightHandler = handler
	End
	
	Method SetFormatHandler:Void(handler:PixelFormat())
		_formatHandler = handler
	End
	
	Method SetFlagsHandler:Void(handler:TextureFlags())
		_flagsHandler = handler
	End
	
	' Pixmap operation handlers
	Method SetPastePixmapHandler:Void(handler:Void(pixmap:Pixmap, x:Int, y:Int))
		_pastePixmapHandler = handler
	End
	
	' Resource operation handlers
	Method SetLoadHandler:Void(handler:Bool(path:String))
		_loadHandler = handler
	End
	
	Method SetLoadNormalHandler:Void(handler:Bool(path:String, textureFlags:TextureFlags, specular:String, specularScale:Float, flipNormalY:Bool))
		_loadNormalHandler = handler
	End
	
	Method SetColorTextureHandler:Void(handler:Void(color:Color))
		_colorTextureHandler = handler
	End
	
	Method SetFlatNormalHandler:Void(handler:Void())
		_flatNormalHandler = handler
	End
	
	Method SetGLTargetHandler:Void(handler:Int())
		_glTargetHandler = handler
	End
	
	Method SetModifiedHandler:Void(handler:Void(r:Recti))
		_modifiedHandler = handler
	End
	
	Method SetBindHandler:Void(handler:Void(unit:Int))
		_bindHandler = handler
	End
	
	Method SetValidateGLTextureHandler:Void(handler:Bool())
		_validateGLTextureHandler = handler
	End
	
	Protected
	
	'*******************************************
	' Initialize Default Handlers
	'*******************************************
	Method InitializeHandlers:Void()
		' Create explicit function variables instead of inline Lambdas
		' This avoids compiler issues with function resolution
		
		' Property handlers
		Local sizeFunc:Vec2i()
		sizeFunc = Lambda:Vec2i()
			Return _texture.Size
		End
		SetSizeHandler(sizeFunc)
		
		Local widthFunc:Int()
		widthFunc = Lambda:Int()
			Return _texture.Width
		End
		SetWidthHandler(widthFunc)
		
		Local heightFunc:Int()
		heightFunc = Lambda:Int()
			Return _texture.Height
		End
		SetHeightHandler(heightFunc)
		
		Local formatFunc:PixelFormat()
		formatFunc = Lambda:PixelFormat()
			Return _texture.Format
		End
		SetFormatHandler(formatFunc)
		
		Local flagsFunc:TextureFlags()
		flagsFunc = Lambda:TextureFlags()
			Return _texture.Flags
		End
		SetFlagsHandler(flagsFunc)
		
		' Pixmap operation handlers
		Local pastePixmapFunc:Void(pixmap:Pixmap, x:Int, y:Int)
		pastePixmapFunc = Lambda:Void(pixmap:Pixmap, x:Int, y:Int)
			_texture.PastePixmap(pixmap, x, y)
		End
		SetPastePixmapHandler(pastePixmapFunc)
		
		' Resource operation handlers
		Local loadFunc:Bool(path:String)
		loadFunc = Lambda:Bool(path:String)
			Return _texture.Load(path)
		End
		SetLoadHandler(loadFunc)
		
		Local loadNormalFunc:Bool(path:String, textureFlags:TextureFlags, specular:String, specularScale:Float, flipNormalY:Bool)
		loadNormalFunc = Lambda:Bool(path:String, textureFlags:TextureFlags, specular:String, specularScale:Float, flipNormalY:Bool)
			Return _texture.LoadNormal(path, textureFlags, specular, specularScale, flipNormalY)
		End
		SetLoadNormalHandler(loadNormalFunc)
		
		Local colorTextureFunc:Void(color:Color)
		colorTextureFunc = Lambda:Void(color:Color)
			_texture.ColorTexture(color)
		End
		SetColorTextureHandler(colorTextureFunc)
		
		Local flatNormalFunc:Void()
		flatNormalFunc = Lambda:Void()
			_texture.FlatNormal()
		End
		SetFlatNormalHandler(flatNormalFunc)
		
		Local glTargetFunc:Int()
		glTargetFunc = Lambda:Int()
			Return _texture.GLTarget
		End
		SetGLTargetHandler(glTargetFunc)
		
		Local modifiedFunc:Void(r:Recti)
		modifiedFunc = Lambda:Void(r:Recti)
			_texture.Modified(r)
		End
		SetModifiedHandler(modifiedFunc)
		
		Local bindFunc:Void(unit:Int)
		bindFunc = Lambda:Void(unit:Int)
			_texture.Bind(unit)
		End
		SetBindHandler(bindFunc)
		
		Local validateGLTextureFunc:Bool()
		validateGLTextureFunc = Lambda:Bool()
			Return _texture.ValidateGLTexture()
		End
		SetValidateGLTextureHandler(validateGLTextureFunc)
	End
	
	'*******************************************
	' Fields
	'*******************************************
	Field _texture:T
	
	' Property handlers
	Field _sizeHandler:Vec2i()
	Field _widthHandler:Int()
	Field _heightHandler:Int()
	Field _formatHandler:PixelFormat()
	Field _flagsHandler:TextureFlags()
	
	' Pixmap operation handlers
	Field _pastePixmapHandler:Void(pixmap:Pixmap, x:Int, y:Int)
	
	' Resource operation handlers
	Field _loadHandler:Bool(path:String)
	Field _loadNormalHandler:Bool(path:String, textureFlags:TextureFlags, specular:String, specularScale:Float, flipNormalY:Bool)
	Field _colorTextureHandler:Void(color:Color)
	Field _flatNormalHandler:Void()
	Field _glTargetHandler:Int()
	Field _modifiedHandler:Void(r:Recti)
	Field _bindHandler:Void(unit:Int)
	Field _validateGLTextureHandler:Bool()
	Field _onDiscardHandler:Void()
	Field _onFinalizeHandler:Void()
	Field _uploadTexImage2DHandler:Void(target:Int, pixmap:Pixmap, mipLevel:Int)
	Field _clearTexImage2DHandler:Void(target:Int, mipLevel:Int, format:PixelFormat, type:Int, color:Color)
	Field _openTextureHandler:Bool(path:String)
End