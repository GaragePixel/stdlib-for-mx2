//==============================================================
// Tablet API Header for Monkey2
// Implementation: iDkP from GaragePixel
// 2025-03-17 Aida 4
//==============================================================
// 
// The MIT License (MIT)
// 
// Copyright (c) 2025 iDkP from GaragePixel
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#ifndef _ASTABLET_H_
#define _ASTABLET_H_

#ifdef __cplusplus
extern "C" {
#endif

#include "wintab.h"

// Core tablet functions
bool astablet_init(void);
void astablet_shutdown(void);
bool astablet_update(void);

// Tablet device functions
bool astablet_is_available(void);
int astablet_get_device_count(void);
const char* astablet_get_device_name(int deviceIndex);

// Tablet properties
float astablet_get_width(void);
float astablet_get_height(void);
float astablet_get_resolution(void);
int astablet_get_pressure_levels(void);

// Input state
float astablet_get_x(void);
float astablet_get_y(void);
float astablet_get_pressure(void);
float astablet_get_tilt_x(void);
float astablet_get_tilt_y(void);
int astablet_get_button_state(int button);
bool astablet_is_eraser(void);

// Configuration
void astablet_set_mapping(float x, float y, float width, float height);
void astablet_set_pressure_curve(float a, float b, float c, float d);

#ifdef __cplusplus
}
#endif

#endif