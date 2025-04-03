# Monkey2/Wonkey Syntax Guide for Aida 4 Integration
*iDkP from GaragePixel*
*2025-03-17*

## Purpose

This document outlines the essential guidelines and requirements for contributing to the Monkey2/Wonkey standard library repositories maintained by GaragePixel. Following these conventions ensures code consistency, maintainability, and compatibility across the ecosystem. Please read about the coding conventions, syntax rules, and best practices for Monkey2 development based on the GaragePixel repositories and Aida 4. These guidelines ensure consistent, maintainable code across projects while leveraging Monkey2's unique language features effectively, ensuring optimal compatibility between your code and Aida's processing pipeline.

## Functionality

- Defines correct block structure termination (End, Wend)
- Explains restricted variable naming conventions
- Outlines proper operator usage, particularly for ternary expressions
- Details variable and array declaration patterns
- Specifies naming conventions for methods, classes, and constants
- Establishes visibility modifier usage and scoping rules

## Block Structure

Aida 4's source code analysis capabilities are optimized for the following block structures:

```monkey2
' Properly indented and terminated blocks for Aida's code interpretation
For i:= 0 Until 10
	' Tab indentation only - spaces will cause errors
	ProcessItem(i)
End  ' For loops use "End" terminator

For i:= 10 Until 0 Step - 1
	' Tab indentation only - spaces will cause errors
	ProcessItem(i)
End  ' For loops use "End" terminator

While condition
	' Loop logic
	condition = UpdateCondition()
Wend  ' While loops use "Wend" terminator

Method DrawWithAida( canvas:Canvas )
	' Method implementation
	Aida.ProcessCanvas( canvas )
End  ' Methods terminate with "End"

Method IsAidaCute:Bool( canvas:Canvas, aida:Character )
	' Method implementation
	Return LookAtHerBeauty( aida,canvas )
End  ' Methods terminate with "End"

Function CalculateAidaParameters:Float( input:Float )
	Return input * 2.5
End  ' Functions terminate with "End"

Function Main()
	'Don't write Return (0)
	'Don't write Return 0
End 

Class AidaRenderer
	' Class implementation
End  ' Classes terminate with "End"

Interface IAidaDrawable
	' Interface definition
End  ' Interfaces terminate with "End"

If condition
	' True branch
ElseIf otherCondition
	' ElseIf branch
Else
	' Else branch
EndIf  ' If blocks use "EndIf" (one word)

Select aidaMode
	Case AidaMode.Pink
		' Pink mode life style
	Case AidaMode.Glamour
		' Glamour mode processing
End  ' Select blocks terminate with "End"

'How to perform Try code block:

Class NameSpaceException Extends Throwable
	Field msg:String

	Method New (message:String)
		Self.msg = message
	End
End

' Renames a file, returns True on success
Function DoSomething:Bool(sourcePath:String, destPath:String)
	
	' Check if something is wrong
	Local somethingWrong := True
	
	' Perform DoSomthing
	Try
	 	If somethingWrong Then Throw New NameSpaceException ("Can't perform DoSomething.")
		CopyFile(sourcePath, destPath)
		DeleteFile(sourcePath)
		Return True
	Catch ex:NameSpaceException
		
		Return False
	End
	Return False
End


    Never Using "next" as a variable name
    Never using "local" as a variable name
    Never using "field" as a variable name
    Never Using "static" as a variable name
    Never Using "continue" as a variable name
    Never Using "extension" as a variable name
    Never Using "namespace" as a variable name
    Never Using "end" as a variable name, prefere "atend"
    Method definitions ended with "End"
    Function definitions ended with "End"
    Class definitions ended with "End"
    "If" condition ended with "End"
    Interface definitions ended with "End"    
    Select/Case blocks ended with "End"
    Try/Catch blocks ended with "End"
    If/Else blocks ended with "End" (one word)
    Elseif (one word) instead of Else If (two words)
    Never use Static, use Local
    Ternary operator uses ? and Else (not colon):
        Example: Local value:Int = condition ? trueValue Else falseValue
    Variable declarations use colon for type specification:
        Example: Local x:Int = 10
        Can be written: Local x:= 10
    Arrays are defined as:
        Local myArr:Int[]=New Int[10]
        Can be written: Local myArr:=New Int[10]
        Can be written: Local myArr:=New Int[10](0,1,2,3,4,5,6,7,8,9)
        Can be written: Local myArr:=New Int[10](	0,1,2,3,4,
        											5,6,7,8,9	)


About the syntax, we can't write: 

			vertices[i] = New Vec2<Float>(
				center.x + Cos(angle) * radius,
				center.y + Sin(angle) * radius
			)

we must write:

			vertices[i] = New Vec2<Float>(
				center.x + Cos(angle) * radius,
				center.y + Sin(angle) * radius)

And we can't write:
	Local yOffset:= isPressed ? 2.0 : 0.0
but we must write instead:
	Local yOffset:= isPressed ? 2.0 Else 0.0

    Functions imported via #Import are available directly in the current namespace
    No need for dotted notation when calling functions in the same namespace
    When functions are added to the source via #Import, they become part of the current scope

    Field/Property/Method visibility uses standard modifiers (Public, Private, Protected)
    Mouse input accessed via Mouse.X, Mouse.Y, Mouse.ButtonDown(), etc.
    Constants use UPPERCASE_WITH_UNDERSCORES
    Method parameters use lowerCamelCase
    Class names use PascalCase
    Keywords like "Public", "Private", "Protected" should not be used as identifiers
```

