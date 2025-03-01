#include "sdl_2d_renderer_native_mx2.h"
#include <iostream>
#include <SDL.h>

void PrintRendererInfo(SDL_Renderer * renderer){
	SDL_RendererInfo rendererInfo;
	SDL_GetRendererInfo(renderer, &rendererInfo);
	std::cout<<"SDL2 Renderer: "<<rendererInfo.name<< std::endl;
}

void SetHintRenderDriverMetal(){
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "metal");
}
void SetHintRenderDriverOpenGL(){
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengl");
}
void SetHintRenderDriverOpenGLES2(){
	SDL_SetHint(SDL_HINT_RENDER_DRIVER, "opengles2");
}
