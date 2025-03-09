<div align="center">
	<h1>Mx2</h1>
	<p><strong>Mx2</strong> is a easy to learn, oriented object, modern programming language for creating cross-platform applications.</p>
	<img src="title.svg" alt="Large Title Example">
</div>

[![Build Status](https://img.shields.io/github/actions/workflow/status/GaragePixel/stdlib-for-mx2/ci.yml?branch=main)](https://github.com/GaragePixel/stdlib-for-mx2/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Code Coverage](https://img.shields.io/codecov/c/github/GaragePixel/stdlib-for-mx2/main.svg)](https://codecov.io/gh/GaragePixel/stdlib-for-mx2)
[![Issues](https://img.shields.io/github/issues/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/issues)
[![Forks](https://img.shields.io/github/forks/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/network/members)
[![Stars](https://img.shields.io/github/stars/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/stargazers)
[![Watchers](https://img.shields.io/github/watchers/GaragePixel/stdlib-for-mx2)](https://github.com/GaragePixel/stdlib-for-mx2/watchers)
![Views](https://views.whatilearened.today/views/github/wonkey-coders/wonkey.svg)

[Mark Sibly](https://github.com/blitz-research), [Monkey coders](https://github.com/wonkey-coders) and [iDkP from GaragePixel](https://github.com/GaragePixel)

Please read the licence contained in the [LICENCE](https://github.com/GaragePixel/stdlib-for-mx2/blob/main/LICENCE) file of this distribution.

# The Project you can consult (roadmap, etc)

https://github.com/users/GaragePixel/projects/2/views/3

## Repository Details
- **Repository URL**: [stdlib-for-mx2](https://github.com/GaragePixel/stdlib-for-mx2)
- **Repository ID**: 940956438
- **Description**: Standard library for Mx2
- **Primary Language**: C (85.2%)
- **Additional Languages**:
  - C++ (4%)
  - Objective-C (3.3%)
  - Monkey (2.3%)
  - Roff (1.8%)
  - Assembly (1.3%)
  - Other (2.1%)

# This library is written for a specific language

Mx2 is a language and a transpiler from the Blitz family languages 
released by Mark Sibly in 2018 as a CPSM 
[(Wikipedia)](https://en.wikipedia.org/wiki/Cross-platform_support_middleware).
It's general-purpose, open-source, user-friendly and cross-platform:
[GitHub repository](https://github.com/blitz-research/monkey2)
	
The original package comes with a number of modules, all essential 
but relatively scattered and lost in the module folder. 
	
These libraries are independent implementations with no shared source code, 
historically these implementations have not evolved from a common project. 
There are 14 vital libraries littering the module directory, 
but we find two libraries to be the most important:
	
- **Core-language library:** Contains the front-end of the language.
- **Standard library (std):** Provides access to essential features for writing programs. 
		
The standard library has a flat namespace structure, as designed by Sibly, 
which makes it challenging for beginners 
and even for production use to fully exploit this 'standard library'.
	
As the creator of Chipmunk said in his TODO file:
	- "*Reorganize Chimpnuk* (sic) *Pro directory structure. Too flat and confusing.*"
	
This is why it was decided to redesign the standard library (``stdlib``), focusing on both file structure (``organization``) and namespace tree (``ergonomics``), with the aim of making it easy to use with minimal learning time (``affordance``).
		
'``Organization``', '``Ergonomics``', and '``Affordance``' were the three core concepts that guided the design of the stdlib. 
And also, stdlib contains itself. Apart from the language module, there is no need to integrate external elements, 
as all necessary components are now located in the plugins directory and will be periodically updated.
	
# stdlib breaks compatibility with the current distribution of mojo

stdlib comes with two supplements, one called ``sdk`` contains all the essential
modules to creating a program.
		
Because mojo - the legacy graphic framework of the language build on sdl2 - cannot work 
directly with ``stdlib``, ``sdk_mojo`` contains an update of Mojo, adapted to work with ``stdlib``. 
``stdlib`` itself don't need ``sdk_mojo``, the same for ``sdk``.
		
You can get a copy of the ``sdk`` at this address: https://github.com/GaragePixel/sdk
And a copy of the ``sdk_mojo`` at this address: https://github.com/GaragePixel/sdk_mojo-for-monkey2

# How to Set Up and Precompile stdlib

Place the folder in the Monkey's Modules directory and precompile the library. 
You'll need the Mx2cc version 1.1.15, it can be downloaded with the last
legacy distribution of Monkey at: https://github.com/blitz-research/monkey2

1. **Place the Folder:**
   - Copy the `stdlib` folder into the `Monkey`'s `Modules` directory.

2. **Download Mx2cc:**
   - Ensure you have Mx2cc version 1.1.15. You can download it from the [last legacy distribution of Monkey](https://github.com/blitz-research/monkey2).

3. **Precompile Using Command Line:**
   - Open Command Prompt (cmd).
   - Navigate to the `bin` folder of your Monkey installation.
   - Run the following command to precompile the `stdlib` for desktop target in release mode:
     ```sh
     mx2cc_windows.exe -makemods stdlib -target=desktop -config=release
     ```
   - The precompilation should take approximately:
     - 2 minutes and 13 seconds for release mode.
     - 2 minutes and 20 seconds for debug mode.

4. **Precompile for Other Targets:**
   - `stdlib` can also be compiled for HTML5 via Emscripten, Android, and Raspberry Pi.
   - Note: iOS is not supported and likely will never be for ethical reasons.

5. **Using Ted2Go for Precompilation:**
   - Open Ted2Go.
   - Navigate to `Build > Update / Rebuild modules`.
   - Select the `stdlib` module and click `Update`.

6. **Organizing Modules:**
   - If you have `sdk` and `sdk_mojo` in your `Modules` folder, you can move old modules to a subdirectory named `legacy_modules`.
   - This will prevent interference with `stdlib`, `sdk`, and `sdk_mojo` and keep your `Modules` folder clean.
   - Ensure the `monkey` module remains in the `Modules` folder.

7. **Batch Precompilation Using Ted2Go:**
   - With `Monkey`, `stdlib`, `sdk`, and `sdk_mojo` in your `Modules` folder:
     - Open Ted2Go.
     - Navigate to `Build > Update / Rebuild modules`.
     - Select all libraries and click `Update`.
     - This process will take around 23 minutes if compiling only for the Windows platform, in both release and debug modes.

8. **Alternative Command Line Precompilation:**
   - Open Command Prompt (cmd).
   - Navigate to the `bin` folder of your Monkey installation.
   - Run the following command for Windows:
     ```sh
     mx2cc_windows.exe -makemods -target=desktop -config=release
     ```
   - Alternatively, for Linux, use:
     ```sh
     mx2cc_linux -makemods -target=desktop -config=release
     ```
# stblib's origin and goal
	
The development of the Mx2 compiler continued under the guidance of 
[seyhajin](https://github.com/seyhajin)
 and  [D-a-n-i-l-o](https://github.com/D-a-n-i-l-o), evolving into what is now known as the Wx compiler. 
While stdlib is set to be adapted for the Wx compiler soon, 
you can already test it with the Mx compiler version 1.1.15 
from the last official release by Sibly in September 2018. Check it out [here](https://github.com/blitz-research/monkey2/blob/develop/VERSIONS.TXT).

Without the Wx2cc code cleaner, which cleverly omits unused code blocks, 
the Mx2cc stdlib churns out a 1.46 MB executable file, embedding a few of its DLLs. 
With Wxcc, the stdlib-generated executable will be remarkably leaner. 
Think of stdlib as 'legacy' (iDkP's contribution was a minuscule 0.0001% of the codebase).

Stdlib delivers an implementation with efficiency on par with the original std 
and its 14 satellite libraries. You only need to call a single library.

Functioning as a stovepipe system, stdlib integrates the original independent libraries, 
expertly sidestepping dependency hell. The primary design goal of this library is 
to remain compact, precise, self-contained, and resource-efficient, 
while preserving the same performance and comprehensive features as the original std 
and its 14 satellite libraries.
 
# Working with the library

Dive into the world of stdlib with ease and clarity. 
Explore the comprehensive diagrams that map out namespaces, objects, and declarations 
within the stdlib sub-libraries. These visual guides are conveniently located in the `_doc` directory, 
providing a clear overview at a glance.

# Sub-Libraries

The standard library is divided into several sub-libraries, each targeting a specific area of functionality:

- stdlib/collections
  - Basic data structures and algorithms
- stdlib/io
  - Data-driven Input and output operations.
- stdlib/algorithms
  - Compression, cryptographic and decoding/encoding functions.
- stdlib/math
  - Basic datatypes and math functions
- stdlib/platforms
  - APIs from the target platforms where compilation is possible.
- stdlib/plugin:
  - The `plugins` directory contains several subdirectories and files that are essential for various plugin functionalities:
   - jni: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/jni)
   - libc: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/libc)
   - miniaudio: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/miniaudio)
   - miniz: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/miniz)
   - sdl2: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/sdl2)
   - stb: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/stb)
   - tinyxml2: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/tinyxml2)
   - zlib: [View directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins/zlib)
   
   For further details, you can explore the directory on GitHub: [plugins directory](https://github.com/GaragePixel/stdlib-for-mx2/tree/main/plugins).
- stdlib/ressources
  - How the library memory handles audio and graphic primitives (like pixmaps).
- stdlib/system
  - Core functionalities and utilities, including file handling and data serialization.
  - Networking functionalities, including socket programming and HTTP operations.

# Why This Library Is Better

- **Comprehensive Documentation:** Detailed documentation and examples make it easy to learn and use the library.
- **Cross-Platform Support:** Designed to work seamlessly across multiple platforms, including Windows, mac, Linux and Rapsberry.
- **Active Development:** Regular updates and improvements ensure that the library stays current with the latest developments in the Mx2 language.
- **Broad Functionality:** Covers a wide range of functionalities, from basic data structures to advanced mathematics and networking support.

By leveraging the stdlib-for-mx2, developers can enhance their productivity and build robust applications with the Mx2 programming language.
 
# Legacy

The stdlib-for-mx2 is currently an experimental project, 
and you can use it to build your prototype programs with confidence, 
knowing that it will work identically with wx.

With the support of sdklib and sdklib_mojo, 
you can create all the Mx2 programs that were possible before the introduction of stdlib. 
However, it is advisable not to base commercial projects on stdlib at this time 
because a new, more powerful library, which is expected to become 
the next official library of mx2cc, is scheduled for release later this year.

Please stay engaged, test stdlib, and report any bugs or suggestions as we continue the development 
and merging process for the next standard library (it will take a few months^^ ). 
Until the next big step of this std library, the
sub-libraries will be updated.

# Who is Mark Sibly?
	
The stdlib project is dedicated to the memory of [Mark Sibly](https://github.com/blitz-research),
who sadly passed away in November 2024. Mark was a visionary in the video game industry, 
leaving an indelible mark as a pioneer and co-inventor of middleware since the Amiga era. 
His early work laid the groundwork for modern engines like unreal and other 'godot'.

Mark's contributions went far beyond middleware; 
he created the most widely used Amiga middleware, 
which continues to support the retro-demoscene today. 
His influence extends to countless retro-gaming videos on YouTube 
and beloved game franchises like Worms, 
which once thrived on the strength of Mark's innovations. 
Honor and glory to you, O Great Master!

# Note from iDkP about stdlib

This library was created (compiled?) by iDkP from GaragePixel 
(attention, a little joker took my nickname on internet around 2015, 
it's iDkP from GaragePixel with stylized capitals). stdlib is intended for 
the Monkey2/Wonkey community, as your contributions have brought me many benefits.

The value of these sub-libraries, wraps, patches and additions will increase 
with the number of users, that's why I worked to reduce 
the barriers to understanding the library by creating some diagrams 
and simplify its use through stdlib.

# License

This repository is licensed under the MIT License. See the [LICENCE](https://github.com/GaragePixel/stdlib-for-mx2/blob/main/LICENCE) file for more information.

# Contact

If you have any questions or suggestions, feel free to open an issue or contact the repository owner.
