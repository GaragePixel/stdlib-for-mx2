
Namespace stdlib

#rem


	stdlib version 1.0.0
		Mark Sibly, Monkey coders and iDkP from GaragePixel
		Please read the licence contained in the LICENCE.TXT file of this distribution.


#end

'Primary plugins:

#Import "plugins/makefile" 							'INTEGRATED!

'Main platforms:

#Import "platforms/makefile" 						'INTEGRATED!

'Kernel:

#Import "collections/collections"

#Import "system/system"								'THREAD MODULE OF Monkey-v2018.07 INTEGRATED!

#import "system/reflection/reflection"				'INTEGRATED!

'Sub-systems:

#Import "math/math" 'pseudo math 'library' (a new math library is coming)

#Import "resources/graphics/pixelformat"
#Import "resources/graphics/pixmap"
#Import "resources/graphics/pixmaploader"
#Import "resources/graphics/pixmapsaver"
#Import "resources/graphics/color"

#Import "resources/graphics/enums"

' --- Added by iDkP from GaragePixel

#Import "resources/graphics/wrappers/texturewrapper"	' Cross renderer texture wrapper
#Import "resources/graphics/wrappers/imagewrapper"		' Cross renderer image wrapper
#Import "resources/graphics/wrappers/canvaswrapper"		' Cross renderer canvas wrapper

#Import "resources/graphics/buffers/imagebuffer"		' Cross renderer imagebuffer
#Import "resources/graphics/buffers/framebuffer"		' Cross renderer framebuffer

' ---

#import "resources/audio/audioformat"
#import "resources/audio/audiodata"
#import "resources/audio/load_wav"
#import "resources/audio/load_vorbis"

'Algorithms:

#Import "algorithms/compression/compression"

#Import "algorithms/cryptography/crypto"

#Import "algorithms/encoding/base64/base64"

'Front-end io:

#Import "io/io"

#Import "io/stringio"

#Import "io/chartype"

Function Main()
	
	'Capture app start time

	stdlib.system.time.Now()

	'Add stream handlers

	Stream.OpenFuncs["file"]=Lambda:Stream( proto:String,path:String,mode:String )

		Return FileStream.Open( path,mode )
	End
	
	Stream.OpenFuncs["asset"]=Lambda:Stream( proto:String,path:String,mode:String )
	
		Return FileStream.Open( stdlib.system.io.filesystem.AssetsDir()+path,mode )
	End
	
#If __MOBILE_TARGET__
	
	Stream.OpenFuncs["internal"]=Lambda:Stream( proto:String,path:String,mode:String )
	
		Return FileStream.Open( stdlib.system.io.filesystem.InternalDir()+path,mode )
	End

	Stream.OpenFuncs["external"]=Lambda:Stream( proto:String,path:String,mode:String )
	
		Return FileStream.Open( stdlib.system.io.filesystem.ExternalDir()+path,mode )
	End

#endif
	
	Stream.OpenFuncs["memory"]=Lambda:Stream( proto:String,path:String,mode:String )
	
		Return DataStream.Open( path,mode )
	End
	
#If __DESKTOP_TARGET__

	Stream.OpenFuncs["process"]=Lambda:Stream( proto:String,path:String,mode:String )

		Return stdlib.system.process.ProcessStream.Open( path,mode )
	End
	
#Endif

	Print "stdlib version 1.0.0 - 2025-03-01"

End