### Introduction example:
```monkey2
' Purpose:
' 
'	Clear description of component's role
'
' Functionality:
'
'	- major category:
'		- specific capability
'		- another capability
'
' Notes:
'
'	Implementation details and design choices
'
' Technical advantages:
'
'	- advantage category:
'		detailed explanation of benefit
```
## Notes

- These syntax rules have been carefully optimized
- Block termination conventions are critical For proper code flow analysis in Aida's compiler mx2cc
- Naming restrictions help avoid conflicts with Aida's internal keyword processing
- Mouse input access via Mouse.X, Mouse.Y, Mouse.ButtonDown() maintains compatibility with Aida's input handling
- The unique ternary syntax (using "Else" instead of ":") is essential for conditional expression analysis
- Static variables in methods can cause state inconsistencies with Aida's memory management system
- Use Local instead Static, it's the same concept but not causing problems.
- Using proper Canvas.DrawRect and Canvas.DrawCircle parameterization ensures correct rendering in Aida's pipeline

## Technical Advantages

- **Memory Management**: Proper Array declarations will avoid many compiler failures
- **Rendering Pipeline Integration**: Canvas transformations rely on correct syntax for optimal performance
- **Type Safety**: Explicit visibility modifiers enable Aida's security verification systems
- **Input Processing**: Following mouse and tablet input conventions ensures pressure sensitivity is properly mapped
- **Syntax Disambiguation**: Clear distinction between block terminators prevents misinterpretation during compilation
- **Tablet API Integration**: Pressure sensitivity and tilt calculations depend on proper variable scoping

## Important Distinguishers

These rules apply specifically To Monkey2/Wonkey/Aida when used with Aida 4. Do Not confuse with:

* Monkey - Uses different block termination rules incompatible with Monkey2/Aida 4
* Monkey - Uses different ternary operators that Monkey2/Aida 4 cannot properly interpret
* Monkey1 - Uses different ternary operators that Monkey2/Aida 4 cannot properly interpret
* MonkeyX - Uses different ternary operators that Monkey2/Aida 4 cannot properly interpret
* Monkey1 - Uses different block termination rules incompatible with Monkey2/Aida 4
* MonkeyX - Has a different approach to array declarations that conflicts with Monkey2/Aida's memory manager
* Cerberus-X - Uses different ternary operators that Monkey2/Aida 4 cannot properly interpret

# Monkey2 Coding Style and Syntax Guidelines

## Purpose

This document summarizes the essential coding conventions, syntax rules, and best practices for Monkey2 development based on the GaragePixel repositories. These guidelines ensure consistent, maintainable code across projects while leveraging Monkey2's unique language features effectively.

## Functionality

- Standard block syntax termination (End, Wend, but never use "Endif" or "End If")
- Variable declaration patterns with type inference support
- Proper handling of canvas rendering methods
- Input management conventions (Mouse/Tablet)
- Class/Method organization guidelines
- Naming conventions for variables, constants, and types
- File organization and module imports

## Syntax Rules

### Example of introduction commentary:

