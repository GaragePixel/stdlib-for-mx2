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

The stdlib-for-mx2 repository is crucial for Mx2 as it enriches the language 
with a comprehensive set of tools and utilities, 
making it practical and powerful for modern application development.

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
[GitHub repository](https://github.com/blitz-research/monkey2) or [prebuild](https://blitzresearch.itch.io/monkey2)

## Is Monkey2 more powerful than GDScript (Godot)?

Absolutely. Monkey2 is far more powerful than GDScript in several ways:

- **Performance**: Monkey2 is compiled, while GDScript, like Lua and Python, is interpreted (Virtual Machine). This gives Monkey2/Wonkey a significant edge in terms of execution speed.
- **Language Features**: Monkey2 has a more robust type system, better modularity, and a richer [standard library](https://github.com/GaragePixel/stdlib-for-mx2/) compared to GDScript.
- **Scalability**: For larger, more complex projects (like a full Ink runtime), Monkey2 is better suited because of its efficiency and expressiveness.

However, I wouldn’t dismiss C# outright. C# is also a robust, high-performance language with strong tooling and a rich ecosystem. Monkey2/Wonkey and C# are much closer in terms of power and flexibility compared to GDScript.

## Difference from the old Monkey2 distribution:
 
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
	
As the creator of [Chipmunk2d](https://github.com/slembcke/Chipmunk2D/blob/master/TODO.txt) said in his TODO file:
	- "*Reorganize Chimpnuk* (sic) *Pro directory structure. Too flat and confusing.*"
	
## New implementation of the libraries for Monkey2:

This is why it was decided to redesign the standard library (``stdlib``), focusing on both file structure (``organization``) and namespace tree (``ergonomics``), with the aim of making it easy to use with minimal learning time (``affordance``).
		
'``Organization``', '``Ergonomics``', and '``Affordance``' were the three core concepts that guided the design of the stdlib. 
And also, stdlib contains itself. Apart from the language module, there is no need to integrate external elements, 
as all necessary components are now located in the plugins directory and will be periodically updated.

## Targets
### Desktop targets

| Windows                                | MacOS                                | Linux                                | Raspbian                                 |
| -------------------------------------- | ------------------------------------ | ------------------------------------ | ---------------------------------------- |
| ![](./_doc/img/icons/logo-windows.svg) | ![](./_doc/img/icons/logo-apple.svg) | ![](./_doc/img/icons/logo-linux.svg) | ![](./_doc/img/icons/logo-raspberry.png) |

### Mobile targets

| Android                                | iOS                                  |
| -------------------------------------- | ------------------------------------ |
| ![](./_doc/img/icons/logo-android.svg) | ![](./_doc/img/icons/logo-apple.svg) |

### Web targets

| Emscripten                                                   |
| ------------------------------------------------------------ |
| ![](./docs/img/icons/logo-html5.svg)![](./_doc/img/icons/logo-javascript.svg) |

## Why Choose stdlib-for-mx2?

- **Tailored for Mx2**: The `stdlib-for-mx2` is specifically designed for the Mx2 programming language, ensuring compatibility and optimized performance.
- **Ease of Use**: Built with Mx2 in mind, the standard library provides a more intuitive and seamless experience for Mx2 developers, reducing the learning curve.
- **Comprehensive Functionality**: The `stdlib-for-mx2` includes a wide range of utilities and functionalities essential for Mx2 applications, allowing you to build robust and efficient applications without needing third-party libraries.
- **Cross-Platform Support**: The library is designed to support cross-platform development, aligning with Mx2’s goal of creating cross-platform applications.
- **Community and Support**: Using a library specifically developed for Mx2 means you have access to a community of users and developers who are focused on the same language and tools, providing better support and resources.

In summary, the `stdlib-for-mx2` repository is crucial for Mx2 as it enriches the language with a comprehensive set of tools and utilities, making it practical and powerful for modern application development.
 
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
legacy distribution of Monkey at: https://blitzresearch.itch.io/monkey2
or from its repositiory: https://github.com/blitz-research/monkey2

1. **Place the Folder:**
   - Copy the `stdlib-for-mx2` folder into the `Monkey`'s `Modules` directory.
   - Rename the `stdlib-for-mx2` folder `stdlib`.

2. **Download Mx2cc:**
   - Ensure you have Mx2cc version 1.1.15. You can download it from the [last legacy distribution of Monkey](https://blitzresearch.itch.io/monkey2).

3. **Precompile Using Command Line:**
   - Rename the `stdlib-for-mx2` folder `stdlib`.
   - Open Command Prompt (cmd).
   - Navigate to the `bin` folder of your Monkey installation.
   - Run the following command to precompile the `stdlib` for desktop target in release mode:
     ```sh
     mx2cc_windows.exe -makemods stdlib -target=desktop -config=release
     ```
   - The precompilation should take approximately:
     - 2 minutes and 13 seconds for release mode.
     - 2 minutes and 20 seconds for debug mode.

4. **Precompile for other Targets:**
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

This array compare the executable's file with Mx2cc against the new Wx2cc:
| Test Name      | Old size | New size |    %    |
|----------------|----------|----------|---------|
| HelloWorld     |  183 KB  |   49 KB  |  -73%   |
| wide           | 16.5 MB  |  9.7 MB  |  -41%   |
| wake           |  6.9 MB  |  3.2 MB  |  -54%   |
| PromptInvasion |  6.7 MB  |  3.7 MB  |  -45%   |
| Billiards/Pool |  7.2 MB  |  4.0 MB  |  -44%   |
| Commanche      |  6.0 MB  |  3.3 MB  |  -45%   |
| GridShooter    |  6.3 MB  |  3.4 MB  |  -46%   |
| Life           |  6.0 MB  |  3.3 MB  |  -45%   |
| Particles      |  6.0 MB  |  3.3 MB  |  -45%   |
| Shoot-Out      |  6.1 MB  |  3.4 MB  |  -44%   |
| SimpleLight    |  6.0 MB  |  3.3 MB  |  -45%   |
| StarGate       |  8.8 MB  |  4.6 MB  |  -48%   |
| Toy-Plane      | 10.1 MB  |  5.3 MB  |  -48%   |
| VSynth         |  6.3 MB  |  3.4 MB  |  -46%   |
| 3d: test-scene | 12.2 MB  |  9.6 MB  |  -21%   |
| 3d: shapes     | 10.1 MB  |  5.4 MB  |  -47%   |
| dockingviewtest|  8.6 MB  |  3.6 MB  |  -58%   |

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

# Why stdlib is better than the legacy std

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

## Contributors:
- Mark Sibly (blitz-research) (New Zealand)
- DarkTwister (Vicente Damiani Benitez) (swedish)
- Hezkore (Marcus Streicher) (uruguayan)
- RustyStriker
- MikeHart
- TheCodeRunner 
- Derron 
- skn3 (Simon Armstrong) (british)
- Seyhajin (fr)
- Nobuyuki 
- iDkP
- Skid (Vladislav Poberezhny)
- Adam/AdamRedwood/CallMeAdam (german)
- Danilo (german)
- DoctorWhoof (Ethernaut) present since Monkey1 era and before, adapt in October 28, 2017 the idiosyncratic plane-demo. This type of community contribution served To demonstrate Monkey2's capabilities beyond 2D game development, showcasing its potential for 3D applications and providing a learning resource for other developers in the ecosystem.
- skn3 (Simon Armstrong) is indeed a contributor To the Monkey2/Wonkey ecosystem. His GitHub profile is https://github.com/skn3.

## Studios:

### Playniax
- **Key Person:** Leon van Kammen  
- **Key Products:**  
	- *Space Wars Tactics* (demo)  
	- *Playniax Retro Arcade Framework*  
- **Technical Notes:**  
	- Leon is a major Monkey2/Wonkey supporter, releasing multiple game frameworks and tools.
	- He published many engine/utility modules and demos, notably [Playniax GitHub](https://github.com/playniax).
	- Famous for "Playniax Framework" (cross-platform retro/arcade engine for Monkey2).

---

### Brucey
- **Key Person:** Bruce A Henderson  
- **Key Products:**  
	- *Monkey2 Physics Module*  
	- *Monkey2 Examples/Bindings*  
- **Technical Notes:**  
	- Maintainer of the official [Monkey2 modules repo](https://github.com/blitz-research/monkey2), including physics, OpenGL, and more.
	- Provided critical Windows, Mac, Linux, and Android support and bugfixes.
	- Many official example games and apps are authored by Brucey.

---

### Playniax Community Projects
- **Key Product:**  
	- *Rocket-Battle* (arcade example, open source)  
- **Technical Notes:**  
	- Demonstrates Monkey2’s 2D capabilities, uses Playniax’s own engine extensions.
	- Repository: [Rocket-Battle](https://github.com/playniax/rocket-battle)

---

### GaragePixel (iDkP)
- **Key Person:** GaragePixel (iDkP)  
- **Key Products:**  
	- *SDK_Games for Monkey2* (extensive parser and runtime libraries for IF/Ink)  
	- *STDLib-for-mx2* (Monkey2/Wonkey compatible extensions and replacements)  
- **Technical Notes:**  
	- Major contributor to Monkey2/Wonkey ecosystem, providing new language support, runtime systems, and extensive documentation.
	- Public repos: [GaragePixel SDK_Games](https://github.com/GaragePixel/sdk_games_for_monkey2), [GaragePixel STDLib-for-mx2](https://github.com/GaragePixel/stdlib-for-mx2)

---

### Community Indie Devs and Notables

#### Marcus "Mark Sibly" Sibly  
- **Key Product:**  
	- *Monkey2 Language & IDE*  
- **Technical Notes:**  
	- Creator of Monkey2/Wonkey and original Monkey/BlitzMax author.
	- Published sample games and IDE tools, but does not release commercial games personally.

#### "Mik" (Michael Hartlef)
- **Key Products:**  
	- *Weltall* (Monkey2 2D space game, open source)  
- **Technical Notes:**  
	- Regular forum contributor, released [Weltall](https://github.com/mikedev/Weltall) as a real finished example.

## Notes

- Most Monkey2/Wonkey commercial usage is by small indies, hobbyists, and tool-makers.
- Some projects (e.g. Playniax demos, Weltall, GaragePixel SDKs) are full games or major frameworks, and their code is publicly available on GitHub.

## MonkeyX / Monkey1

#### Gloomywood Founded: 2014 
- **Founder:** Frédéric Raynal
- **Location:** Montpellier, France
- **Key product:**
	- *2Dark* was developed by Gloomywood, a studio founded by Frédéric Raynal specifically for this project. The game represents one of the most commercially significant applications of the original Monkey language (MonkeyX/Monkey1). Despite 2Dark being developed with Monkey1/MonkeyX rather than Monkey2/Wonkey, its commercial success demonstrates the production viability of the Monkey language ecosystem For focused game development targeting specific platforms. The game was published by Bigben Interactive (now Nacon) following a successful Kickstarter campaign that raised approximately €40,000, though this represented only part of the total development funding.
- [Steam link](https://store.steampowered.com/app/435100/2Dark/)
- **Key Person:** Frédérique Reynal

### Shadow (Simon Armstrong)
- **Key Products:**  
	- *Bananen Joe* (Monkey1, 2011)  
	- *Shadow's Retro Platformer Engine* (Monkey1/MonkeyX)  
- **Technical Notes:**  
	- Early adopter and forum contributor, released several games and engines for Monkey1/MonkeyX.

---

### Playniax (MonkeyX)
- **Key Products:**  
	- *Playniax Framework for MonkeyX*  
	- *Gravitrix* (MonkeyX, 2013)  
- **Technical Notes:**  
	- Multiple frameworks and 2D/3D engines for Monkey1 and MonkeyX.

---

### Blitzwerk (Denis Cerny)
- **Key Products:**  
	- *Space Invaders Clone* (MonkeyX)  
	- *Platformer Engine* (MonkeyX)  
- **Technical Notes:**  
	- Open source examples, tools, and code on the old MonkeyX forums and GitHub.

---

### SteeG (Stefan Egger)
- **Key Products:**  
	- *Several Puzzle and Platform Games* (MonkeyX)  
- **Technical Notes:**  
	- Regular MonkeyX/Monkey1 contributor, released finished games and engines for educational use.

---

### Mark Sibly  
- **Key Products:**  
	- *Monkey1 Language and Tools*  
- **Technical Notes:**  
	- Founder and primary creator of Monkey1/MonkeyX and Blitz series.

---

## Notes

- **Monkey2/Wonkey** projects tend to be modern, using C++11 backends, and target cross-platform desktop and mobile natively.
- **Monkey1/MonkeyX** projects are historically Flash, HTML5, and desktop, with a strong retro/indie focus.
- Many early indie games, frameworks, and demos for Monkey1/MonkeyX can still be found on the old [monkeycoder.co.nz](https://web.archive.org/web/20150906105334/http://www.monkeycoder.co.nz/) forums and [GitHub](https://github.com/search?q=monkeyx).
- Notable others: "Bignic" (known for music tools and simple games), "MauroG" (experimental 3D engines), "BabaYaga" (various small games and experiments).
- Some games/products were demos, frameworks, or educational and not always commercial releases.

# Note from iDkP about stdlib

This library was created (compiled?) by iDkP from GaragePixel 
(attention, a little joker took my nickname on internet around 2015, 
it's iDkP from GaragePixel with stylized capitals). stdlib is intended for 
the Monkey2/Wonkey community, as your contributions have brought me many benefits.

The value of these sub-libraries, wraps, patches and additions will increase 
with the number of users, that's why I worked to reduce 
the barriers to understanding the library by creating some diagrams 
and simplify its use through stdlib.

# Note from iDkP about Sibly's Mx language

I know Blitz3D, BlitzPlus, BlitzMax, Monkey and Monkey2. Like many, my journey started with QBasic. 
I discovered Mark's creations during my short but fruitful career as a 3D modeler, 
before the dawn of Google, in the days of DarkBasic and the like. 
I was a user of ClickTeam software which was Mark's direct competitor since the Amiga days, 
but from Click & Play to MultiMedia Fusion, they seemed limited and poorly designed for my needs. 
I also know that Mark had created something before Blitz when I was drawing my first RPGs on paper. 
I joined the Blitz3D community in 2004 and have bought all of Mark's products since then.

In my opinion, the decline of Blitz Research began after BlitzMax, when the new languages ​​(Monkey, Monkey2) 
stopped compiling to native code. Few people were interested in these new tools, 
and only a small group followed Mark who was the visionary of the time. 
This was before the rise of gobot and similar technologies. 
Within a once thriving community, only a few ventured into the new areas. 
Perhaps users did not want tools that looked like simple "to C++" translators.

But let's be honest, development tools have evolved considerably in the last 15-20 years. 
Back then, they were mostly closed-source commercial software 
(Visual Studio, PureBasic, BlitzBasic/3D, PowerBasic, Clickteam products etc). 
Today, the industry has moved towards free open-source programming languages, 
IDEs, and countless libraries. Almost everything is free now. 
PureBasic still exists, although it is a niche closed-source product. 
PowerBasic (its creator having left) and the entire Blitz-Research line... 
have all disappeared in the meantime.

If you've used godot over the years, you know that with a strong team and internal communication, 
great 3D capabilities, and a robust copy of 3D Studio's internal code, 
godot has raised significant funding and outperformed formidable opponents 
like Autodesk's Stingray or CrystalSpace. 
But when you want to tackle really complex tasks, like porting a NES emulator, 
gscript may not be the best choice. 
You can turn to C#, but probably later to Sibly's Mx2 when you get tired of an 
old-fashioned brace-powered punched-card language. I don't like braces. They drive me crazy.

Braces drive me crazy.

I've worked with JS, JSX, MaxScript, and other brace-based languages ​​(although 
MaxScript uses parentheses like Lisp). 
Yet on my keyboard, using AltGr+= and AltGr+' all the time is a pain. 
Mark's languages ​​always felt like I was in a cozy bed with warm blankets. 
A family of languages ​​where keystrokes were minimal, except for the occasional |. 
Mx2/Wonkey will never become a brace language.

Regarding the syntax of Mx1, when planning the cross-platform compiler, 
Mark always said that case insensitivity did not fit with C++ internals, 
which caused problems with BlitzMax, leading to the creation of Mx1. 
Mx2 introduced advanced features like reflection, first-class functions, 
and operator overloading, which were not possible with Monkey-X or its forks. 
Using Mx1 or its forks feels like going back to the Middle Ages. 
Mx2/Wonkey is the best choice today because it compiles to native C/C++, 
unlike some non-free and non-open products like Delphi (a virtual machine-based language). 
It is now essential to provide Mx2 with a real standard library and SDK, 
as well as modern and functional libraries. 
The language is therefore now optimized for various uses 
like software creation and building AI for embedded applications.

# License

This repository is licensed under the MIT License. See the [LICENCE](https://github.com/GaragePixel/stdlib-for-mx2/blob/main/LICENCE) file for more information.

# Contact

If you have any questions or suggestions, feel free to open an issue or contact the repository owner.
