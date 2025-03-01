
Namespace stdlib.platforms

#If __TARGET__="emscripten"
	#Import "emscripten/emscripten"				'INTEGRATED!
#ElseIf __TARGET__="android"
	#Import "android/android" 					'INTEGRATED!
#ElseIf __TARGET__="ios"
	'#Import "<ios>" 'Apple is the wrong path to the machine world
#ElseIf __TARGET__="raspbian"
	#Import "raspbian/raspberry" 				'INTEGRATED!
#ElseIf __TARGET__="windows"
	'Note: If you don't need the win32 api, you can comment
	'the import command. Just recompile the lib after that.
	#Import "win32/win32" 						'INTEGRATED!
#Endif