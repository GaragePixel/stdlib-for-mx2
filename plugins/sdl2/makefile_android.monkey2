
Namespace stdlib.plugins.sdl2

#Import "<libdl.a>"

#Import "SDL/src/main/android/SDL_android_main.c"

'audio
#Import "SDL/src/audio/SDL_audio.c"
#Import "SDL/src/audio/SDL_audiocvt.c"
#Import "SDL/src/audio/SDL_audiodev.c"
#Import "SDL/src/audio/SDL_audiotypecvt.c"
#Import "SDL/src/audio/SDL_mixer.c"
#Import "SDL/src/audio/SDL_wave.c"
#Import "SDL/src/audio/android/SDL_androidaudio.c"
#Import "SDL/src/audio/dummy/SDL_dummyaudio.c"

'atomic
#Import "SDL/src/atomic/SDL_atomic.c"
#Import "SDL/src/atomic/SDL_spinlock.c"

'core
#Import "SDL/src/core/android/SDL_android.c"

'cpuinfo
#Import "SDL/src/cpuinfo/SDL_cpuinfo.c"

'dynapi
#Import "SDL/src/dynapi/SDL_dynapi.c"

'events
#Import "SDL/src/events/SDL_clipboardevents.c"
#Import "SDL/src/events/SDL_dropevents.c"
#Import "SDL/src/events/SDL_events.c"
#Import "SDL/src/events/SDL_gesture.c"
#Import "SDL/src/events/SDL_keyboard.c"
#Import "SDL/src/events/SDL_mouse.c"
#Import "SDL/src/events/SDL_quit.c"
#Import "SDL/src/events/SDL_touch.c"
#Import "SDL/src/events/SDL_windowevents.c"

'file
#Import "SDL/src/file/SDL_rwops.c"

'filesystem
#Import "SDL/src/filesystem/android/SDL_sysfilesystem.c"

'haptic
#Import "SDL/src/haptic/SDL_haptic.c"
#Import "SDL/src/haptic/dummy/SDL_syshaptic.c"

'joystick
#Import "SDL/src/joystick/SDL_gamecontroller.c"
#Import "SDL/src/joystick/SDL_joystick.c"
#Import "SDL/src/joystick/android/SDL_sysjoystick.c"

'loadso
#Import "SDL/src/loadso/dlopen/SDL_sysloadso.c"

'power
#Import "SDL/src/power/SDL_power.c"
#Import "SDL/src/power/android/SDL_syspower.c"

'render - have to include software render?
#Import "SDL/src/render/SDL_yuv_sw.c"
#Import "SDL/src/render/SDL_render.c"

#Import "SDL/src/render/software/SDL_blendfillrect.c"
#Import "SDL/src/render/software/SDL_blendline.c"
#Import "SDL/src/render/software/SDL_blendpoint.c"
#Import "SDL/src/render/software/SDL_drawline.c"
#Import "SDL/src/render/software/SDL_drawpoint.c"
#Import "SDL/src/render/software/SDL_render_sw.c"
#Import "SDL/src/render/software/SDL_rotate.c"

'stdlib
#Import "SDL/src/stdlib/SDL_getenv.c"
#Import "SDL/src/stdlib/SDL_iconv.c"
#Import "SDL/src/stdlib/SDL_malloc.c"
#Import "SDL/src/stdlib/SDL_qsort.c"
#Import "SDL/src/stdlib/SDL_stdlib.c"
#Import "SDL/src/stdlib/SDL_string.c"

'thread
#Import "SDL/src/thread/SDL_thread.c"
#Import "SDL/src/thread/pthread/SDL_syscond.c"
#Import "SDL/src/thread/pthread/SDL_sysmutex.c"
#Import "SDL/src/thread/pthread/SDL_syssem.c"
#Import "SDL/src/thread/pthread/SDL_systhread.c"
#Import "SDL/src/thread/pthread/SDL_systls.c"

'timer
#Import "SDL/src/timer/SDL_timer.c"
#Import "SDL/src/timer/unix/SDL_systimer.c"

'video
#Import "SDL/src/video/SDL_blit.c"
#Import "SDL/src/video/SDL_blit_0.c"
#Import "SDL/src/video/SDL_blit_1.c"
#Import "SDL/src/video/SDL_blit_A.c"
#Import "SDL/src/video/SDL_blit_auto.c"
#Import "SDL/src/video/SDL_blit_copy.c"
#Import "SDL/src/video/SDL_blit_N.c"
#Import "SDL/src/video/SDL_blit_slow.c"
#Import "SDL/src/video/SDL_bmp.c"
#Import "SDL/src/video/SDL_clipboard.c"
#Import "SDL/src/video/SDL_egl.c"
#Import "SDL/src/video/SDL_fillrect.c"
#Import "SDL/src/video/SDL_pixels.c"
#Import "SDL/src/video/SDL_rect.c"
#Import "SDL/src/video/SDL_RLEaccel.c"
#Import "SDL/src/video/SDL_shape.c"
#Import "SDL/src/video/SDL_stretch.c"
#Import "SDL/src/video/SDL_surface.c"
#Import "SDL/src/video/SDL_video.c"

#Import "SDL/src/video/android/SDL_androidclipboard.c"
#Import "SDL/src/video/android/SDL_androidevents.c"
#Import "SDL/src/video/android/SDL_androidgl.c"
#Import "SDL/src/video/android/SDL_androidkeyboard.c"
#Import "SDL/src/video/android/SDL_androidmessagebox.c"
#Import "SDL/src/video/android/SDL_androidmouse.c"
#Import "SDL/src/video/android/SDL_androidtouch.c"
#Import "SDL/src/video/android/SDL_androidvideo.c"
#Import "SDL/src/video/android/SDL_androidwindow.c"

'src
#Import "SDL/src/SDL_assert.c"
#Import "SDL/src/SDL_error.c"
#Import "SDL/src/SDL_hints.c"
#Import "SDL/src/SDL_log.c"
#Import "SDL/src/SDL.c"
