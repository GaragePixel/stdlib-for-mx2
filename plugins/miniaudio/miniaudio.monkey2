
Namespace stdlib.plugins.miniaudio

'iDkP from GaragePixel (2025-02-22):
'
'	miniaudio was included in stdlib because it has no dependency.
'	It's an 'one-file' library wrote by David Reid in 2021 for wx (official mx2 fork)
'	and one of the rare external library to be wrapped for the project by its own author.
'
'	To tell...
'	sdklib.medias.minivideoplayer is a similar library but it cannot be integrated because,
'	actually, it uses sdklib.medias.theoraplayer and sdklib_mojo.mojo.
'	The police of the stdlib, as a very standard library, is "zero dependency".
'	I can say that miniaudio was a big gift to the wx communauty and the code
'	was finally easly back translated to mx2.

#if __TARGET__ = "raspbian" or __TARGET__ = "emscripten" or __TARGET__ = "ios" or __TARGET__ = "android"
	'Exclude targets
'#else

'#if __TARGET__ = "emscripten" or __TARGET__ = "ios" or __TARGET__ = "android"
	'Exclude targets
#else

#Import "../libc/libc"

#Import "native/miniaudio.h"

#if __TARGET__="macos"
	#Import "<CoreFoundation.framework>"
	#Import "<CoreAudio.framework>"
	#Import "<AudioUnit.framework>"
	#Import "<libpthread.a>"
	#Import "<libm.a>"
#elseif __TARGET__="linux"
	#Import "<libpthread.a>"
	#Import "<libm.a>"
	#Import "<libdl.a>"
#endif

#Import "native/miniaudio.c"

Extern

'additional
Struct ConstVoid="const void"
End

'***** File: miniaudio.h *****

Const MA_VERSION_MAJOR:int
Const MA_VERSION_MINOR:int
Const MA_VERSION_REVISION:int
Const MA_VERSION_STRING:CString

Const MA_LOG_LEVEL_VERBOSE:int
Const MA_LOG_LEVEL_INFO:int
Const MA_LOG_LEVEL_WARNING:int
Const MA_LOG_LEVEL_ERROR:int

Const MA_LOG_LEVEL:Int

Alias ma_channel:ma_uint8
Const MA_CHANNEL_NONE:int
Const MA_CHANNEL_MONO:int
Const MA_CHANNEL_FRONT_LEFT:int
Const MA_CHANNEL_FRONT_RIGHT:int
Const MA_CHANNEL_FRONT_CENTER:int
Const MA_CHANNEL_LFE:int
Const MA_CHANNEL_BACK_LEFT:int
Const MA_CHANNEL_BACK_RIGHT:int
Const MA_CHANNEL_FRONT_LEFT_CENTER:int
Const MA_CHANNEL_FRONT_RIGHT_CENTER:int
Const MA_CHANNEL_BACK_CENTER:int
Const MA_CHANNEL_SIDE_LEFT:int
Const MA_CHANNEL_SIDE_RIGHT:int
Const MA_CHANNEL_TOP_CENTER:int
Const MA_CHANNEL_TOP_FRONT_LEFT:int
Const MA_CHANNEL_TOP_FRONT_CENTER:int
Const MA_CHANNEL_TOP_FRONT_RIGHT:int
Const MA_CHANNEL_TOP_BACK_LEFT:int
Const MA_CHANNEL_TOP_BACK_CENTER:int
Const MA_CHANNEL_TOP_BACK_RIGHT:int
Const MA_CHANNEL_AUX_0:int
Const MA_CHANNEL_AUX_1:int
Const MA_CHANNEL_AUX_2:int
Const MA_CHANNEL_AUX_3:int
Const MA_CHANNEL_AUX_4:int
Const MA_CHANNEL_AUX_5:int
Const MA_CHANNEL_AUX_6:int
Const MA_CHANNEL_AUX_7:int
Const MA_CHANNEL_AUX_8:int
Const MA_CHANNEL_AUX_9:int
Const MA_CHANNEL_AUX_10:int
Const MA_CHANNEL_AUX_11:int
Const MA_CHANNEL_AUX_12:int
Const MA_CHANNEL_AUX_13:int
Const MA_CHANNEL_AUX_14:int
Const MA_CHANNEL_AUX_15:int
Const MA_CHANNEL_AUX_16:int
Const MA_CHANNEL_AUX_17:int
Const MA_CHANNEL_AUX_18:int
Const MA_CHANNEL_AUX_19:int
Const MA_CHANNEL_AUX_20:int
Const MA_CHANNEL_AUX_21:int
Const MA_CHANNEL_AUX_22:int
Const MA_CHANNEL_AUX_23:int
Const MA_CHANNEL_AUX_24:int
Const MA_CHANNEL_AUX_25:int
Const MA_CHANNEL_AUX_26:int
Const MA_CHANNEL_AUX_27:int
Const MA_CHANNEL_AUX_28:int
Const MA_CHANNEL_AUX_29:int
Const MA_CHANNEL_AUX_30:int
Const MA_CHANNEL_AUX_31:int
Const MA_CHANNEL_LEFT:int
Const MA_CHANNEL_RIGHT:int
Const MA_CHANNEL_POSITION_COUNT:int

Alias ma_result:Int
Const MA_SUCCESS:int
Const MA_ERROR:int
Const MA_INVALID_ARGS:int
Const MA_INVALID_OPERATION:int
Const MA_OUT_OF_MEMORY:int
Const MA_OUT_OF_RANGE:int
Const MA_ACCESS_DENIED:int
Const MA_DOES_NOT_EXIST:int
Const MA_ALREADY_EXISTS:int
Const MA_TOO_MANY_OPEN_FILES:int
Const MA_INVALID_FILE:int
Const MA_TOO_BIG:int
Const MA_PATH_TOO_LONG:int
Const MA_NAME_TOO_LONG:int
Const MA_NOT_DIRECTORY:int
Const MA_IS_DIRECTORY:int
Const MA_DIRECTORY_NOT_EMPTY:int
Const MA_END_OF_FILE:int
Const MA_NO_SPACE:int
Const MA_BUSY:int
Const MA_IO_ERROR:int
Const MA_INTERRUPT:int
Const MA_UNAVAILABLE:int
Const MA_ALREADY_IN_USE:int
Const MA_BAD_ADDRESS:int
Const MA_BAD_SEEK:int
Const MA_BAD_PIPE:int
Const MA_DEADLOCK:int
Const MA_TOO_MANY_LINKS:int
Const MA_NOT_IMPLEMENTED:int
Const MA_NO_MESSAGE:int
Const MA_BAD_MESSAGE:int
Const MA_NO_DATA_AVAILABLE:int
Const MA_INVALID_DATA:int
Const MA_TIMEOUT:int
Const MA_NO_NETWORK:int
Const MA_NOT_UNIQUE:int
Const MA_NOT_SOCKET:int
Const MA_NO_ADDRESS:int
Const MA_BAD_PROTOCOL:int
Const MA_PROTOCOL_UNAVAILABLE:int
Const MA_PROTOCOL_NOT_SUPPORTED:int
Const MA_PROTOCOL_FAMILY_NOT_SUPPORTED:int
Const MA_ADDRESS_FAMILY_NOT_SUPPORTED:int
Const MA_SOCKET_NOT_SUPPORTED:int
Const MA_CONNECTION_RESET:int
Const MA_ALREADY_CONNECTED:int
Const MA_NOT_CONNECTED:int
Const MA_CONNECTION_REFUSED:int
Const MA_NO_HOST:int
Const MA_IN_PROGRESS:int
Const MA_CANCELLED:int
Const MA_MEMORY_ALREADY_MAPPED:int
Const MA_AT_END:int

'/* General miniaudio-specific errors. */
Const MA_FORMAT_NOT_SUPPORTED:int
Const MA_DEVICE_TYPE_NOT_SUPPORTED:int
Const MA_SHARE_MODE_NOT_SUPPORTED:int
Const MA_NO_BACKEND:int
Const MA_NO_DEVICE:int
Const MA_API_NOT_FOUND:int
Const MA_INVALID_DEVICE_CONFIG:int
Const MA_LOOP:int

'/* State errors. */
Const MA_DEVICE_NOT_INITIALIZED:int
Const MA_DEVICE_ALREADY_INITIALIZED:int
Const MA_DEVICE_NOT_STARTED:int
Const MA_DEVICE_NOT_STOPPED:int

'/* Operation errors. */
Const MA_FAILED_TO_INIT_BACKEND:int
Const MA_FAILED_TO_OPEN_BACKEND_DEVICE:int
Const MA_FAILED_TO_START_BACKEND_DEVICE:int
Const MA_FAILED_TO_STOP_BACKEND_DEVICE:int

Const MA_MIN_CHANNELS:int
Const MA_MAX_CHANNELS:int

Const MA_MAX_FILTER_ORDER:int

Alias ma_int8:Byte
Alias ma_uint8:UByte
Alias ma_int16:Short
Alias ma_uint16:UShort
Alias ma_int32:Int
Alias ma_uint32:UInt
Alias ma_int64:Long
Alias ma_uint64:ULong
Alias ma_uintptr:ma_uint32
Alias ma_bool8:ma_uint8
Alias ma_bool32:ma_uint32
Const MA_TRUE:int
Const MA_FALSE:int
Alias ma_handle:Void Ptr
Alias ma_ptr:Void Ptr
Alias ma_proc:Void(	)
Alias wchar_t:ma_uint16

Enum ma_stream_format
End
Const ma_stream_format_pcm:ma_stream_format
Enum ma_stream_layout
End
Const ma_stream_layout_interleaved:ma_stream_layout
Const ma_stream_layout_deinterleaved:ma_stream_layout
Enum ma_dither_mode
End
Const ma_dither_mode_none:ma_dither_mode
Const ma_dither_mode_rectangle:ma_dither_mode
Const ma_dither_mode_triangle:ma_dither_mode
Enum ma_format
End
Const ma_format_unknown:ma_format
Const ma_format_u8:ma_format
Const ma_format_s16:ma_format
Const ma_format_s24:ma_format
Const ma_format_s32:ma_format
Const ma_format_f32:ma_format
Const ma_format_count:ma_format
Enum ma_standard_sample_rate
End
Const ma_standard_sample_rate_48000:ma_standard_sample_rate
Const ma_standard_sample_rate_44100:ma_standard_sample_rate
Const ma_standard_sample_rate_32000:ma_standard_sample_rate
Const ma_standard_sample_rate_24000:ma_standard_sample_rate
Const ma_standard_sample_rate_22050:ma_standard_sample_rate
Const ma_standard_sample_rate_88200:ma_standard_sample_rate
Const ma_standard_sample_rate_96000:ma_standard_sample_rate
Const ma_standard_sample_rate_176400:ma_standard_sample_rate
Const ma_standard_sample_rate_192000:ma_standard_sample_rate
Const ma_standard_sample_rate_16000:ma_standard_sample_rate
Const ma_standard_sample_rate_11025:ma_standard_sample_rate
Const ma_standard_sample_rate_8000:ma_standard_sample_rate
Const ma_standard_sample_rate_352800:ma_standard_sample_rate
Const ma_standard_sample_rate_384000:ma_standard_sample_rate
Const ma_standard_sample_rate_min:ma_standard_sample_rate
Const ma_standard_sample_rate_max:ma_standard_sample_rate
Const ma_standard_sample_rate_count:ma_standard_sample_rate
Enum ma_channel_mix_mode
End
Const ma_channel_mix_mode_rectangular:ma_channel_mix_mode
Const ma_channel_mix_mode_simple:ma_channel_mix_mode
Const ma_channel_mix_mode_custom_weights:ma_channel_mix_mode
Const ma_channel_mix_mode_planar_blend:ma_channel_mix_mode
Const ma_channel_mix_mode_default:ma_channel_mix_mode
Enum ma_standard_channel_map
End
Const ma_standard_channel_map_microsoft:ma_standard_channel_map
Const ma_standard_channel_map_alsa:ma_standard_channel_map
Const ma_standard_channel_map_rfc3551:ma_standard_channel_map
Const ma_standard_channel_map_flac:ma_standard_channel_map
Const ma_standard_channel_map_vorbis:ma_standard_channel_map
Const ma_standard_channel_map_sound4:ma_standard_channel_map
Const ma_standard_channel_map_sndio:ma_standard_channel_map
Const ma_standard_channel_map_webaudio:ma_standard_channel_map
Const ma_standard_channel_map_default:ma_standard_channel_map
Enum ma_performance_profile
End
Const ma_performance_profile_low_latency:ma_performance_profile
Const ma_performance_profile_conservative:ma_performance_profile
Struct ma_allocation_callbacks
	Field pUserData:Void Ptr
	Field onMalloc:Void Ptr( stdlib.plugins.libc.size_t, Void Ptr )
	Field onRealloc:Void Ptr( Void Ptr, stdlib.plugins.libc.size_t, Void Ptr )
	Field onFree:Void( Void Ptr, Void Ptr )
