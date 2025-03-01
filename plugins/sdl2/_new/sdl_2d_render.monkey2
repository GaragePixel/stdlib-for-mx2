
Namespace stdlib.plugins.sdl2

#Import "native/sdl_2d_renderer_native_mx2.h"
#Import "native/sdl_2d_renderer_native_mx2.cpp"

Extern




'2d accelerated renderer
'Enumerations

	'   SDL_BlendFactor
	'   SDL_BlendOperation
Enum SDL_RendererFlags
End
Const SDL_RENDERER_SOFTWARE:SDL_RendererFlags
Const SDL_RENDERER_ACCELERATED:SDL_RendererFlags
Const SDL_RENDERER_PRESENTVSYNC:SDL_RendererFlags
Const SDL_RENDERER_TARGETTEXTURE:SDL_RendererFlags

Enum SDL_RendererFlip
End
Const SDL_FLIP_NONE:SDL_RendererFlip
Const SDL_FLIP_HORIZONTAL:SDL_RendererFlip
Const SDL_FLIP_VERTICAL:SDL_RendererFlip
	'   SDL_TextureAccess
	'   SDL_TextureModulate

'Structures

Struct SDL_Renderer
End
	'SDL_RendererInfo  'using via native?
Struct SDL_Texture
End

'Functions

'    SDL_ComposeCustomBlendMode
Function SDL_CreateRenderer:SDL_Renderer Ptr(window:SDL_Window Ptr,index:Int,flags:UInt)

'    SDL_CreateSoftwareRenderer
'    SDL_CreateTexture
'    SDL_CreateTextureFromSurface
'    SDL_CreateWindowAndRenderer
Function SDL_DestroyRenderer(renderer:SDL_Renderer Ptr)
Function SDL_DestroyTexture(texture:SDL_Texture Ptr)
'    SDL_GL_BindTexture
'    SDL_GL_UnbindTexture
'    SDL_GetNumRenderDrivers
'    SDL_GetRenderDrawBlendMode
'    SDL_GetRenderDrawColor
'    SDL_GetRenderDriverInfo
Function SDL_GetRenderTarget:SDL_Texture Ptr(renderer:SDL_Renderer Ptr)
'    SDL_GetRenderer
'    SDL_GetRendererInfo
'    SDL_GetRendererOutputSize
'    SDL_GetTextureAlphaMod
'    SDL_GetTextureBlendMode
'    SDL_GetTextureColorMod
'    SDL_LockTexture
'    SDL_QueryTexture
Function SDL_RenderClear(renderer:SDL_Renderer Ptr)
'    SDL_RenderCopy
'    SDL_RenderCopyEx
'    SDL_RenderDrawLine
'    SDL_RenderDrawLines
'    SDL_RenderDrawPoint
'    SDL_RenderDrawPoints
'    SDL_RenderDrawRect
'    SDL_RenderDrawRects
Function SDL_RenderFillRect(renderer:SDL_Renderer Ptr,rect:SDL_Rect Ptr)
'    SDL_RenderFillRects
'    SDL_RenderGetClipRect
'    SDL_RenderGetIntegerScale
'    SDL_RenderGetLogicalSize
'    SDL_RenderGetScale
'    SDL_RenderGetViewport
'    SDL_RenderIsClipEnabled
Function SDL_RenderPresent (renderer : SDL_Renderer Ptr)
'    SDL_RenderReadPixels
'    SDL_RenderSetClipRect
'    SDL_RenderSetIntegerScale
'    SDL_RenderSetLogicalSize
'    SDL_RenderSetScale
'    SDL_RenderSetViewport
'    SDL_RenderTargetSupported
'    SDL_SetRenderDrawBlendMode
Function SDL_SetRenderDrawColor (renderer:SDL_Renderer Ptr,r:UByte,g:UByte,b:UByte,a:UByte)
Function SDL_SetRenderTarget (renderer:SDL_Renderer Ptr,texture:SDL_Texture Ptr)
'    SDL_SetTextureAlphaMod
'    SDL_SetTextureBlendMode
'    SDL_SetTextureColorMod
'    SDL_UnlockTexture
'    SDL_UpdateTexture
'    SDL_UpdateYUVTexture

'extra via native
Function PrintRendererInfo(SDL_Renderer Ptr)
Function SetHintRenderDriverMetal()
Function SetHintRenderDriverOpenGL()
Function SetHintRenderDriverOpenGLES2()

' trucs du premier tuto mais utilise pas ? le 2d accelerated renderer
Struct SDL_Surface
	Field flags:UInt				'/**< Read-only */
	Field format:SDL_PixelFormat Ptr	'/**< Read-only */
	Field w:Int
	Field h:Int				'/**< Read-only */
	Field pitch:Int					'/**< Read-only */
	Field pixels:Void Ptr				'/**< Read-write */
	
	'/** Application data associated with the surface */
	Field userdata:Void Ptr				'/**< Read-write */
	
	'/** information needed for surfaces requiring locks */
	Field locked:Int				'/**< Read-only */
	Field lock_data:Void Ptr			'/**< Read-only */
	
	'/** clipping information */
	Field clip_rect:SDL_Rect			'/**< Read-only */
	
	'/** info for fast blit mapping to other surfaces */
	'Field map:SDL_BlitMap Ptr    '/**< Private */
	
	'/** Reference count -- used when freeing surface */
	'Field refcount:Int
End

Function SDL_FreeSurface(surface:SDL_Surface Ptr)

Enum SDL_TextureAccess
End
Const SDL_TEXTUREACCESS_STREAMING:SDL_TextureAccess
Const SDL_TEXTUREACCESS_TARGET:SDL_TextureAccess
Const SDL_TEXTUREACCESS_STATIC:SDL_TextureAccess

Function SDL_CreateTextureFromSurface:SDL_Texture Ptr(renderer:SDL_Renderer Ptr,surface:SDL_Surface Ptr)


Function SDL_RenderCopy:Int(renderer:SDL_Renderer Ptr,texture:SDL_Texture Ptr,srcrect:SDL_Rect Ptr,dstrect:SDL_Rect Ptr)
Function SDL_RenderCopyEx:Int(renderer:SDL_Renderer Ptr,texture:SDL_Texture Ptr,srcrect:SDL_Rect Ptr,dstrect:SDL_Rect Ptr,angle:Double,center:SDL_Point Ptr,flip:SDL_RendererFlip)




Struct SDL_PixelFormat

	Field format:UInt
	'Field palette SDL_Palette Ptr
	'Field UByte BitsPerPixel
	'Field UByte BytesPerPixel
	'Field UByte padding[2]
	'Field UInt Rmask
	'Field UInt Gmask
	'Field UInt Bmask
	'Field UInt Amask
End
Const SDL_PIXELFORMAT_RGBA32:UInt

Function SDL_CreateRGBSurfaceWithFormatFrom:SDL_Surface Ptr(pixels:Void Ptr,width:Int,height:Int,depth:Int,pitch:Int,format:UInt)

Function SDL_MapRGB:UInt(format:SDL_PixelFormat Ptr,r:UByte,g:UByte,b:UByte)

Function SDL_FillRect:Int(dst:SDL_Surface Ptr, rect:SDL_Rect Ptr, color:UInt)


Public