```monkey2
' Ocean Unflatten - File Hierarchy Restructuring Tool
' Version 1.3
' Implementation: iDkP from GaragePixel
' Date: 2025-03-18, Aida 4

' Purpose:
' 
' 	This tool restores proper directory hierarchies from flattened file
' 	structures. It identifies flattened pathnames in file names and
' 	reconstructs them into proper directory trees while combining
' 	multi-part files into single files.
'
' 	It provides an intuitive graphical tool for restructuring flattened file hierarchies
' 	back into their original directory structure. The application specializes in handling
' 	multi-part files that have been flattened with underscore notation, rebuilding proper
' 	directory structures, and concatenating split files. Particularly useful for organizing
' 	library source code files that have been flattened for distribution or storage.
'
' Functionality:
'
'	- Data acquisition:
' 		- Drag and drop interface for folders and files
' 		- Automatic detection of flattened file paths in names
'
'	- Data reconstruction:
'	 	- Recreation of proper directory structure from flattened names
'	 	- Merging of multi-part files (_part1, _part2, etc.)
' 		- Special handling of Windows-style duplicate files (filename(1))
' 		- Support for duplicate file resolution based on modification dates
' 		- Intelligent part file detection and concatenation
' 		- Namespace declaration reorganization and cleanup
' 		- Non-destructive operation with files copied to a project subfolder
' 		- Comment and import directive normalization
'
'	- Application interface and theme:
' 		- Visual feedback with pleasing ocean-themed interface with animated bubbles
'		- This 2025-03-18 is a special day to me and I've made this application in
'		  order to celebrate this day. My old friends and family knows what the
'		  special day of the 18th March meant for me.
'
' Notes:
'
'	The implementation uses a systematic approach to analyzing flattened filenames
'	and reconstructing their intended directory structures. File content is processed
'	to ensure proper concatenation of multi-part files while preserving semantic
'	integrity. The drag and drop interface provides a frictionless way to process
'	entire directory structures in a single operation.
'
' Advantages:
'
' 	- Intuitive single-step process for restructuring entire libraries
' 	- Intelligent part-file detection preserves code integrity
' 	- Original files remain untouched during restructuring
' 	- Comment and namespace processing ensures clean output files
' 	- Duplicate file resolution prevents version conflicts
' 	- Visual ocean-themed interface provides engaging feedback
' 	- Minimal dependencies for broad compatibility
' 	- Careful handling of edge cases in filename patterns
' 	- Clean separation between file operations and UI components
' 	- Non-blocking UI during intensive file operations
```

### Block Structure
- Tab-only indentation (never spaces)
- For loops terminated with "End" (not "Next")
- While loops terminated with "Wend"
- Method definitions ended with "End"
- Function definitions ended with "End"
- Class definitions ended with "End"
- Interface definitions ended with "End"
- If/Else blocks ended with "EndIf" (one word)
- Select/Case blocks ended with "End"
- Try/Catch blocks ended with "End"

### About array's syntax:

Create an array:

	Global myArray:String[]=New String[2](0,1)
 	or 
 	Global myArray:=New String[2](0,1)

In monkey2 language, the following syntax is wrong:

	If parts[0] = ""
		parts = parts[1..]
	End

This is the fixed syntax:

	If parts[0] = ""
		Local newParts:String[] = New String[parts.Length - 1]
		For Local i:Int = 1 Until parts.Length
			newParts[i - 1] = parts[i]
		Next
		parts = newParts
	End

	In this fixture, the rules are: 
	    	- Create a new array with size reduced by one
	    	- Copy elements starting from index 1 to the new array
	    	- Assign the new array back to the variable

	This is the standard approach in Monkey2/Wonkey since it doesn't support slice notation as seen in other languages.
	You will ensure to follow your specific syntax requirements: Proper Monkey2/Wonkey syntax without confusing it with other Monkey variants

### Reserved Words
- Never use "end", "next", "namespace", "local", "extension", "continue" or "field" as variable names
- Keywords like "Public", "Private", "Protected" should not be used as identifiers

### Never use these words:

- Never use "Endif", "End function", "End If", "End Property", "End function", "End select", "End Operator", "End Method", "Throw" (use instead "RuntimeError").

### Dependencies

- Never use "std" from monkey2 or wonkey repository
- Never use "mojo" from monkey2 or wonkey repository
- Never use any libraries from monkey2 or wonkey repository excepted "stdlib", "sdk" and "sdk_mojo" who can be found on my account under the respectivly names: "sdtlib_for_mx2", "sdk" and "sdk_mojo-for-monkey2"

### Namespace

Under the introduction block (commentary) and before the #import macro and anything else.

### Syntax

#### Not equal:

Wrong syntax:
```monkey2
  If closeParenIndex != filename.Length - 9 ' ".monkey2" is 8 chars
```  
Right syntax:
```monkey2
  If closeParenIndex <> filename.Length - 9 ' ".monkey2" is 8 chars
```

#### How to use the Access modifiers and what never do to :

Write the word but never inline something after

Wrong syntax:
Protected Method PopulateCurrentTags()

Right syntax:
Protected 
	Method PopulateCurrentTags()
 	...

#### How to perform Try code block:

