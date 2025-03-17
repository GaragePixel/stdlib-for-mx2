# Monkey2/Wonkey Syntax Guide for Aida 4 Integration
*Authored by iDkP from GaragePixel*
*2025-03-17*

## Purpose

This guide provides comprehensive syntax rules for developing applications with Monkey2/Wonkey when integrating with Monkey2/Aida 4/stdlib/sdk/sdk_mojo's programs and apps, following these conventions ensures optimal compatibility between your code and Aida's processing pipeline.

## Functionality

- Defines correct block structure termination (End, Wend, EndIf)
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

Try
	' Attempt Aida operation
Catch ex:Exception
	' Handle exception
End  ' Try blocks terminate with "End"
    Never Using "next" as a variable name
    Never using "local" as a variable name
    Never using "field" as a variable name
    Never Using "static" as a variable name
    Never Using "extension" as a variable name    
    Method definitions ended with "End"
    Function definitions ended with "End"
    Class definitions ended with "End"
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
    Field/Property/Method visibility uses standard modifiers (Public, Private, Protected)
    Mouse input accessed via Mouse.X, Mouse.Y, Mouse.ButtonDown(), etc.
    Constants use UPPERCASE_WITH_UNDERSCORES
    Method parameters use lowerCamelCase
    Class names use PascalCase
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

Following these syntax rules ensures optimal integration between your application, Monkey2, stdlib, sdk, sdk_mojo and Aida 4's advanced mathematic capabilities.
