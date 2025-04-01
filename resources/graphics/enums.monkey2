
Namespace stdlib.graphics

Enum ResolutionMode
	Stretch       ' Stretch to fill entire target (may distort)
	Fit           ' Fit within target maintaining aspect ratio
	Fill          ' Fill target maintaining aspect ratio (may crop)
	PixelPerfect  ' Integer scaling only for pixel art
End

Enum TextureFlags
	None=			$0000
	WrapS=			$0001
	WrapT=			$0002
	Filter=			$0004
	Mipmap=			$0008
	
	Dynamic=		$0100
	Cubemap=		$0200
	Envmap=			$0400
	
	WrapST=			WrapS|WrapT
	FilterMipmap=	Filter|Mipmap
End