End
Struct ma_lcg
	Field state:ma_int32
End
Enum ma_thread_priority
End
Const ma_thread_priority_idle:ma_thread_priority
Const ma_thread_priority_lowest:ma_thread_priority
Const ma_thread_priority_low:ma_thread_priority
Const ma_thread_priority_normal:ma_thread_priority
Const ma_thread_priority_high:ma_thread_priority
Const ma_thread_priority_highest:ma_thread_priority
Const ma_thread_priority_realtime:ma_thread_priority
Const ma_thread_priority_default:ma_thread_priority
Alias ma_spinlock:ma_uint32
Alias ma_thread:ma_handle
Alias ma_mutex:ma_handle
Alias ma_event:ma_handle
Alias ma_semaphore:ma_handle
Function ma_version:Void( pMajor:ma_uint32 Ptr, pMinor:ma_uint32 Ptr, pRevision:ma_uint32 Ptr )
Function ma_version_string:CString(	)
Struct ma_biquad_coefficient
	field f32:float
	field s32:ma_int32
End
Struct ma_biquad_config
	Field format:ma_format
	Field channels:ma_uint32
	Field b0:Double
	Field b1:Double
	Field b2:Double
	Field a0:Double
	Field a1:Double
	Field a2:Double
End
Function ma_biquad_config_init:ma_biquad_config( format:ma_format, channels:ma_uint32, b0:Double, b1:Double, b2:Double, a0:Double, a1:Double, a2:Double )
Struct ma_biquad
	Field format:ma_format
	Field channels:ma_uint32
	Field b0:ma_biquad_coefficient
	Field b1:ma_biquad_coefficient
	Field b2:ma_biquad_coefficient
	Field a1:ma_biquad_coefficient
	Field a2:ma_biquad_coefficient
	Field r1:ma_biquad_coefficient Ptr
	Field r2:ma_biquad_coefficient Ptr
End
Function ma_biquad_init:ma_result( pConfig:ma_biquad_config Ptr, pBQ:ma_biquad Ptr )
Function ma_biquad_reinit:ma_result( pConfig:ma_biquad_config Ptr, pBQ:ma_biquad Ptr )
Function ma_biquad_process_pcm_frames:ma_result( pBQ:ma_biquad Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_biquad_get_latency:ma_uint32( pBQ:ma_biquad Ptr )
Struct ma_lpf1_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field q:Double
End
Alias ma_lpf2_config:ma_lpf1_config
Function ma_lpf1_config_init:ma_lpf1_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double )
Function ma_lpf2_config_init:ma_lpf2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, q:Double )
Struct ma_lpf1
	Field format:ma_format
	Field channels:ma_uint32
	Field a:ma_biquad_coefficient
	Field r1:ma_biquad_coefficient Ptr
End
Function ma_lpf1_init:ma_result( pConfig:ma_lpf1_config Ptr, pLPF:ma_lpf1 Ptr )
Function ma_lpf1_reinit:ma_result( pConfig:ma_lpf1_config Ptr, pLPF:ma_lpf1 Ptr )
Function ma_lpf1_process_pcm_frames:ma_result( pLPF:ma_lpf1 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_lpf1_get_latency:ma_uint32( pLPF:ma_lpf1 Ptr )
Struct ma_lpf2
	Field bq:ma_biquad
End
Function ma_lpf2_init:ma_result( pConfig:ma_lpf2_config Ptr, pLPF:ma_lpf2 Ptr )
Function ma_lpf2_reinit:ma_result( pConfig:ma_lpf2_config Ptr, pLPF:ma_lpf2 Ptr )
Function ma_lpf2_process_pcm_frames:ma_result( pLPF:ma_lpf2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_lpf2_get_latency:ma_uint32( pLPF:ma_lpf2 Ptr )
Struct ma_lpf_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field order:ma_uint32
End
Function ma_lpf_config_init:ma_lpf_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, order:ma_uint32 )
Struct ma_lpf
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field lpf1Count:ma_uint32
	Field lpf2Count:ma_uint32
	Field lpf1:ma_lpf1 Ptr
	Field lpf2:ma_lpf2 Ptr
End
Function ma_lpf_init:ma_result( pConfig:ma_lpf_config Ptr, pLPF:ma_lpf Ptr )
Function ma_lpf_reinit:ma_result( pConfig:ma_lpf_config Ptr, pLPF:ma_lpf Ptr )
Function ma_lpf_process_pcm_frames:ma_result( pLPF:ma_lpf Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_lpf_get_latency:ma_uint32( pLPF:ma_lpf Ptr )
Struct ma_hpf1_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field q:Double
End
Alias ma_hpf2_config:ma_hpf1_config
Function ma_hpf1_config_init:ma_hpf1_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double )
Function ma_hpf2_config_init:ma_hpf2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, q:Double )
Struct ma_hpf1
	Field format:ma_format
	Field channels:ma_uint32
	Field a:ma_biquad_coefficient
	Field r1:ma_biquad_coefficient Ptr