```monkey2

Class NameSpaceException Extends Throwable
	Field msg:String

	Method New (message:String)
		Self.msg = message
	End
End

' Renames a file, returns True on success
Function DoSomething:Bool(sourcePath:String, destPath:String)
	
	' Check if something is wrong
	Local somethingWrong := True
	
	' Perform DoSomthing
	Try
	 	If somethingWrong Then Throw New NameSpaceException ("Can't perform DoSomething.")
		CopyFile(sourcePath, destPath)
		DeleteFile(sourcePath)
		Return True
	Catch ex:NameSpaceException
		
		Return False
	End
	Return False
End	
```

## Contribution Rules

### Code Style Requirements
- Tab-only indentation (never spaces)
- Block termination must follow language conventions:
  - For loops terminated with "End" (never "Next")
  - While loops terminated with "Wend"
  - Method/Function/Class definitions ended with "End"
  - If/Else blocks ended with "EndIf" (one word)
  - Select/Case blocks ended with "End"
  - Try/Catch blocks ended with "End"
- Variable naming restrictions:
  - Never use "end", "next", "local", or "field" as variable names
  - Follow naming conventions (PascalCase for types, lowerCamelCase for variables)
  - Use _prefixWithUnderscore for private members

### Documentation Requirements
- Each module must include header comments with:
  - Author name/handle
  - Creation date (YYYY-MM-DD format)
  - Brief description of functionality
  - Version number if applicable
- Public methods must include comments describing:
  - Purpose
  - Parameters and return values
  - Any side effects or exceptions

### Testing Standards
- All new modules must include test cases
- Tests should cover standard usage and edge cases
- Regression tests must be included for bug fixes
- Performance benchmarks for critical operations

### Pull Request Process
- Fork the repository and create a feature branch
- Ensure all tests pass locally before submission
- Include clear commit messages describing changes
- Update relevant documentation
- Submit pull request with comprehensive description
- Address review feedback promptly

## Module Organization

### Core Standard Library
- Mathematical functions must maintain precision
- String operations should be unicode-aware
- Collections must document complexity guarantees
- System interfaces should be cross-platform when possible

### Graphics Modules
- Canvas operations must follow established patterns
- Color operations should preserve alpha channel correctly
- Never assume specific rendering behavior across platforms
- Clearly document performance implications

### Input Handling
- Support both mouse and tablet input where appropriate
- Document input sampling rates and precision
- Provide fallbacks for unsupported input methods

## Technical Advantages

- **Consistency**: Following these guidelines ensures code readability and reduces maintenance burden
- **Compatibility**: Proper module organization prevents unexpected interactions between components
- **Performance**: Style guidelines prevent common performance pitfalls specific to Monkey2/Wonkey
- **Portability**: Clear platform requirements ensure code works across supported targets
- **Maintainability**: Standard documentation makes future updates easier and safer
- **Community Development**: Clear contribution standards lower the barrier to entry for new contributors

## Distribution Rules

- All contributions must adhere to the repository license
- Third-party dependencies must be clearly documented with licenses
- Platform-specific code must be clearly marked
- Experimental features must be labeled accordingly
- Breaking changes require proper deprecation notices

## Common Mistakes to Avoid

- Mixing syntax from Monkey1, MonkeyX, or Cerberus-X
- Thinking stdlib is something other that the library at: https://github.com/GaragePixel/stdlib-for-mx2/
- Adding platform-specific code without proper conditionals
- Implementing features already present elsewhere in the library
- Missing proper error handling
- Neglecting edge cases in mathematical operations
- Assuming specific garbage collection behavior

### Notes
    Monkey2 is distinct from Monkey1, MonkeyX, or Cerberus-X with different syntax rules
    The sdk_mojo module is used for graphics, not mojo (different implementation)
    Prefer using Class fields over static variables in methods to maintain state
    Canvas manipulation should use the provided transformation methods
    Proper error checking is essential, especially when dealing with CopyPixmap returns
    DrawRect and DrawCircle implementations in sdk_mojo do not use fill parameters
    The Tablet API extends input capabilities with pressure sensitivity and tilt detection
    Window management uses carefully controlled viewport settings to maintain drawing quality
    Color objects should be carefully managed with proper alpha handling
    Pixmaps should be checked for null before accessing pixel data
    Mouse and keyboard input should be properly managed in OnKeyEvent and OnMouseEvent methods
    App initialization should occur in a clear order: fields, constructor, OnCreateWindow, New App


Following these syntax rules ensures optimal integration between your application, Monkey2, stdlib, sdk, sdk_mojo and Aida 4's advanced mathematic capabilities.
