#include <SDL.h>

#ifndef SDL_2D_RENDERER_NATIVE_MX2_H
#define SDL_2D_RENDERER_NATIVE_MX2_H

void PrintRendererInfo(SDL_Renderer * renderer);

void SetHintRenderDriverMetal();
void SetHintRenderDriverOpenGL();
void SetHintRenderDriverOpenGLES2();

#endif