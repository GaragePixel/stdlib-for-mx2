
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

	' Constructor
	
	Method New(texture:T)
		_texture = texture
	End

	' Core properties that exist on Mojo's Texture
	Method Size:Vec2i()
		Return _texture.Size
	End
	
	Method Width:Int()
		Return _texture.Width
	End
	
	Method Height:Int()
		Return _texture.Height
	End
	
	Method Format:PixelFormat()
		Return _texture.Format
	End
	
	Method Flags:TextureFlags()
		Return _texture.Flags
	End
	
	' Core operations that exist on Mojo's Texture
	Method PastePixmap:Void(pixmap:Pixmap, x:Int, y:Int)
		_texture.PastePixmap(pixmap, x, y)
	End
	
	Method Load:Bool(path:String)
		Return _texture.Load(path)
	End
	
	Method ColorTexture:Void(color:Color)
		_texture.ColorTexture(color)
	End
	
	Method Modified:Void(r:Recti)
		_texture.Modified(r)
	End
	
	Method Bind:Void(unit:Int)
		_texture.Bind(unit)
	End
	
	Method ValidateGLTexture:Bool()
		Return _texture.ValidateGLTexture()
	End
	
	' Direct access to underlying texture
	Property Texture:T()
		Return _texture
	End

	Protected 
	
	Field _texture:T
End