End
Function ma_hpf1_init:ma_result( pConfig:ma_hpf1_config Ptr, pHPF:ma_hpf1 Ptr )
Function ma_hpf1_reinit:ma_result( pConfig:ma_hpf1_config Ptr, pHPF:ma_hpf1 Ptr )
Function ma_hpf1_process_pcm_frames:ma_result( pHPF:ma_hpf1 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_hpf1_get_latency:ma_uint32( pHPF:ma_hpf1 Ptr )
Struct ma_hpf2
	Field bq:ma_biquad
End
Function ma_hpf2_init:ma_result( pConfig:ma_hpf2_config Ptr, pHPF:ma_hpf2 Ptr )
Function ma_hpf2_reinit:ma_result( pConfig:ma_hpf2_config Ptr, pHPF:ma_hpf2 Ptr )
Function ma_hpf2_process_pcm_frames:ma_result( pHPF:ma_hpf2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_hpf2_get_latency:ma_uint32( pHPF:ma_hpf2 Ptr )
Struct ma_hpf_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field order:ma_uint32
End
Function ma_hpf_config_init:ma_hpf_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, order:ma_uint32 )
Struct ma_hpf
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field hpf1Count:ma_uint32
	Field hpf2Count:ma_uint32
	Field hpf1:ma_hpf1 Ptr
	Field hpf2:ma_hpf2 Ptr
End
Function ma_hpf_init:ma_result( pConfig:ma_hpf_config Ptr, pHPF:ma_hpf Ptr )
Function ma_hpf_reinit:ma_result( pConfig:ma_hpf_config Ptr, pHPF:ma_hpf Ptr )
Function ma_hpf_process_pcm_frames:ma_result( pHPF:ma_hpf Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_hpf_get_latency:ma_uint32( pHPF:ma_hpf Ptr )
Struct ma_bpf2_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field q:Double
End
Function ma_bpf2_config_init:ma_bpf2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, q:Double )
Struct ma_bpf2
	Field bq:ma_biquad
End
Function ma_bpf2_init:ma_result( pConfig:ma_bpf2_config Ptr, pBPF:ma_bpf2 Ptr )
Function ma_bpf2_reinit:ma_result( pConfig:ma_bpf2_config Ptr, pBPF:ma_bpf2 Ptr )
Function ma_bpf2_process_pcm_frames:ma_result( pBPF:ma_bpf2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_bpf2_get_latency:ma_uint32( pBPF:ma_bpf2 Ptr )
Struct ma_bpf_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field cutoffFrequency:Double
	Field order:ma_uint32
End
Function ma_bpf_config_init:ma_bpf_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, cutoffFrequency:Double, order:ma_uint32 )
Struct ma_bpf
	Field format:ma_format
	Field channels:ma_uint32
	Field bpf2Count:ma_uint32
	Field bpf2:ma_bpf2 Ptr
End
Function ma_bpf_init:ma_result( pConfig:ma_bpf_config Ptr, pBPF:ma_bpf Ptr )
Function ma_bpf_reinit:ma_result( pConfig:ma_bpf_config Ptr, pBPF:ma_bpf Ptr )
Function ma_bpf_process_pcm_frames:ma_result( pBPF:ma_bpf Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_bpf_get_latency:ma_uint32( pBPF:ma_bpf Ptr )
Struct ma_notch2_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field q:Double
	Field frequency:Double
End
Function ma_notch2_config_init:ma_notch2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, q:Double, frequency:Double )
Struct ma_notch2
	Field bq:ma_biquad
End
Function ma_notch2_init:ma_result( pConfig:ma_notch2_config Ptr, pFilter:ma_notch2 Ptr )
Function ma_notch2_reinit:ma_result( pConfig:ma_notch2_config Ptr, pFilter:ma_notch2 Ptr )
Function ma_notch2_process_pcm_frames:ma_result( pFilter:ma_notch2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_notch2_get_latency:ma_uint32( pFilter:ma_notch2 Ptr )
Struct ma_peak2_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field gainDB:Double
	Field q:Double
	Field frequency:Double
End
Function ma_peak2_config_init:ma_peak2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, gainDB:Double, q:Double, frequency:Double )
Struct ma_peak2
	Field bq:ma_biquad
End
Function ma_peak2_init:ma_result( pConfig:ma_peak2_config Ptr, pFilter:ma_peak2 Ptr )
Function ma_peak2_reinit:ma_result( pConfig:ma_peak2_config Ptr, pFilter:ma_peak2 Ptr )
Function ma_peak2_process_pcm_frames:ma_result( pFilter:ma_peak2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_peak2_get_latency:ma_uint32( pFilter:ma_peak2 Ptr )
Struct ma_loshelf2_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field gainDB:Double
	Field shelfSlope:Double
	Field frequency:Double
End
Function ma_loshelf2_config_init:ma_loshelf2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, gainDB:Double, shelfSlope:Double, frequency:Double )
Struct ma_loshelf2
	Field bq:ma_biquad
End
Function ma_loshelf2_init:ma_result( pConfig:ma_loshelf2_config Ptr, pFilter:ma_loshelf2 Ptr )
Function ma_loshelf2_reinit:ma_result( pConfig:ma_loshelf2_config Ptr, pFilter:ma_loshelf2 Ptr )
Function ma_loshelf2_process_pcm_frames:ma_result( pFilter:ma_loshelf2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_loshelf2_get_latency:ma_uint32( pFilter:ma_loshelf2 Ptr )
Struct ma_hishelf2_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field gainDB:Double
	Field shelfSlope:Double
	Field frequency:Double
End
Function ma_hishelf2_config_init:ma_hishelf2_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, gainDB:Double, shelfSlope:Double, frequency:Double )
Struct ma_hishelf2
	Field bq:ma_biquad
End
Function ma_hishelf2_init:ma_result( pConfig:ma_hishelf2_config Ptr, pFilter:ma_hishelf2 Ptr )
Function ma_hishelf2_reinit:ma_result( pConfig:ma_hishelf2_config Ptr, pFilter:ma_hishelf2 Ptr )
Function ma_hishelf2_process_pcm_frames:ma_result( pFilter:ma_hishelf2 Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Function ma_hishelf2_get_latency:ma_uint32( pFilter:ma_hishelf2 Ptr )
Struct ma_linear_resampler_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRateIn:ma_uint32
	Field sampleRateOut:ma_uint32
	Field lpfOrder:ma_uint32
	Field lpfNyquistFactor:Double
End
Function ma_linear_resampler_config_init:ma_linear_resampler_config( format:ma_format, channels:ma_uint32, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32 )
Struct ma_linear_resampler__union
	Field f32:float ptr
	Field s16:ma_int32 ptr
End
Struct ma_linear_resampler
	Field config:ma_linear_resampler_config
	Field inAdvanceInt:ma_uint32
	Field inAdvanceFrac:ma_uint32
	Field inTimeInt:ma_uint32
	Field inTimeFrac:ma_uint32
	Field x0:ma_linear_resampler__union
	Field x1:ma_linear_resampler__union
	Field lpf:ma_lpf
End
Function ma_linear_resampler_init:ma_result( pConfig:ma_linear_resampler_config Ptr, pResampler:ma_linear_resampler Ptr )
Function ma_linear_resampler_uninit:Void( pResampler:ma_linear_resampler Ptr )
Function ma_linear_resampler_process_pcm_frames:ma_result( pResampler:ma_linear_resampler Ptr, pFramesIn:Void Ptr, pFrameCountIn:ma_uint64 Ptr, pFramesOut:Void Ptr, pFrameCountOut:ma_uint64 Ptr )
Function ma_linear_resampler_set_rate:ma_result( pResampler:ma_linear_resampler Ptr, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32 )
Function ma_linear_resampler_set_rate_ratio:ma_result( pResampler:ma_linear_resampler Ptr, ratioInOut:Float )
Function ma_linear_resampler_get_required_input_frame_count:ma_uint64( pResampler:ma_linear_resampler Ptr, outputFrameCount:ma_uint64 )
Function ma_linear_resampler_get_expected_output_frame_count:ma_uint64( pResampler:ma_linear_resampler Ptr, inputFrameCount:ma_uint64 )
Function ma_linear_resampler_get_input_latency:ma_uint64( pResampler:ma_linear_resampler Ptr )
Function ma_linear_resampler_get_output_latency:ma_uint64( pResampler:ma_linear_resampler Ptr )
Enum ma_resample_algorithm
End
Const ma_resample_algorithm_linear:ma_resample_algorithm
Const ma_resample_algorithm_speex:ma_resample_algorithm
Struct ma_resampler_config__linear
	Field lpfOrder:ma_uint32
	Field lpfNyquisFactor:Double
End
Struct ma_resampler_config__speex
	Field quality:int
End
Struct ma_resampler_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRateIn:ma_uint32
	Field sampleRateOut:ma_uint32
	Field algorithm:ma_resample_algorithm
	Field linear:ma_resampler_config__linear
	Field speex:ma_resampler_config__speex
End
Function ma_resampler_config_init:ma_resampler_config( format:ma_format, channels:ma_uint32, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32, algorithm:ma_resample_algorithm )
Struct ma_resampler_state__speex
	field pSpeexResamplerState:Void Ptr
End
Struct ma_resampler_state
	Field linear:ma_linear_resampler
	Field speex:ma_resampler_state__speex
End
Struct ma_resampler
	Field config:ma_resampler_config
End
Function ma_resampler_init:ma_result( pConfig:ma_resampler_config Ptr, pResampler:ma_resampler Ptr )
Function ma_resampler_uninit:Void( pResampler:ma_resampler Ptr )
Function ma_resampler_process_pcm_frames:ma_result( pResampler:ma_resampler Ptr, pFramesIn:Void Ptr, pFrameCountIn:ma_uint64 Ptr, pFramesOut:Void Ptr, pFrameCountOut:ma_uint64 Ptr )
Function ma_resampler_set_rate:ma_result( pResampler:ma_resampler Ptr, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32 )
Function ma_resampler_set_rate_ratio:ma_result( pResampler:ma_resampler Ptr, ratio:Float )
Function ma_resampler_get_required_input_frame_count:ma_uint64( pResampler:ma_resampler Ptr, outputFrameCount:ma_uint64 )
Function ma_resampler_get_expected_output_frame_count:ma_uint64( pResampler:ma_resampler Ptr, inputFrameCount:ma_uint64 )
Function ma_resampler_get_input_latency:ma_uint64( pResampler:ma_resampler Ptr )
Function ma_resampler_get_output_latency:ma_uint64( pResampler:ma_resampler Ptr )
Struct ma_channel_converter_config
	Field format:ma_format
	Field channelsIn:ma_uint32
	Field channelsOut:ma_uint32
	Field channelMapIn:ma_channel Ptr
	Field channelMapOut:ma_channel Ptr
	Field mixingMode:ma_channel_mix_mode
	Field weights:Float Ptr Ptr
End
Function ma_channel_converter_config_init:ma_channel_converter_config( format:ma_format, channelsIn:ma_uint32, pChannelMapIn:ma_channel Ptr, channelsOut:ma_uint32, pChannelMapOut:ma_channel Ptr, mixingMode:ma_channel_mix_mode )
Struct ma_channel_converter__weights
	Field f32:float ptr ptr '[][]
	Field s16:ma_int32 ptr ptr '[][]
End
Struct ma_channel_converter
	Field format:ma_format
	Field channelsIn:ma_uint32
	Field channelsOut:ma_uint32
	Field channelMapIn:ma_channel Ptr
	Field channelMapOut:ma_channel Ptr
	Field mixingMode:ma_channel_mix_mode
	Field weights:ma_channel_converter__weights
	Field isPassthrough:ma_bool8
	Field isSimpleShuffle:ma_bool8
	Field isSimpleMonoExpansion:ma_bool8
	Field isStereoToMono:ma_bool8
	Field shuffleTable:ma_uint8 Ptr
End
Function ma_channel_converter_init:ma_result( pConfig:ma_channel_converter_config Ptr, pConverter:ma_channel_converter Ptr )
Function ma_channel_converter_uninit:Void( pConverter:ma_channel_converter Ptr )
Function ma_channel_converter_process_pcm_frames:ma_result( pConverter:ma_channel_converter Ptr, pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Struct ma_data_converter_config__resampling_linear
	Field lpfOrder:ma_uint32
	Field lpfNyquistFactor:ma_bool32
End
Struct ma_data_converter_config__resampling_speex
	Field quality:Int
End
Struct ma_data_converter_config__resampling
	Field algorithm:ma_resample_algorithm
	Field allowDynamicSampleRate:ma_bool32
	Field linear:ma_data_converter_config__resampling_linear
	Field speex:ma_data_converter_config__resampling_speex
End
Struct ma_data_converter_config
	Field formatIn:ma_format
	Field formatOut:ma_format
	Field channelsIn:ma_uint32
	Field channelsOut:ma_uint32
	Field sampleRateIn:ma_uint32
	Field sampleRateOut:ma_uint32
	Field channelMapIn:ma_channel Ptr
	Field channelMapOut:ma_channel Ptr
	Field ditherMode:ma_dither_mode
	Field channelMixMode:ma_channel_mix_mode
	Field channelWeights:Float Ptr Ptr
	Field resampling:ma_data_converter_config__resampling
End
Function ma_data_converter_config_init_default:ma_data_converter_config(	)
Function ma_data_converter_config_init:ma_data_converter_config( formatIn:ma_format, formatOut:ma_format, channelsIn:ma_uint32, channelsOut:ma_uint32, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32 )
Struct ma_data_converter
	Field config:ma_data_converter_config
	Field channelConverter:ma_channel_converter
	Field resampler:ma_resampler
	Field hasPreFormatConversion:ma_bool8
	Field hasPostFormatConversion:ma_bool8
	Field hasChannelConverter:ma_bool8
	Field hasResampler:ma_bool8
	Field isPassthrough:ma_bool8
End
Function ma_data_converter_init:ma_result( pConfig:ma_data_converter_config Ptr, pConverter:ma_data_converter Ptr )
Function ma_data_converter_uninit:Void( pConverter:ma_data_converter Ptr )
Function ma_data_converter_process_pcm_frames:ma_result( pConverter:ma_data_converter Ptr, pFramesIn:Void Ptr, pFrameCountIn:ma_uint64 Ptr, pFramesOut:Void Ptr, pFrameCountOut:ma_uint64 Ptr )
Function ma_data_converter_set_rate:ma_result( pConverter:ma_data_converter Ptr, sampleRateIn:ma_uint32, sampleRateOut:ma_uint32 )
Function ma_data_converter_set_rate_ratio:ma_result( pConverter:ma_data_converter Ptr, ratioInOut:Float )
Function ma_data_converter_get_required_input_frame_count:ma_uint64( pConverter:ma_data_converter Ptr, outputFrameCount:ma_uint64 )
Function ma_data_converter_get_expected_output_frame_count:ma_uint64( pConverter:ma_data_converter Ptr, inputFrameCount:ma_uint64 )
Function ma_data_converter_get_input_latency:ma_uint64( pConverter:ma_data_converter Ptr )
Function ma_data_converter_get_output_latency:ma_uint64( pConverter:ma_data_converter Ptr )
Function ma_pcm_u8_to_s16:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_u8_to_s24:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_u8_to_s32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_u8_to_f32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s16_to_u8:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s16_to_s24:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s16_to_s32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s16_to_f32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s24_to_u8:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s24_to_s16:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s24_to_s32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s24_to_f32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s32_to_u8:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s32_to_s16:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s32_to_s24:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_s32_to_f32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_f32_to_u8:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_f32_to_s16:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_f32_to_s24:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_f32_to_s32:Void( pOut:Void Ptr, pIn:Void Ptr, count:ma_uint64, ditherMode:ma_dither_mode )
Function ma_pcm_convert:Void( pOut:Void Ptr, formatOut:ma_format, pIn:Void Ptr, formatIn:ma_format, sampleCount:ma_uint64, ditherMode:ma_dither_mode )
Function ma_convert_pcm_frames_format:Void( pOut:Void Ptr, formatOut:ma_format, pIn:Void Ptr, formatIn:ma_format, frameCount:ma_uint64, channels:ma_uint32, ditherMode:ma_dither_mode )
Function ma_deinterleave_pcm_frames:Void( format:ma_format, channels:ma_uint32, frameCount:ma_uint64, pInterleavedPCMFrames:Void Ptr, ppDeinterleavedPCMFrames:Void Ptr Ptr )
Function ma_interleave_pcm_frames:Void( format:ma_format, channels:ma_uint32, frameCount:ma_uint64, ppDeinterleavedPCMFrames:Void Ptr Ptr, pInterleavedPCMFrames:Void Ptr )
Function ma_channel_map_init_blank:Void( channels:ma_uint32, pChannelMap:ma_channel Ptr )
Function ma_get_standard_channel_map:Void( standardChannelMap:ma_standard_channel_map, channels:ma_uint32, pChannelMap:ma_channel Ptr )
Function ma_channel_map_copy:Void( pOut:ma_channel Ptr, pIn:ma_channel Ptr, channels:ma_uint32 )
Function ma_channel_map_copy_or_default:Void( pOut:ma_channel Ptr, pIn:ma_channel Ptr, channels:ma_uint32 )
Function ma_channel_map_valid:ma_bool32( channels:ma_uint32, pChannelMap:ma_channel Ptr )
Function ma_channel_map_equal:ma_bool32( channels:ma_uint32, pChannelMapA:ma_channel Ptr, pChannelMapB:ma_channel Ptr )
Function ma_channel_map_blank:ma_bool32( channels:ma_uint32, pChannelMap:ma_channel Ptr )
Function ma_channel_map_contains_channel_position:ma_bool32( channels:ma_uint32, pChannelMap:ma_channel Ptr, channelPosition:ma_channel )
Function ma_convert_frames:ma_uint64( pOut:Void Ptr, frameCountOut:ma_uint64, formatOut:ma_format, channelsOut:ma_uint32, sampleRateOut:ma_uint32, pIn:Void Ptr, frameCountIn:ma_uint64, formatIn:ma_format, channelsIn:ma_uint32, sampleRateIn:ma_uint32 )
Function ma_convert_frames_ex:ma_uint64( pOut:Void Ptr, frameCountOut:ma_uint64, pIn:Void Ptr, frameCountIn:ma_uint64, pConfig:ma_data_converter_config Ptr )
Struct ma_rb
	Field pBuffer:Void Ptr
	Field subbufferSizeInBytes:ma_uint32
	Field subbufferCount:ma_uint32
	Field subbufferStrideInBytes:ma_uint32
	Field encodedReadOffset:ma_uint32
	Field encodedWriteOffset:ma_uint32
	Field ownsBuffer:ma_bool8
	Field clearOnWriteAcquire:ma_bool8
	Field allocationCallbacks:ma_allocation_callbacks
End
Function ma_rb_init_ex:ma_result( subbufferSizeInBytes:stdlib.plugins.libc.size_t, subbufferCount:stdlib.plugins.libc.size_t, subbufferStrideInBytes:stdlib.plugins.libc.size_t, pOptionalPreallocatedBuffer:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr, pRB:ma_rb Ptr )
Function ma_rb_init:ma_result( bufferSizeInBytes:stdlib.plugins.libc.size_t, pOptionalPreallocatedBuffer:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr, pRB:ma_rb Ptr )
Function ma_rb_uninit:Void( pRB:ma_rb Ptr )
Function ma_rb_reset:Void( pRB:ma_rb Ptr )
Function ma_rb_acquire_read:ma_result( pRB:ma_rb Ptr, pSizeInBytes:stdlib.plugins.libc.size_t Ptr, ppBufferOut:Void Ptr Ptr )
Function ma_rb_commit_read:ma_result( pRB:ma_rb Ptr, sizeInBytes:stdlib.plugins.libc.size_t, pBufferOut:Void Ptr )
Function ma_rb_acquire_write:ma_result( pRB:ma_rb Ptr, pSizeInBytes:stdlib.plugins.libc.size_t Ptr, ppBufferOut:Void Ptr Ptr )
Function ma_rb_commit_write:ma_result( pRB:ma_rb Ptr, sizeInBytes:stdlib.plugins.libc.size_t, pBufferOut:Void Ptr )
Function ma_rb_seek_read:ma_result( pRB:ma_rb Ptr, offsetInBytes:stdlib.plugins.libc.size_t )
Function ma_rb_seek_write:ma_result( pRB:ma_rb Ptr, offsetInBytes:stdlib.plugins.libc.size_t )
Function ma_rb_pointer_distance:ma_int32( pRB:ma_rb Ptr )
Function ma_rb_available_read:ma_uint32( pRB:ma_rb Ptr )
Function ma_rb_available_write:ma_uint32( pRB:ma_rb Ptr )
Function ma_rb_get_subbuffer_size:stdlib.plugins.libc.size_t( pRB:ma_rb Ptr )
Function ma_rb_get_subbuffer_stride:stdlib.plugins.libc.size_t( pRB:ma_rb Ptr )
Function ma_rb_get_subbuffer_offset:stdlib.plugins.libc.size_t( pRB:ma_rb Ptr, subbufferIndex:stdlib.plugins.libc.size_t )
Function ma_rb_get_subbuffer_ptr:Void Ptr( pRB:ma_rb Ptr, subbufferIndex:stdlib.plugins.libc.size_t, pBuffer:Void Ptr )
Struct ma_pcm_rb
	Field rb:ma_rb
	Field format:ma_format
	Field channels:ma_uint32
End
Function ma_pcm_rb_init_ex:ma_result( format:ma_format, channels:ma_uint32, subbufferSizeInFrames:ma_uint32, subbufferCount:ma_uint32, subbufferStrideInFrames:ma_uint32, pOptionalPreallocatedBuffer:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr, pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_init:ma_result( format:ma_format, channels:ma_uint32, bufferSizeInFrames:ma_uint32, pOptionalPreallocatedBuffer:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr, pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_uninit:Void( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_reset:Void( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_acquire_read:ma_result( pRB:ma_pcm_rb Ptr, pSizeInFrames:ma_uint32 Ptr, ppBufferOut:Void Ptr Ptr )
Function ma_pcm_rb_commit_read:ma_result( pRB:ma_pcm_rb Ptr, sizeInFrames:ma_uint32, pBufferOut:Void Ptr )
Function ma_pcm_rb_acquire_write:ma_result( pRB:ma_pcm_rb Ptr, pSizeInFrames:ma_uint32 Ptr, ppBufferOut:Void Ptr Ptr )
Function ma_pcm_rb_commit_write:ma_result( pRB:ma_pcm_rb Ptr, sizeInFrames:ma_uint32, pBufferOut:Void Ptr )
Function ma_pcm_rb_seek_read:ma_result( pRB:ma_pcm_rb Ptr, offsetInFrames:ma_uint32 )
Function ma_pcm_rb_seek_write:ma_result( pRB:ma_pcm_rb Ptr, offsetInFrames:ma_uint32 )
Function ma_pcm_rb_pointer_distance:ma_int32( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_available_read:ma_uint32( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_available_write:ma_uint32( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_get_subbuffer_size:ma_uint32( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_get_subbuffer_stride:ma_uint32( pRB:ma_pcm_rb Ptr )
Function ma_pcm_rb_get_subbuffer_offset:ma_uint32( pRB:ma_pcm_rb Ptr, subbufferIndex:ma_uint32 )
Function ma_pcm_rb_get_subbuffer_ptr:Void Ptr( pRB:ma_pcm_rb Ptr, subbufferIndex:ma_uint32, pBuffer:Void Ptr )
Struct ma_duplex_rb
	Field rb:ma_pcm_rb
End
Function ma_duplex_rb_init:ma_result( captureFormat:ma_format, captureChannels:ma_uint32, sampleRate:ma_uint32, captureInternalSampleRate:ma_uint32, captureInternalPeriodSizeInFrames:ma_uint32, pAllocationCallbacks:ma_allocation_callbacks Ptr, pRB:ma_duplex_rb Ptr )
Function ma_duplex_rb_uninit:ma_result( pRB:ma_duplex_rb Ptr )
Function ma_result_description:CString( result:ma_result )
Function ma_malloc:Void Ptr( sz:stdlib.plugins.libc.size_t, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Function ma_realloc:Void Ptr( p:Void Ptr, sz:stdlib.plugins.libc.size_t, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Function ma_free:Void( p:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Function ma_aligned_malloc:Void Ptr( sz:stdlib.plugins.libc.size_t, alignment:stdlib.plugins.libc.size_t, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Function ma_aligned_free:Void( p:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Function ma_get_format_name:CString( format:ma_format )
Function ma_blend_f32:Void( pOut:Float Ptr, pInA:Float Ptr, pInB:Float Ptr, factor:Float, channels:ma_uint32 )
Function ma_get_bytes_per_sample:ma_uint32( format:ma_format )
Function ma_get_bytes_per_frame:ma_uint32( format:ma_format, channels:ma_uint32 )
Function ma_log_level_to_string:CString( logLevel:ma_uint32 )
Struct ma_IMMNotificationClient
	Field lpVtbl:Void Ptr
	Field counter:ma_uint32
	Field pDevice:ma_device Ptr
End
Enum ma_backend
End
Const ma_backend_wasapi:ma_backend
Const ma_backend_dsound:ma_backend
Const ma_backend_winmm:ma_backend
Const ma_backend_coreaudio:ma_backend
Const ma_backend_sndio:ma_backend
Const ma_backend_audio4:ma_backend
Const ma_backend_oss:ma_backend
Const ma_backend_pulseaudio:ma_backend
Const ma_backend_alsa:ma_backend
Const ma_backend_jack:ma_backend
Const ma_backend_aaudio:ma_backend
Const ma_backend_opensl:ma_backend
Const ma_backend_webaudio:ma_backend
Const ma_backend_custom:ma_backend
Const ma_backend_null:ma_backend
Alias ma_device_callback_proc:Void( ma_device Ptr, Void Ptr, ConstVoid Ptr, ma_uint32 )
Alias ma_stop_proc:Void( ma_device Ptr )
Alias ma_log_proc:Void( ma_context Ptr, ma_device Ptr, ma_uint32, CString )
Enum ma_device_type
End
Const ma_device_type_playback:ma_device_type
Const ma_device_type_capture:ma_device_type
Const ma_device_type_duplex:ma_device_type
Const ma_device_type_loopback:ma_device_type
Enum ma_share_mode
End
Const ma_share_mode_shared:ma_share_mode
Const ma_share_mode_exclusive:ma_share_mode
Enum ma_ios_session_category
End
Const ma_ios_session_category_default:ma_ios_session_category
Const ma_ios_session_category_none:ma_ios_session_category
Const ma_ios_session_category_ambient:ma_ios_session_category
Const ma_ios_session_category_solo_ambient:ma_ios_session_category
Const ma_ios_session_category_playback:ma_ios_session_category
Const ma_ios_session_category_record:ma_ios_session_category
Const ma_ios_session_category_play_and_record:ma_ios_session_category
Const ma_ios_session_category_multi_route:ma_ios_session_category
Enum ma_ios_session_category_option
End
Const ma_ios_session_category_option_mix_with_others:ma_ios_session_category_option
Const ma_ios_session_category_option_duck_others:ma_ios_session_category_option
Const ma_ios_session_category_option_allow_bluetooth:ma_ios_session_category_option
Const ma_ios_session_category_option_default_to_speaker:ma_ios_session_category_option
Const ma_ios_session_category_option_interrupt_spoken_audio_and_mix_with_others:ma_ios_session_category_option
Const ma_ios_session_category_option_allow_bluetooth_a2dp:ma_ios_session_category_option
Const ma_ios_session_category_option_allow_air_play:ma_ios_session_category_option
Enum ma_opensl_stream_type
End
Const ma_opensl_stream_type_default:ma_opensl_stream_type
Const ma_opensl_stream_type_voice:ma_opensl_stream_type
Const ma_opensl_stream_type_system:ma_opensl_stream_type
Const ma_opensl_stream_type_ring:ma_opensl_stream_type
Const ma_opensl_stream_type_media:ma_opensl_stream_type
Const ma_opensl_stream_type_alarm:ma_opensl_stream_type
Const ma_opensl_stream_type_notification:ma_opensl_stream_type
Enum ma_opensl_recording_preset
End
Const ma_opensl_recording_preset_default:ma_opensl_recording_preset
Const ma_opensl_recording_preset_generic:ma_opensl_recording_preset
Const ma_opensl_recording_preset_camcorder:ma_opensl_recording_preset
Const ma_opensl_recording_preset_voice_recognition:ma_opensl_recording_preset
Const ma_opensl_recording_preset_voice_communication:ma_opensl_recording_preset
Const ma_opensl_recording_preset_voice_unprocessed:ma_opensl_recording_preset
Enum ma_aaudio_usage
End
Const ma_aaudio_usage_default:ma_aaudio_usage
Const ma_aaudio_usage_announcement:ma_aaudio_usage
Const ma_aaudio_usage_emergency:ma_aaudio_usage
Const ma_aaudio_usage_safety:ma_aaudio_usage
Const ma_aaudio_usage_vehicle_status:ma_aaudio_usage
Const ma_aaudio_usage_alarm:ma_aaudio_usage
Const ma_aaudio_usage_assistance_accessibility:ma_aaudio_usage
Const ma_aaudio_usage_assistance_navigation_guidance:ma_aaudio_usage
Const ma_aaudio_usage_assistance_sonification:ma_aaudio_usage
Const ma_aaudio_usage_assitant:ma_aaudio_usage
Const ma_aaudio_usage_game:ma_aaudio_usage
Const ma_aaudio_usage_media:ma_aaudio_usage
Const ma_aaudio_usage_notification:ma_aaudio_usage
Const ma_aaudio_usage_notification_event:ma_aaudio_usage
Const ma_aaudio_usage_notification_ringtone:ma_aaudio_usage
Const ma_aaudio_usage_voice_communication:ma_aaudio_usage
Const ma_aaudio_usage_voice_communication_signalling:ma_aaudio_usage
Enum ma_aaudio_content_type
End
Const ma_aaudio_content_type_default:ma_aaudio_content_type
Const ma_aaudio_content_type_movie:ma_aaudio_content_type
Const ma_aaudio_content_type_music:ma_aaudio_content_type
Const ma_aaudio_content_type_sonification:ma_aaudio_content_type
Const ma_aaudio_content_type_speech:ma_aaudio_content_type
Enum ma_aaudio_input_preset
End
Const ma_aaudio_input_preset_default:ma_aaudio_input_preset
Const ma_aaudio_input_preset_generic:ma_aaudio_input_preset
Const ma_aaudio_input_preset_camcorder:ma_aaudio_input_preset
Const ma_aaudio_input_preset_unprocessed:ma_aaudio_input_preset
Const ma_aaudio_input_preset_voice_recognition:ma_aaudio_input_preset
Const ma_aaudio_input_preset_voice_communication:ma_aaudio_input_preset
Const ma_aaudio_input_preset_voice_performance:ma_aaudio_input_preset
Struct ma_timer
	Field counter:ma_int64
	Field counterID:Double
End
Struct ma_device_id__custom
	Field i:int
	Field s:byte ptr
	Field p:Void Ptr
End
Struct ma_device_id
	Field wasapi:wchar_t Ptr
	Field dsound:ma_uint8 Ptr
	Field winmm:ma_uint32
	Field alsa:Byte Ptr
	Field pulse:Byte Ptr
	Field jack:Int
	Field coreaudio:Byte Ptr
	Field sndio:Byte Ptr
	Field audio4:Byte Ptr
	Field oss:Byte Ptr
	Field aaudio:ma_int32
	Field opensl:ma_uint32
	Field webaudio:Byte Ptr
	Field custom:ma_device_id__custom
End
Struct ma_device_info__nativeDataFormat
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field flags:ma_uint32
End
Struct ma_device_info
	Field id:ma_device_id
	Field name:stdlib.plugins.libc.char_t Ptr
	Field isDefault:ma_bool32
	Field formatCount:ma_uint32
	Field formats:ma_format Ptr
	Field minChannels:ma_uint32
	Field maxChannels:ma_uint32
	Field minSampleRate:ma_uint32
	Field maxSampleRate:ma_uint32
	Field nativeDataFormatCount:ma_uint32
	Field nativeDataFormat:ma_device_info__nativeDataFormat Ptr
End
Struct ma_device_config__aaudio
	Field usage:ma_aaudio_usage
	Field contentType:ma_aaudio_content_type
	Field inputPreset:ma_aaudio_input_preset
End
Struct ma_device_config__opensl
	Field streamType:ma_opensl_stream_type
	Field recordingPreset:ma_opensl_recording_preset
End
Struct ma_device_config__coreaudio
	Field allowNominalSampleRateChange:ma_bool32
End
Struct ma_device_config__pulse
	Field pStreamNamePlayback:stdlib.plugins.libc.const_char_t Ptr
	Field pStreamNameCapture:stdlib.plugins.libc.const_char_t Ptr
End
Struct ma_device_config__alsa
	Field noMMap:ma_bool32
	Field noAutoFormat:ma_bool32
	Field noAutoChannels:ma_bool32
	Field noAutoResample:ma_bool32
End
Struct ma_device_config__wasapi
	Field noAutoConvertSRC:ma_bool8
	Field noDefaultQualitySRC:ma_bool8
	Field noAutoStreamRouting:ma_bool8
	Field noHardwareOffloading:ma_bool8
End
Struct ma_device_config__capture
	Field pDeviceID:ma_device_id Ptr
	Field format:ma_format
	Field channels:ma_uint32
	Field channelMap:ma_channel Ptr
	Field channelMixMode:ma_channel_mix_mode
	Field shareMode:ma_share_mode
End
Struct ma_device_config__playback
	Field pDeviceID:ma_device_id Ptr
	Field format:ma_format
	Field channels:ma_uint32
	Field channelMap:ma_channel Ptr
	Field channelMixMode:ma_channel_mix_mode
	Field shareMode:ma_share_mode
End
Struct ma_device_config___resampling_linear
	Field lpfOrder:ma_uint32
End
Struct ma_device_config___resampling_speex
	Field quality:Int
End
Struct ma_device_config__resampling
	Field algorithm:ma_resample_algorithm
	Field linear:ma_device_config___resampling_linear
	Field speex:ma_device_config___resampling_speex
End
Struct ma_device_config
	Field deviceType:ma_device_type
	Field sampleRate:ma_uint32
	Field periodSizeInFrames:ma_uint32
	Field periodSizeInMilliseconds:ma_uint32
	Field periods:ma_uint32
	Field performanceProfile:ma_performance_profile
	Field noPreZeroedOutputBuffer:ma_bool8
	Field noClip:ma_bool8
	Field dataCallback:ma_device_callback_proc
	Field stopCallback:ma_stop_proc
	Field pUserData:Void Ptr
	Field resampling:ma_device_config__resampling
	Field playback:ma_device_config__playback
	Field capture:ma_device_config__capture
	Field wasapi:ma_device_config__wasapi
	Field alsa:ma_device_config__alsa
	Field pulse:ma_device_config__pulse
	Field coreaudio:ma_device_config__coreaudio
	Field opensl:ma_device_config__opensl
	Field aaudio:ma_device_config__aaudio
End
Alias ma_enum_devices_callback_proc:ma_bool32( ma_context Ptr, ma_device_type, ma_device_info Ptr, Void Ptr )
Struct ma_device_descriptor
	Field pDeviceID:ma_device_id Ptr
	Field shareMode:ma_share_mode
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field channelMap:ma_channel Ptr
	Field periodSizeInFrames:ma_uint32
	Field periodSizeInMilliseconds:ma_uint32
	Field periodCount:ma_uint32
End
Struct ma_backend_callbacks
	Field onContextInit:ma_result( ma_context Ptr, ma_context_config Ptr, ma_backend_callbacks Ptr )
	Field onContextUninit:ma_result( ma_context Ptr )
	Field onContextEnumerateDevices:ma_result( ma_context Ptr, ma_enum_devices_callback_proc, Void Ptr )
	Field onContextGetDeviceInfo:ma_result( ma_context Ptr, ma_device_type, ma_device_id Ptr, ma_device_info Ptr )
	Field onDeviceInit:ma_result( ma_device Ptr, ma_device_config Ptr, ma_device_descriptor Ptr, ma_device_descriptor Ptr )
	Field onDeviceUninit:ma_result( ma_device Ptr )
	Field onDeviceStart:ma_result( ma_device Ptr )
	Field onDeviceStop:ma_result( ma_device Ptr )
	Field onDeviceRead:ma_result( ma_device Ptr, Void Ptr, ma_uint32, ma_uint32 Ptr )
	Field onDeviceWrite:ma_result( ma_device Ptr, Void Ptr, ma_uint32, ma_uint32 Ptr )
	Field onDeviceDataLoop:ma_result( ma_device Ptr )
	Field onDeviceDataLoopWakeup:ma_result( ma_device Ptr )
End
Struct ma_context_config__alsa
	Field useVerboseDeviceEnumeration:ma_bool32
End
Struct ma_context_config__pulse
	Field pApplicationName:stdlib.plugins.libc.const_char_t Ptr
	Field pServerName:stdlib.plugins.libc.const_char_t Ptr
	Field tryAutoSpawn:ma_bool32
End
Struct ma_context_config__coreaudio
	Field sessionCategory:ma_ios_session_category
	Field sessionCategoryOptions:ma_uint32
	Field noAudioSessionActivate:ma_bool32
	Field noAudioSessionDeactivate:ma_bool32
End
Struct ma_context_config__jack
	Field pClientName:stdlib.plugins.libc.const_char_t Ptr
	Field tryStartServer:ma_bool32
End
Struct ma_context_config
	Field logCallback:ma_log_proc
	Field threadPriority:ma_thread_priority
	Field threadStackSize:stdlib.plugins.libc.size_t
	Field pUserData:Void Ptr
	Field allocationCallbacks:ma_allocation_callbacks
	Field alsa:ma_context_config__alsa
	Field pulse:ma_context_config__pulse
	Field coreaudio:ma_context_config__coreaudio
	Field jack:ma_context_config__jack
	Field custom:ma_backend_callbacks
End
Struct ma_context_command__wasapi__data_quit
	Field _unused:int
End
Struct ma_context_command__wasapi__data_createAudioClient
	Field deviceType:ma_device_type
	Field pAudioClient:Void Ptr
	Field ppAudioClientService:Void Ptr Ptr
	Field pResult:ma_result Ptr
End
Struct ma_context_command__wasapi__data_releaseAudioClient
	Field pDevice:ma_device Ptr
	Field deviceType:ma_device_type
End
Struct ma_context_command__wasapi__data
	Field quit:ma_context_command__wasapi__data_quit
	Field createAudioClient:ma_context_command__wasapi__data_createAudioClient
	Field releaseAudioClient:ma_context_command__wasapi__data_releaseAudioClient
End
Struct ma_context_command__wasapi
	Field code:Int
	Field pEvent:ma_event Ptr
	Field data:ma_context_command__wasapi__data
End
Struct ma_context
	Field callbacks:ma_backend_callbacks
	Field backend:ma_backend
	Field logCallback:ma_log_proc
	Field threadPriority:ma_thread_priority
	Field threadStackSize:stdlib.plugins.libc.size_t
	Field pUserData:Void Ptr
	Field allocationCallbacks:ma_allocation_callbacks
	Field deviceEnumLock:ma_mutex
	Field deviceInfoLock:ma_mutex
	Field deviceInfoCapacity:ma_uint32
	Field playbackDeviceInfoCount:ma_uint32
	Field captureDeviceInfoCount:ma_uint32
	Field pDeviceInfos:ma_device_info Ptr
End
Struct ma_device__resampling_linear
	Field lpfOrder:ma_uint32
End
Struct ma_device__resampling_speex
	Field quality:Int
End
Struct ma_device__resampling
	Field algorithm:ma_resample_algorithm
	field linear:ma_device__resampling_linear
	Field speex:ma_device__resampling_speex
End
Struct ma_device__playback
	Field id:ma_device_id
	Field name:byte ptr
	Field shareMode:ma_share_mode
	Field format:ma_format
	Field channels:ma_uint32
	Field channelMap:ma_channel Ptr
	Field internalFormat:ma_format
	Field internalSampleRate:ma_uint32
	Field internalChannelMap: ma_channel Ptr
	Field internalPeriodSizeInFrames:ma_uint32
	Field internalPeriods:ma_uint32
	Field channelMixMode:ma_channel_mix_mode
	Field converter:ma_data_converter
End
Struct ma_device__capture
	Field id:ma_device_id
	Field name:byte ptr
	Field shareMode:ma_share_mode
	Field format:ma_format
	Field channels:ma_uint32
	Field channelMap:ma_channel Ptr
	Field internalFormat:ma_format
	Field internalSampleRate:ma_uint32
	Field internalChannelMap: ma_channel Ptr
	Field internalPeriodSizeInFrames:ma_uint32
	Field internalPeriods:ma_uint32
	Field channelMixMode:ma_channel_mix_mode
	Field converter:ma_data_converter
End
Struct ma_device__wasapi
	Field pAudioClientPlayback:ma_ptr
	Field pAudioClientCapture:ma_ptr
	Field pRenderClient:ma_ptr
	Field pCaptureClient:ma_ptr
	Field pDeviceEnumerator:ma_ptr
	Field notificationClient:ma_IMMNotificationClient
	Field hEventPlayback:ma_handle
	Field hEventCapture:ma_handle
	Field actualPeriodSizeInFramesPlayback:ma_uint32
	Field actualPeriodSizeInFramesCapture:ma_uint32
	Field originalPeriodSizeInFrames:ma_uint32
	Field originalPeriodSizeInMilliseconds:ma_uint32
	Field originalPeriods:ma_uint32
	Field originalPerformanceProfile:ma_performance_profile
	Field periodSizeInFramesPlayback:ma_uint32
	Field periodSizeInFramesCapture:ma_uint32
	Field isStartedCapture:ma_bool32
	Field isStartedPlayback:ma_bool32
	Field noAutoConvertSRC:ma_bool8
	Field noDefaultQualitySRC:ma_bool8
	Field noHardwareOffloading:ma_bool8
	Field allowCaptureAutoStreamRouting:ma_bool8
	Field allowPlaybackAutoStreamRouting:ma_bool8
	Field isDetachedPlayback:ma_bool8
	Field isDetachedCapture:ma_bool8
End
Struct ma_device__dsound
	Field pPlayback:ma_ptr
	Field pPlaybackPrimaryBuffer:ma_ptr
	Field pPlaybackBuffer:ma_ptr
	Field pCapture:ma_ptr
	Field pCaptureBuffer:ma_ptr
End
Struct ma_device__winmm
	Field hDevicePlayback:ma_handle
	Field hDeviceCapture:ma_handle
	Field hEventPlayback:ma_handle
	Field hEventCapture:ma_handle
	Field fragmentSizeInFrames:ma_uint32
	Field iNextHeaderPlayback:ma_uint32
	Field iNextHeaderCapture:ma_uint32
	Field headerFramesConsumedPlayback:ma_uint32
	Field headerFramesConsumedCapture:ma_uint32
	Field pWAVEHDRPlayback:ma_uint8 Ptr
	Field pWAVEHDRCapture:ma_uint8 Ptr
	Field pIntermediaryBufferPlayback:ma_uint8 Ptr
	Field pIntermediaryBufferCapture:ma_uint8 Ptr
	Field _pHeapData:ma_uint8 Ptr
End
Struct ma_device__alsa
	Field pPCMPlayback:ma_ptr
	Field pPCMCapture:ma_ptr
	Field pPollDescriptorsPlayback:Void Ptr
	Field pPollDescriptorsCapture:Void Ptr
	Field pollDescriptorCountPlayback:Int
	Field pollDescriptorCountCapture:Int
	Field wakeupfdPlayback:Int
	Field wakeupfdCapture:Int
	Field isUsingMMapPlayback:ma_bool8
	Field isUsingMMapCapture:ma_bool8
End
Struct ma_device__pulse
	Field pStreamPlayback:ma_ptr
	Field pStreamCapture:ma_ptr
End
Struct ma_device__jack
	Field pClient:ma_ptr
	Field pPortsPlayback:ma_ptr Ptr '[]
	Field pPortsCapture:ma_ptr Ptr '[]
	Field pIntermediaryBufferPlayback:Float Ptr
	Field pIntermediaryBufferCapture:Float Ptr
End
Struct ma_device__coreaudio
	Field deviceObjectIDPlayback:ma_uint32
	Field deviceObjectIDCapture:ma_uint32
	Field audioUnitPlayback:ma_ptr
	Field audioUnitCapture:ma_ptr
	Field pAudioBufferList:ma_ptr
	Field audioBufferCapInFrames:ma_uint32
	Field stopEvent:ma_event
	Field originalPeriodSizeInFrames:ma_uint32
	Field originalPeriodSizeInMilliseconds:ma_uint32
	Field originalPeriods:ma_uint32
	Field originalPerformanceProfile:ma_performance_profile
	Field isDefaultPlaybackDevice:ma_bool32
	Field isDefaultCaptureDevice:ma_bool32
	Field isSwitchingPlaybackDevice:ma_bool32
	Field isSwitchingCaptureDevice:ma_bool32
	Field pRouteChangeHandler:Void Ptr
End
Struct ma_device__sndio
	Field handlePlayback:ma_ptr
	Field handleCapture:ma_ptr
	Field isStartedPlayback:ma_bool32
	Field isStartedCapture:ma_bool32
End
Struct ma_device__audio4
	Field fdPlayback:int
	Field fdCapture:int
End
Struct ma_device__oss
	Field fdPlayback:int
	Field fdCapture:int
End
Struct ma_device__aaudio
	Field pStreamPlayback:ma_ptr
	Field pStreamCapture:ma_ptr
End
Struct ma_device__opensl
	Field pOutputMixObj:ma_ptr
	Field pOutputMix:ma_ptr
	Field pAudioPlayerObj:ma_ptr
	Field pAudioPlayer:ma_ptr
	Field pAudioRecorderObj:ma_ptr
	Field pAudioRecorder:ma_ptr
	Field pBufferQueuePlayback:ma_ptr
	Field pBufferQueueCapture:ma_ptr
	Field isDrainingCapture:ma_bool32
	Field isDrainingPlayback:ma_bool32
	Field currentBufferIndexPlayback:ma_uint32
	Field currentBufferIndexCapture:ma_uint32
	Field pBufferPlayback:ma_uint8 Ptr
	Field pBufferCapture:ma_uint8 Ptr
End
Struct ma_device__webaudio
	Field indexPlayback:int
	Field indexCapture:int
End
Struct ma_device__null_device
	Field deviceThread:ma_thread
	Field operationEvent:ma_event
	Field operationCompletionEvent:ma_event
	Field operationSemaphore:ma_semaphore
	Field operation:ma_uint32
	Field operationResult:ma_result
	Field timer:ma_timer
	Field priorRunTime:double
	Field currentPeriodFramesRemainingPlayback:ma_uint32
	Field currentPeriodFramesRemainingCapture:ma_uint32
	Field lastProcessedFramePlayback:ma_uint64
	Field lastProcessedFrameCapture:ma_uint64
	Field isStarted:ma_bool32
End
Struct ma_device
	Field pContext:ma_context Ptr
	Field type:ma_device_type
	Field sampleRate:ma_uint32
	Field state:ma_uint32
	Field onData:ma_device_callback_proc
	Field onStop:ma_stop_proc
	Field pUserData:Void Ptr
	Field startStopLock:ma_mutex
	Field wakeupEvent:ma_event
	Field startEvent:ma_event
	Field stopEvent:ma_event
	Field thread:ma_thread
	Field workResult:ma_result
	Field isOwnerOfContext:ma_bool8
	Field noPreZeroedOutputBuffer:ma_bool8
	Field noClip:ma_bool8
	Field masterVolumeFactor:Float
	Field duplexRB:ma_duplex_rb
	Field resampling:ma_device__resampling
	Field playback:ma_device__playback
	Field capture:ma_device__capture
	Field wasapi:ma_device__wasapi
	Field dsound:ma_device__dsound
	field winmm:ma_device__winmm
	Field alsa:ma_device__alsa
	Field pulse:ma_device__pulse
	Field jack:ma_device__jack
	Field coreaudio:ma_device__coreaudio
	Field sndio:ma_device__sndio
	Field audio4:ma_device__audio4
	Field oss:ma_device__oss
	Field aaudio:ma_device__aaudio
	Field opensl:ma_device__opensl
	Field webaudio:ma_device__webaudio
	field null_device:ma_device__null_device
End
Function ma_context_config_init:ma_context_config(	)
Function ma_context_init:ma_result( backends:ma_backend Ptr, backendCount:ma_uint32, pConfig:ma_context_config Ptr, pContext:ma_context Ptr )
Function ma_context_uninit:ma_result( pContext:ma_context Ptr )
Function ma_context_sizeof:stdlib.plugins.libc.size_t(	)
Function ma_context_enumerate_devices:ma_result( pContext:ma_context Ptr, callback:ma_enum_devices_callback_proc, pUserData:Void Ptr )
Function ma_context_get_devices:ma_result( pContext:ma_context Ptr, ppPlaybackDeviceInfos:ma_device_info Ptr Ptr, pPlaybackDeviceCount:ma_uint32 Ptr, ppCaptureDeviceInfos:ma_device_info Ptr Ptr, pCaptureDeviceCount:ma_uint32 Ptr )
Function ma_context_get_device_info:ma_result( pContext:ma_context Ptr, deviceType:ma_device_type, pDeviceID:ma_device_id Ptr, shareMode:ma_share_mode, pDeviceInfo:ma_device_info Ptr )
Function ma_context_is_loopback_supported:ma_bool32( pContext:ma_context Ptr )
Function ma_device_config_init:ma_device_config( deviceType:ma_device_type )
Function ma_device_init:ma_result( pContext:ma_context Ptr, pConfig:ma_device_config Ptr, pDevice:ma_device Ptr )
Function ma_device_init_ex:ma_result( backends:ma_backend Ptr, backendCount:ma_uint32, pContextConfig:ma_context_config Ptr, pConfig:ma_device_config Ptr, pDevice:ma_device Ptr )
Function ma_device_uninit:Void( pDevice:ma_device Ptr )
Function ma_device_start:ma_result( pDevice:ma_device Ptr )
Function ma_device_stop:ma_result( pDevice:ma_device Ptr )
Function ma_device_is_started:ma_bool32( pDevice:ma_device Ptr )
Function ma_device_get_state:ma_uint32( pDevice:ma_device Ptr )
Function ma_device_set_master_volume:ma_result( pDevice:ma_device Ptr, volume:Float )
Function ma_device_get_master_volume:ma_result( pDevice:ma_device Ptr, pVolume:Float Ptr )
Function ma_device_set_master_gain_db:ma_result( pDevice:ma_device Ptr, gainDB:Float )
Function ma_device_get_master_gain_db:ma_result( pDevice:ma_device Ptr, pGainDB:Float Ptr )
Function ma_device_handle_backend_data_callback:ma_result( pDevice:ma_device Ptr, pOutput:Void Ptr, pInput:Void Ptr, frameCount:ma_uint32 )
Function ma_calculate_buffer_size_in_frames_from_descriptor:ma_uint32( pDescriptor:ma_device_descriptor Ptr, nativeSampleRate:ma_uint32, performanceProfile:ma_performance_profile )
Function ma_get_backend_name:CString( backend:ma_backend )
Function ma_is_backend_enabled:ma_bool32( backend:ma_backend )
Function ma_get_enabled_backends:ma_result( pBackends:ma_backend Ptr, backendCap:stdlib.plugins.libc.size_t, pBackendCount:stdlib.plugins.libc.size_t Ptr )
Function ma_is_loopback_supported:ma_bool32( backend:ma_backend )
Function ma_spinlock_lock:ma_result( pSpinlock:ma_spinlock Ptr ) 'volatile
Function ma_spinlock_lock_noyield:ma_result( pSpinlock:ma_spinlock Ptr ) 'volatile
Function ma_spinlock_unlock:ma_result( pSpinlock:ma_spinlock Ptr ) 'volatile
Function ma_mutex_init:ma_result( pMutex:ma_mutex Ptr )
Function ma_mutex_uninit:Void( pMutex:ma_mutex Ptr )
Function ma_mutex_lock:Void( pMutex:ma_mutex Ptr )
Function ma_mutex_unlock:Void( pMutex:ma_mutex Ptr )
Function ma_event_init:ma_result( pEvent:ma_event Ptr )
Function ma_event_uninit:Void( pEvent:ma_event Ptr )
Function ma_event_wait:ma_result( pEvent:ma_event Ptr )
Function ma_event_signal:ma_result( pEvent:ma_event Ptr )
Function ma_scale_buffer_size:ma_uint32( baseBufferSize:ma_uint32, scale:Float )
Function ma_calculate_buffer_size_in_milliseconds_from_frames:ma_uint32( bufferSizeInFrames:ma_uint32, sampleRate:ma_uint32 )
Function ma_calculate_buffer_size_in_frames_from_milliseconds:ma_uint32( bufferSizeInMilliseconds:ma_uint32, sampleRate:ma_uint32 )
Function ma_copy_pcm_frames:Void( dst:Void Ptr, src:Void Ptr, frameCount:ma_uint64, format:ma_format, channels:ma_uint32 )
Function ma_silence_pcm_frames:Void( p:Void Ptr, frameCount:ma_uint64, format:ma_format, channels:ma_uint32 )
Function ma_zero_pcm_frames:Void( p:Void Ptr, frameCount:ma_uint64, format:ma_format, channels:ma_uint32 )
Function ma_offset_pcm_frames_ptr:Void Ptr( p:Void Ptr, offsetInFrames:ma_uint64, format:ma_format, channels:ma_uint32 )
Function ma_offset_pcm_frames_const_ptr:Void Ptr( p:Void Ptr, offsetInFrames:ma_uint64, format:ma_format, channels:ma_uint32 )
Function ma_offset_pcm_frames_ptr_f32:Float Ptr( p:Float Ptr, offsetInFrames:ma_uint64, channels:ma_uint32 )
Function ma_offset_pcm_frames_const_ptr_f32:Float Ptr( p:Float Ptr, offsetInFrames:ma_uint64, channels:ma_uint32 )
Function ma_clip_samples_f32:Void( p:Float Ptr, sampleCount:ma_uint64 )
Function ma_clip_pcm_frames_f32:Void( p:Float Ptr, frameCount:ma_uint64, channels:ma_uint32 )
Function ma_copy_and_apply_volume_factor_u8:Void( pSamplesOut:ma_uint8 Ptr, pSamplesIn:ma_uint8 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_copy_and_apply_volume_factor_s16:Void( pSamplesOut:ma_int16 Ptr, pSamplesIn:ma_int16 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_copy_and_apply_volume_factor_s24:Void( pSamplesOut:Void Ptr, pSamplesIn:Void Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_copy_and_apply_volume_factor_s32:Void( pSamplesOut:ma_int32 Ptr, pSamplesIn:ma_int32 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_copy_and_apply_volume_factor_f32:Void( pSamplesOut:Float Ptr, pSamplesIn:Float Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_apply_volume_factor_u8:Void( pSamples:ma_uint8 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_apply_volume_factor_s16:Void( pSamples:ma_int16 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_apply_volume_factor_s24:Void( pSamples:Void Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_apply_volume_factor_s32:Void( pSamples:ma_int32 Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_apply_volume_factor_f32:Void( pSamples:Float Ptr, sampleCount:ma_uint64, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames_u8:Void( pPCMFramesOut:ma_uint8 Ptr, pPCMFramesIn:ma_uint8 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames_s16:Void( pPCMFramesOut:ma_int16 Ptr, pPCMFramesIn:ma_int16 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames_s24:Void( pPCMFramesOut:Void Ptr, pPCMFramesIn:Void Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames_s32:Void( pPCMFramesOut:ma_int32 Ptr, pPCMFramesIn:ma_int32 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames_f32:Void( pPCMFramesOut:Float Ptr, pPCMFramesIn:Float Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_copy_and_apply_volume_factor_pcm_frames:Void( pFramesOut:Void Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64, format:ma_format, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames_u8:Void( pFrames:ma_uint8 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames_s16:Void( pFrames:ma_int16 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames_s24:Void( pFrames:Void Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames_s32:Void( pFrames:ma_int32 Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames_f32:Void( pFrames:Float Ptr, frameCount:ma_uint64, channels:ma_uint32, factor:Float )
Function ma_apply_volume_factor_pcm_frames:Void( pFrames:Void Ptr, frameCount:ma_uint64, format:ma_format, channels:ma_uint32, factor:Float )
Function ma_factor_to_gain_db:Float( factor:Float )
Function ma_gain_db_to_factor:Float( gain:Float )
Alias ma_data_source:Void
Struct ma_data_source_callbacks
	Field onRead:ma_result( ma_data_source Ptr, Void Ptr, ma_uint64, ma_uint64 Ptr )
	Field onSeek:ma_result( ma_data_source Ptr, ma_uint64 )
	Field onMap:ma_result( ma_data_source Ptr, Void Ptr Ptr, ma_uint64 Ptr )
	Field onUnmap:ma_result( ma_data_source Ptr, ma_uint64 )
	Field onGetDataFormat:ma_result( ma_data_source Ptr, ma_format Ptr, ma_uint32 Ptr, ma_uint32 Ptr )
	Field onGetCursor:ma_result( ma_data_source Ptr, ma_uint64 Ptr )
	Field onGetLength:ma_result( ma_data_source Ptr, ma_uint64 Ptr )
End
Function ma_data_source_read_pcm_frames:ma_result( pDataSource:ma_data_source Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64, pFramesRead:ma_uint64 Ptr, loop:ma_bool32 )
Function ma_data_source_seek_pcm_frames:ma_result( pDataSource:ma_data_source Ptr, frameCount:ma_uint64, pFramesSeeked:ma_uint64 Ptr, loop:ma_bool32 )
Function ma_data_source_seek_to_pcm_frame:ma_result( pDataSource:ma_data_source Ptr, frameIndex:ma_uint64 )
Function ma_data_source_map:ma_result( pDataSource:ma_data_source Ptr, ppFramesOut:Void Ptr Ptr, pFrameCount:ma_uint64 Ptr )
Function ma_data_source_unmap:ma_result( pDataSource:ma_data_source Ptr, frameCount:ma_uint64 )
Function ma_data_source_get_data_format:ma_result( pDataSource:ma_data_source Ptr, pFormat:ma_format Ptr, pChannels:ma_uint32 Ptr, pSampleRate:ma_uint32 Ptr )
Function ma_data_source_get_cursor_in_pcm_frames:ma_result( pDataSource:ma_data_source Ptr, pCursor:ma_uint64 Ptr )
Function ma_data_source_get_length_in_pcm_frames:ma_result( pDataSource:ma_data_source Ptr, pLength:ma_uint64 Ptr )
Struct ma_audio_buffer_ref
	Field ds:ma_data_source_callbacks
	Field format:ma_format
	Field channels:ma_uint32
	Field cursor:ma_uint64
	Field sizeInFrames:ma_uint64
	Field pData:Void Ptr
End
Function ma_audio_buffer_ref_init:ma_result( format:ma_format, channels:ma_uint32, pData:Void Ptr, sizeInFrames:ma_uint64, pAudioBufferRef:ma_audio_buffer_ref Ptr )
Function ma_audio_buffer_ref_set_data:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr, pData:Void Ptr, sizeInFrames:ma_uint64 )
Function ma_audio_buffer_ref_read_pcm_frames:ma_uint64( pAudioBufferRef:ma_audio_buffer_ref Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64, loop:ma_bool32 )
Function ma_audio_buffer_ref_seek_to_pcm_frame:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr, frameIndex:ma_uint64 )
Function ma_audio_buffer_ref_map:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr, ppFramesOut:Void Ptr Ptr, pFrameCount:ma_uint64 Ptr )
Function ma_audio_buffer_ref_unmap:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr, frameCount:ma_uint64 )
Function ma_audio_buffer_ref_at_end:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr )
Function ma_audio_buffer_ref_get_available_frames:ma_result( pAudioBufferRef:ma_audio_buffer_ref Ptr, pAvailableFrames:ma_uint64 Ptr )
Struct ma_audio_buffer_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sizeInFrames:ma_uint64
	Field pData:Void Ptr
	Field allocationCallbacks:ma_allocation_callbacks
End
Function ma_audio_buffer_config_init:ma_audio_buffer_config( format:ma_format, channels:ma_uint32, sizeInFrames:ma_uint64, pData:Void Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Struct ma_audio_buffer
	Field ref:ma_audio_buffer_ref
	Field allocationCallbacks:ma_allocation_callbacks
	Field ownsData:ma_bool32
	Field _pExtraData:ma_uint8 Ptr
End
Function ma_audio_buffer_init:ma_result( pConfig:ma_audio_buffer_config Ptr, pAudioBuffer:ma_audio_buffer Ptr )
Function ma_audio_buffer_init_copy:ma_result( pConfig:ma_audio_buffer_config Ptr, pAudioBuffer:ma_audio_buffer Ptr )
Function ma_audio_buffer_alloc_and_init:ma_result( pConfig:ma_audio_buffer_config Ptr, ppAudioBuffer:ma_audio_buffer Ptr Ptr )
Function ma_audio_buffer_uninit:Void( pAudioBuffer:ma_audio_buffer Ptr )
Function ma_audio_buffer_uninit_and_free:Void( pAudioBuffer:ma_audio_buffer Ptr )
Function ma_audio_buffer_read_pcm_frames:ma_uint64( pAudioBuffer:ma_audio_buffer Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64, loop:ma_bool32 )
Function ma_audio_buffer_seek_to_pcm_frame:ma_result( pAudioBuffer:ma_audio_buffer Ptr, frameIndex:ma_uint64 )
Function ma_audio_buffer_map:ma_result( pAudioBuffer:ma_audio_buffer Ptr, ppFramesOut:Void Ptr Ptr, pFrameCount:ma_uint64 Ptr )
Function ma_audio_buffer_unmap:ma_result( pAudioBuffer:ma_audio_buffer Ptr, frameCount:ma_uint64 )
Function ma_audio_buffer_at_end:ma_result( pAudioBuffer:ma_audio_buffer Ptr )
Function ma_audio_buffer_get_available_frames:ma_result( pAudioBuffer:ma_audio_buffer Ptr, pAvailableFrames:ma_uint64 Ptr )
Alias ma_vfs:Void
Alias ma_vfs_file:ma_handle
Enum ma_seek_origin
End
Const ma_seek_origin_start:ma_seek_origin
Const ma_seek_origin_current:ma_seek_origin
Const ma_seek_origin_end:ma_seek_origin
Struct ma_file_info
	Field sizeInBytes:ma_uint64
End
Struct ma_vfs_callbacks
	Field onOpen:ma_result( ma_vfs Ptr, CString, ma_uint32, ma_vfs_file Ptr )
	Field onOpenW:ma_result( ma_vfs Ptr, wchar_t Ptr, ma_uint32, ma_vfs_file Ptr )
	Field onClose:ma_result( ma_vfs Ptr, ma_vfs_file )
	Field onRead:ma_result( ma_vfs Ptr, ma_vfs_file, Void Ptr, stdlib.plugins.libc.size_t, stdlib.plugins.libc.size_t Ptr )
	Field onWrite:ma_result( ma_vfs Ptr, ma_vfs_file, Void Ptr, stdlib.plugins.libc.size_t, stdlib.plugins.libc.size_t Ptr )
	Field onSeek:ma_result( ma_vfs Ptr, ma_vfs_file, ma_int64, ma_seek_origin )
	Field onTell:ma_result( ma_vfs Ptr, ma_vfs_file, ma_int64 Ptr )
	Field onInfo:ma_result( ma_vfs Ptr, ma_vfs_file, ma_file_info Ptr )
End
Function ma_vfs_open:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, openMode:ma_uint32, pFile:ma_vfs_file Ptr )
Function ma_vfs_open_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, openMode:ma_uint32, pFile:ma_vfs_file Ptr )
Function ma_vfs_close:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file )
Function ma_vfs_read:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file, pDst:Void Ptr, sizeInBytes:stdlib.plugins.libc.size_t, pBytesRead:stdlib.plugins.libc.size_t Ptr )
Function ma_vfs_write:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file, pSrc:Void Ptr, sizeInBytes:stdlib.plugins.libc.size_t, pBytesWritten:stdlib.plugins.libc.size_t Ptr )
Function ma_vfs_seek:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file, offset:ma_int64, origin:ma_seek_origin )
Function ma_vfs_tell:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file, pCursor:ma_int64 Ptr )
Function ma_vfs_info:ma_result( pVFS:ma_vfs Ptr, file:ma_vfs_file, pInfo:ma_file_info Ptr )
Function ma_vfs_open_and_read_file:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, ppData:Void Ptr Ptr, pSize:stdlib.plugins.libc.size_t Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Struct ma_default_vfs
	Field cb:ma_vfs_callbacks
	Field allocationCallbacks:ma_allocation_callbacks
End
Function ma_default_vfs_init:ma_result( pVFS:ma_default_vfs Ptr, pAllocationCallbacks:ma_allocation_callbacks Ptr )
Enum ma_resource_format
End
Const ma_resource_format_wav:ma_resource_format
Alias ma_decoder_read_proc:stdlib.plugins.libc.size_t( ma_decoder Ptr, Void Ptr, stdlib.plugins.libc.size_t )
Alias ma_decoder_seek_proc:ma_bool32( ma_decoder Ptr, Int, ma_seek_origin )
Alias ma_decoder_read_pcm_frames_proc:ma_uint64( ma_decoder Ptr, Void Ptr, ma_uint64 )
Alias ma_decoder_seek_to_pcm_frame_proc:ma_result( ma_decoder Ptr, ma_uint64 )
Alias ma_decoder_uninit_proc:ma_result( ma_decoder Ptr )
Alias ma_decoder_get_length_in_pcm_frames_proc:ma_uint64( ma_decoder Ptr )
Struct ma_decoder_config__resampling_linear
	Field lpfOrder:ma_uint32
End
Struct ma_decoder_config__resampling_speex
	Field quality:Int
End
Struct ma_decoder_config__resampling
	Field algorithm:ma_resample_algorithm
	Field linear:ma_decoder_config__resampling_linear
	Field speex:ma_decoder_config__resampling_speex
End
Struct ma_decoder_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field channelMap:ma_channel Ptr
	Field channelMixMode:ma_channel_mix_mode
	Field ditherMode:ma_dither_mode
	Field resampling:ma_decoder_config__resampling
	Field allocationCallbacks:ma_allocation_callbacks
End
Struct ma_decoder__backend_vfs
	Field pVFS:ma_vfs Ptr
	Field file:ma_vfs_file
End
Struct ma_decoder__backend_memory
	Field pData:ma_uint8 ptr
	Field dataSize:stdlib.plugins.libc.size_t
	Field currentReadPos:stdlib.plugins.libc.size_t
End
Struct ma_decoder__backend
	Field vfs:ma_decoder__backend_vfs
	Field memory:ma_decoder__backend_memory
End
Struct ma_decoder
	Field ds:ma_data_source_callbacks
	Field onRead:ma_decoder_read_proc
	Field onSeek:ma_decoder_seek_proc
	Field pUserData:Void Ptr
	Field readPointerInBytes:ma_uint64
	Field readPointerInPCMFrames:ma_uint64
	Field internalFormat:ma_format
	Field internalChannels:ma_uint32
	Field internalSampleRate:ma_uint32
	Field internalChannelMap:ma_channel Ptr
	Field outputFormat:ma_format
	Field outputChannels:ma_uint32
	Field outputSampleRate:ma_uint32
	Field outputChannelMap:ma_channel Ptr
	Field converter:ma_data_converter
	Field allocationCallbacks:ma_allocation_callbacks
	Field onReadPCMFrames:ma_decoder_read_pcm_frames_proc
	Field onSeekToPCMFrame:ma_decoder_seek_to_pcm_frame_proc
	Field onUninit:ma_decoder_uninit_proc
	Field onGetLengthInPCMFrames:ma_decoder_get_length_in_pcm_frames_proc
	Field pInternalDecoder:Void Ptr
	Field backend:ma_decoder__backend
End
Function ma_decoder_config_init:ma_decoder_config( outputFormat:ma_format, outputChannels:ma_uint32, outputSampleRate:ma_uint32 )
Function ma_decoder_init:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_wav:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_flac:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_mp3:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vorbis:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_raw:ma_result( onRead:ma_decoder_read_proc, onSeek:ma_decoder_seek_proc, pUserData:Void Ptr, pConfigIn:ma_decoder_config Ptr, pConfigOut:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory_wav:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory_flac:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory_mp3:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory_vorbis:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_memory_raw:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfigIn:ma_decoder_config Ptr, pConfigOut:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_wav:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_flac:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_mp3:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_vorbis:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_wav_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_flac_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_mp3_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_vfs_vorbis_w:ma_result( pVFS:ma_vfs Ptr, pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_wav:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_flac:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_mp3:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_vorbis:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_wav_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_flac_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_mp3_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_init_file_vorbis_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_decoder_config Ptr, pDecoder:ma_decoder Ptr )
Function ma_decoder_uninit:ma_result( pDecoder:ma_decoder Ptr )
Function ma_decoder_get_cursor_in_pcm_frames:ma_result( pDecoder:ma_decoder Ptr, pCursor:ma_uint64 Ptr )
Function ma_decoder_get_length_in_pcm_frames:ma_uint64( pDecoder:ma_decoder Ptr )
Function ma_decoder_read_pcm_frames:ma_uint64( pDecoder:ma_decoder Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64 )
Function ma_decoder_seek_to_pcm_frame:ma_result( pDecoder:ma_decoder Ptr, frameIndex:ma_uint64 )
Function ma_decoder_get_available_frames:ma_result( pDecoder:ma_decoder Ptr, pAvailableFrames:ma_uint64 Ptr )
Function ma_decode_from_vfs:ma_result( pVFS:ma_vfs Ptr, pFilePath:CString, pConfig:ma_decoder_config Ptr, pFrameCountOut:ma_uint64 Ptr, ppPCMFramesOut:Void Ptr Ptr )
Function ma_decode_file:ma_result( pFilePath:CString, pConfig:ma_decoder_config Ptr, pFrameCountOut:ma_uint64 Ptr, ppPCMFramesOut:Void Ptr Ptr )
Function ma_decode_memory:ma_result( pData:Void Ptr, dataSize:stdlib.plugins.libc.size_t, pConfig:ma_decoder_config Ptr, pFrameCountOut:ma_uint64 Ptr, ppPCMFramesOut:Void Ptr Ptr )
Alias ma_encoder_write_proc:stdlib.plugins.libc.size_t( ma_encoder Ptr, Void Ptr, stdlib.plugins.libc.size_t )
Alias ma_encoder_seek_proc:ma_bool32( ma_encoder Ptr, Int, ma_seek_origin )
Alias ma_encoder_init_proc:ma_result( ma_encoder Ptr )
Alias ma_encoder_uninit_proc:Void( ma_encoder Ptr )
Alias ma_encoder_write_pcm_frames_proc:ma_uint64( ma_encoder Ptr, Void Ptr, ma_uint64 )
Struct ma_encoder_config
	Field resourceFormat:ma_resource_format
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field allocationCallbacks:ma_allocation_callbacks
End
Function ma_encoder_config_init:ma_encoder_config( resourceFormat:ma_resource_format, format:ma_format, channels:ma_uint32, sampleRate:ma_uint32 )
Struct ma_encoder
	Field config:ma_encoder_config
	Field onWrite:ma_encoder_write_proc
	Field onSeek:ma_encoder_seek_proc
	Field onInit:ma_encoder_init_proc
	Field onUninit:ma_encoder_uninit_proc
	Field onWritePCMFrames:ma_encoder_write_pcm_frames_proc
	Field pUserData:Void Ptr
	Field pInternalEncoder:Void Ptr
	Field pFile:Void Ptr
End
Function ma_encoder_init:ma_result( onWrite:ma_encoder_write_proc, onSeek:ma_encoder_seek_proc, pUserData:Void Ptr, pConfig:ma_encoder_config Ptr, pEncoder:ma_encoder Ptr )
Function ma_encoder_init_file:ma_result( pFilePath:CString, pConfig:ma_encoder_config Ptr, pEncoder:ma_encoder Ptr )
Function ma_encoder_init_file_w:ma_result( pFilePath:wchar_t Ptr, pConfig:ma_encoder_config Ptr, pEncoder:ma_encoder Ptr )
Function ma_encoder_uninit:Void( pEncoder:ma_encoder Ptr )
Function ma_encoder_write_pcm_frames:ma_uint64( pEncoder:ma_encoder Ptr, pFramesIn:Void Ptr, frameCount:ma_uint64 )
Enum ma_waveform_type
End
Const ma_waveform_type_sine:ma_waveform_type
Const ma_waveform_type_square:ma_waveform_type
Const ma_waveform_type_triangle:ma_waveform_type
Const ma_waveform_type_sawtooth:ma_waveform_type
Struct ma_waveform_config
	Field format:ma_format
	Field channels:ma_uint32
	Field sampleRate:ma_uint32
	Field type:ma_waveform_type
	Field amplitude:Double
	Field frequency:Double
End
Function ma_waveform_config_init:ma_waveform_config( format:ma_format, channels:ma_uint32, sampleRate:ma_uint32, type:ma_waveform_type, amplitude:Double, frequency:Double )
Struct ma_waveform
	Field ds:ma_data_source_callbacks
	Field config:ma_waveform_config
	Field advance:Double
	Field time:Double
End
Function ma_waveform_init:ma_result( pConfig:ma_waveform_config Ptr, pWaveform:ma_waveform Ptr )
Function ma_waveform_read_pcm_frames:ma_uint64( pWaveform:ma_waveform Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64 )
Function ma_waveform_seek_to_pcm_frame:ma_result( pWaveform:ma_waveform Ptr, frameIndex:ma_uint64 )
Function ma_waveform_set_amplitude:ma_result( pWaveform:ma_waveform Ptr, amplitude:Double )
Function ma_waveform_set_frequency:ma_result( pWaveform:ma_waveform Ptr, frequency:Double )
Function ma_waveform_set_type:ma_result( pWaveform:ma_waveform Ptr, type:ma_waveform_type )
Function ma_waveform_set_sample_rate:ma_result( pWaveform:ma_waveform Ptr, sampleRate:ma_uint32 )
Enum ma_noise_type
End
Const ma_noise_type_white:ma_noise_type
Const ma_noise_type_pink:ma_noise_type
Const ma_noise_type_brownian:ma_noise_type
Struct ma_noise_config
	Field format:ma_format
	Field channels:ma_uint32
	Field type:ma_noise_type
	Field seed:ma_int32
	Field amplitude:Double
	Field duplicateChannels:ma_bool32
End
Function ma_noise_config_init:ma_noise_config( format:ma_format, channels:ma_uint32, type:ma_noise_type, seed:ma_int32, amplitude:Double )
Struct ma_noise__state_pink
	Field bin:Double Ptr Ptr '[MA_MAX_CHANNELS][16]
	Field accumulation:Double Ptr '[MA_MAX_CHANNELS]
	Field counter:ma_uint32 Ptr '[MA_MAX_CHANNELS]
End
Struct ma_noise__state_brownian
	Field accumulation:Double Ptr '[MA_MAX_CHANNELS]
End
Struct ma_noise__state
	Field pink:ma_noise__state_pink
	Field brownian:ma_noise__state_brownian
End
Struct ma_noise
	Field ds:ma_data_source_callbacks
	Field config:ma_noise_config
	Field lcg:ma_lcg
	field state:ma_noise__state
End
Function ma_noise_init:ma_result( pConfig:ma_noise_config Ptr, pNoise:ma_noise Ptr )
Function ma_noise_read_pcm_frames:ma_uint64( pNoise:ma_noise Ptr, pFramesOut:Void Ptr, frameCount:ma_uint64 )
Function ma_noise_set_amplitude:ma_result( pNoise:ma_noise Ptr, amplitude:Double )
Function ma_noise_set_seed:ma_result( pNoise:ma_noise Ptr, seed:ma_int32 )
Function ma_noise_set_type:ma_result( pNoise:ma_noise Ptr, type:ma_noise_type )

#end