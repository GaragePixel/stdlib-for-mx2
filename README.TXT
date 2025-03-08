#***** Welcome to stdlib! *****

[![Build Status](https://img.shields.io/github/actions/workflow/status/GaragePixel/stdlib-for-mx2/ci.yml?branch=main)](https://github.com/GaragePixel/stdlib-for-mx2/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code Coverage](https://img.shields.io/codecov/c/github/GaragePixel/stdlib-for-mx2/main.svg)](https://codecov.io/gh/GaragePixel/stdlib-for-mx2)
[![Issues](https://img.shields.io/github/issues/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/issues)
[![Forks](https://img.shields.io/github/forks/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/network/members)
[![Stars](https://img.shields.io/github/stars/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/stargazers)
[![Watchers](https://img.shields.io/github/watchers/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/watchers)

Mark Sibly, Monkey coders and iDkP from GaragePixel
Please read the licence contained in the LICENCE file of this distribution.

#***** The Project you can consult (roadmap, etc) *****

https://github.com/users/GaragePixel/projects/2/views/3

#***** This library is written for a specific language *****

Mx2 is a language and a transpiler from the Blitz family languages 
released by Mark Sibly in 2018 as a CPSM 
(https://en.wikipedia.org/wiki/Cross-platform_support_middleware).
It's general-purpose, open-source, user-friendly and cross-platform:
https://github.com/blitz-research/monkey2
	
The original package comes with a number of modules, all essential 
but relatively scattered and lost in the module folder. 
	
These libraries are independent implementations with no shared source code, 
historically these implementations have not evolved from a common project. 
There are 14 vital libraries littering the module directory, 
but we find two libraries to be the most important:
	
· 	The core-language library contains the front-end of the language
· 	and its compagnon called std library provides access to 
	certain essential features for writing program. 
		
This last library is without folder structure, its namespaces are as flat as possible 
on the will of Sibly. In the end, it is not easy for a beginner 
and even in the case of production use to exploit this 'standard library'.
	
As the creator of Chipmunk said in his TODO file:
	- "Reorganize Chimpnuk (sic) Pro directory structure. Too flat and confusing."
	
Which is why it was decided to redesign the std by giving it a structure 
both at the level of its files (organization), but also at the level of 
the namespace tree (ergonomics) with the desire that it can be used only after 
a learning time of the shortest (affordance).
		
'Organization', 'Ergonomics' and 'Affordance' were the three initial concepts 
that guided the design of stdlib. And also, stdlib contains itself. Apart the
language module, no need to integrate external elements that make all this work, 
we will now find them in the plugins directory and they will be periodically updated.
	
#***** stdlib breaks compatibility with the current distribution of mojo *****

stdlib comes with two supplements, one called sdk contains all the essential
modules to creating a program.
		
Because mojo - the legacy graphic framework of the language build on sdl2 - cannot work 
directly with stdlib, sdk_mojo contains an update of Mojo, adapted to work with stdlib. 
stdlib itself don't need sdk_mojo, the same for sdk.
		
You can get a copy of the sdk at this address: https://github.com/GaragePixel/sdk
And a copy of the sdk_mojo at this address: https://github.com/GaragePixel/sdk_mojo-for-monkey2
	
#***** Installation *****

Place the folder in the Monkey's Modules directory and precompile the library. 
You'll need the Mx2cc version 1.1.15, it can be downloaded with the last
legacy distribution of Monkey at: https://github.com/blitz-research/monkey2
	
If you want precompile in command line, open a cmd and go to the bin folder of your
monkey installation, then write:
	
	mx2cc_windows.exe -makemods stdlib -target=desktop -config=release
		
stdlib should precompile in 2 minutes and 13 seconds for the release mode 
and 2 minutes 20 seconds for the debug mode, both for the desktop target. 
stdlib can compile for html5 via emscripten, android and raspberry.
Not support for ios actually, probably ethically never. But we should not never say never...
		
If you want to use Ted2Go, you can use Build > Update / Rebuild modules,
then select the stdlib module, then update.
	
If sdk and sdk_mojo are also in your modules folder, you can put each old modules in a
subdirectory called, by example, 'legacy_modules'. The legacy modules will not
interferes with stdlib, sdk and sdk_mojo, but as you don't need them anymore,
it will keep the modules folder clean. You need the monkey module in the modules folder.
	
Monkey, stdlib, sdk and sdk_mojo are in your modules folder? You can use
Ted2Go to precompile each libraries in just one step (Build > Update / Rebuild modules),
it will take around 23 minutes if you compile only for the windows platform, 
both release and debug mode.
	
You can also use the compiler directly. Open a cmd and go to the bin folder of your
monkey installation, then write:
	
	mx2cc_windows.exe -makemods -target=desktop -config=release
	
	or with the linux compiler: mx2cc_linux -makemods -target=desktop -config=release

#***** stblib's origin and goal *****
	
The developement of the mx2 compiler where continued by a group inside the mx2 community
directed by @seyhajin and @D-a-n-i-l-o, the distribution becames the wx compiler. 
stdlib is planned to be adapted to work with the wx compiler in a couple of time, 
but you can already test stdlib for the mx compiler version 1.1.15 of the last official release 
of mx2 by Sibly, 2018.09: https://github.com/blitz-research/monkey2/blob/develop/VERSIONS.TXT
		
Without the wx2cc code cleaner which allows not to copy unused code blocks into the source,
the mx2cc stdlib produces a 1.46 MB executable file and embed some of its dlls inside.
The executable produced by stdlib will be much more thin with wxcc. Also you can
considerate stdlib as 'legacy' (iDkP wrote 0.0001% of the codebases).
		
stdlib contains an implementation of a strictly similar efficiency to the original std 
and the 14 other satellite libraries of the original distribution. 
You only have to call a single library.
	
As stovepipe system, stdlib integrates the original independent libraries 
in order to avoiding dependency hell. The main design goal of this library is to be 
small, correct, self contained and use few resources while retaining
the same performance and feature completeness than the original std and its
14 satellites libraries.
	
#***** Working with the library *****

You will find diagrams that will allow you to see at a glance the namespaces, 
objects and declarations contained in the stdlib sub-libraries. 
These diagrams are located in the _doc directory of the library.
	
#***** Legacy *****

Because stdlib is an experimental project, you can already base your prototype programs 
on this library, knowing that it will work identically with wx. 
	
Accompanied by sdklib and sdklib_mojo, you can write all the mx2 programs that were possible 
before stdlib. However, I advise you not to base commercial projects on stdlib, 
because a new library, much more powerful, considered as the next official library
of the mx2cc, will be released this year. So stay in touch, test stdlib, please report bugs 
and make suggestions during my ongoing coding/merge process of the next std 
(it will take a few months^^ ). Until the next big step of this std library, the
sub-libraries will be updated.

#***** Who is Mark Sibly? *****
	
stdlib is dedicated to Mark Sibly who has definitely left us 
since November 2024, honor and glory to you, o Great Master! 
Mark was an important contributor to the video game industry, 
not only a pioneer and co-inventor of middleware since the Amiga era 
who've paved the way for the unreal engine and other 'godot' but also the creator of 
the most used Amiga middleware that allows its retro-demoscene to exists today.
His contribution goes beyond his middlewares, 
think of all those retro-gaming videos on youtube and game licenses such as Worms 
that once benefited from Mark's products.

#***** Note from iDkP about stdlib *****

This library was created (compiled?) by iDkP from GaragePixel 
(attention, a little joker took my nickname on internet around 2015, 
it's iDkP from GaragePixel with stylized capitals). stdlib is intended for 
the Monkey2/Wonkey community, as your contributions have brought me many benefits.

The value of these sub-libraries, wraps, patches and additions will increase 
with the number of users, that's why I worked to reduce 
the barriers to understanding the library by creating some diagrams 
and simplify its use through stdlib.
