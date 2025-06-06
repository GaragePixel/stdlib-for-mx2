# Monkey2/Wonkey Syntax Guide for Aida 4 Integration
*iDkP from GaragePixel*
*2025-03-17*

## Purpose

This document outlines the essential guidelines and requirements for contributing to the Monkey2/Wonkey standard library repositories maintained by GaragePixel. Following these conventions ensures code consistency, maintainability, and compatibility across the ecosystem. Please read about the coding conventions, syntax rules, and best practices for Monkey2 development based on the GaragePixel repositories and Aida 4. These guidelines ensure consistent, maintainable code across projects while leveraging Monkey2's unique language features effectively, ensuring optimal compatibility between your code and Aida's processing pipeline.

Good pratice: https://github.com/GaragePixel/stdlib-for-mx2/tree/main/io/tablet

## Functionality

- Defines correct block structure termination (End, Wend)
- Explains restricted variable naming conventions
- Outlines proper operator usage, particularly for ternary expressions
- Details variable and array declaration patterns
- Specifies naming conventions for methods, classes, and constants
- Establishes visibility modifier usage and scoping rules

## Keywords (Forbidden Variable Names)

```
Abstract, Alias, And, Array, As, Assert, Bool, Case, Cast
Catch, Class, Const, Continue, Default, Delete, Delegate
Dim, Do, Downto, EachIn, Else, ElseIf, End, EndIf, Enum
Exit, Extends, Extern, False, Field, Final, Float, For
Forever, Friend, Function, Get, Global, Goto, If, Implements
Import, In, Inline, Int, Interface, Internal, Local, Method
Mod, Module, Namespace, Native, New, Next, Nil, Not, Null
Object, Operator, Or, Override, Private, Property, Protected
Public, Ptr, Repeat, Return, Select, Self, Set, Shared
Short, Shl, Shr, Static, Step, String, Struct, Super, Then
Throw, To, True, Try, Type, Until, Using, Var, Variant
Virtual, Void, Where, While, With, Wend
```

## Pattern Framework

Critical patterns for Monkey2 syntax:

### Class Pattern
```monkey2
Class [ClassName] [Extends BaseClass] [Implements Interface1, Interface2]

	[AccessModifier] (public aera)

	Field [ClosureName]:Void(Type) ' Declare an closure

	[AccessModifier] (public aera)
	
	' Constructor
	Method New([parameters])
		[initialization]
		[closure initialization (assignation) if any]
	End
	
	' Methods (usual method like factories)
	Method [name]:[ReturnType]([parameters])
		[implementation]
	End
	
	' Subclasses (can be nested containers for static function calling, or dynamically created)
	Class [ClassName] [Extends BaseClass] [Implements Interface1, Interface2]
		[Implementation]
	End

	' Properties
	Property [name]:[Type]()
		Return [fieldName]
	End

	Property [name]:[Type]()
		Return [fieldName]
	Setter([value]:[Type])
		[fieldName] = [value]
	End

	' Methods (custom method more related to the class)
	Method [name]:[ReturnType]([parameters])
		[implementation]
	End
	
	' Function (static method)
	Function [name]:[ReturnType]([parameters])
		[implementation]
	End
	
	' Global variables (static fields)
	Global [name]:[Type]

	' Constants (static and dynamic)
	Const _[constName]:[Type] = [value]

	' Fields
	Field _[fieldName]:[Type]
	
	[AccessModifier] (Private aera)

	' Global variables (static fields)
	Global _[name]:[Type]	
End
```

### Property Pattern
```monkey2
Property [Name]:[Type]()
    Return [field]
End

Property [name]:[Type]()
    Return [fieldName]
Setter([value]:[Type])
    [fieldName] = [value]
End
```

### Loop Patterns
```monkey2
' For loop
For [initialization] Until [condition] [Step]
    [Implementation]
End

' Foreach loop
For Each [item]:[Type] = EachIn [collection]
    [Implementation]
End

' While loop
While [condition]
    [Implementation]
Wend

' Repeat loop
Repeat 
    [Implementation]
Until [condition]

' Repeat loop
Repeat 
    [Implementation]
While [condition]

' Repeat loop
Local [esc]:Bool=False
Repeat 
    [Implementation] (before exit condition)
    If [condition to exit the loop] Exit (If [esc]=True Then Exit, more short: If [esc] Exit)
    [Implementation] (after exit condition if needed)
Forever

' For loop
For Local [var]:[Type] = [start] Until [end] [Step increment]
	[implementation]
End

' For loop
For Local [var]:[Type] = [start] Until [end] [Step decrement] (end<start)
	[implementation]
End

Local [nonlocalvar]:[Type]

For [nonlocalvar] = [start] Until [end] [Step increment]
	[implementation]
End

'Optimised
Local [nonlocalvar]:[Type]

For [nonlocalvar] = [start] Until [end] [Step increment]
	[implementation]
End

'Optimised
Local [nonlocalvar]:[Type]

For [nonlocalvar] = [start] Until [end] [Step decrement] (end<start)
	[implementation]
End

'Optimised with non recalculated [end]
Local [nonlocalvar]:[Type]
Local [end]:[Type]=[assignation for calculated end value]

For [nonlocalvar] = [start] Until [end] [Step increment]
	[implementation]
End

'Optimised with non recalculated [end]
Local [nonlocalvar]:[Type]
Local [end]:[Type]=[assignation for calculated end value]

For [nonlocalvar] = [start] Until [end] [Step decrement] (end<start)
	[implementation]
End

' For Each loop
For Each [item]:[Type] = EachIn [collection]
	[implementation]
End
```

### **Method Pattern**
```
Method [MethodName]:[ReturnType]([Parameters])
    [Implementation]
End
```

### **Constructor Pattern**
```monkey2
Method New([Parameters])
    [FieldAssignments]
End
```

### **If-Else Pattern**
```monkey2
If [Condition]
    [Implementation]
ElseIf [Condition]
    [Implementation]
Else
    [Implementation]
End
```

### **Switch-Case Pattern**
```monkey2
Select [Variable]
	Case [Value1]
	    [Implementation]
	Case [Value2]
	    [Implementation]
	Default
	    [Implementation]
End
```

### **Error Handling Pattern**
```monkey2
Try
    [Implementation]
Catch [Error]:[Type]
    [ErrorHandling]
End
```

### **Function Pattern**
```monkey2
Function [FunctionName]:[ReturnType]([Parameters])
    [Implementation]
End
```

### **Module Pattern**
```monkey2
Import [ModuleName]
[Implementation]
```

### **Field Initialization Pattern**
```monkey2
Field [FieldName]:[Type] = [InitialValue]
```

### **Lazy Initialization Pattern (Property with Backing Field)**
```monkey2
Field _[FieldName]:[Type]

Property [FieldName]:[Type]()
    If _[FieldName] = Null Then
        _[FieldName] = [Initialization]
    End
    Return _[FieldName]
End
```

### **Event Pattern**
```monkey2
Field [EventName]:Void(Type) ' Declare an event

Method [TriggerEventName](value:Type)
    If [EventName]<>Null [EventName](value)
End
```

### **File Structure Pattern**

```monkey2
Namespace [namespace]

#Rem
'===============================================================================
' [ClassName] - [Short Description]
' Implementation: by iDkP from GaragePixel
' Date: [YYYY-MM-DD], Aida 4
'===============================================================================
'
' Purpose:
'
' 	[Description of the purpose of the class. Explain its role in the system or
' 	how it solves a problem.]
'
' Functionality:
'
' 	- [List of main functionalities provided by the class.]
' 	- [Explain key features or methods.]
'
' Notes:
'
' 	[Detailed notes about the implementation, such as design decisions,
' 	integration with other components, or any constraints.]
'
' Technical advantages:
'
' 	- [Highlight standardization benefits or consistent design.]
' 	- [Explain any compatibility or performance improvements.]
'===============================================================================
#End


[content]
```

### **Module Import Pattern**
```monkey2
' Standard modules
Import "<stdlib>"
Import "<sdk_mojo>" (if graphism needed)
Import "<sdk>" (if advanced features needed)

' Custom modules
Import [custom.module.path]
```

### **Singleton Pattern**
```monkey2
Field _instance:[ClassName]

Function GetInstance:[ClassName]()
    If _instance = Null Then
        _instance = New [ClassName]()
    End
    Return _instance
End
``` 

### **Static Method Pattern**
```monkey2
Method [MethodName]:[ReturnType]([Parameters])
    Local [Variable]:[Type] = [InitialValue]
    [Implementation]
End
```

### **Inline Commenting Pattern**
```monkey2
[Code] ' [Short explanation of the code]
```

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
```
```monkey2
While condition
	' Loop logic
	condition = UpdateCondition()
Wend  ' While loops use "Wend" terminator
```
```monkey2
Method DrawWithAida( canvas:Canvas )
	' Method implementation
	Aida.ProcessCanvas( canvas )
End  ' Methods terminate with "End"
```
```monkey2
Method IsAidaCute:Bool( canvas:Canvas, aida:Character )
	' Method implementation
	Return LookAtHerBeauty( aida,canvas )
End  ' Methods terminate with "End"
```
```monkey2
Function CalculateAidaParameters:Float( input:Float )
	Return input * 2.5
End  ' Functions terminate with "End"
```
```monkey2
Function Main()
	'Don't write Return (0)
	'Don't write Return 0
End 
```
```monkey2
Class AidaRenderer
	' Class implementation
End  ' Classes terminate with "End"

Interface IAidaDrawable
	' Interface definition
End  ' Interfaces terminate with "End"
```
```monkey2
If condition
	' True branch
ElseIf otherCondition
	' ElseIf branch
Else
	' Else branch
End  ' If blocks use "End" (one word)
```
```monkey2
Select aidaMode
	Case AidaMode.Pink
		' Pink mode life style
	Case AidaMode.Glamour
		' Glamour mode processing
End  ' Select blocks terminate with "End"
```
```monkey2
'How to perform Try code block:
Class NameSpaceException Extends Throwable
	Field msg:String

	Method New (message:String)
		Self.msg = message
	End
End
```
```monkey2
' Renames a file, returns True on success
Function DoSomething:Bool(sourcePath:String, destPath:String)
	
	' Check if something is wrong
	Local somethingWrong := True
	
	' Perform DoSomthing
	Try
	 	If somethingWrong Throw New NameSpaceException ("Can't perform DoSomething.")
		CopyFile(sourcePath, destPath)
		DeleteFile(sourcePath)
		Return True
	Catch ex:NameSpaceException
		
		Return False
	End
	Return False
End
```

- Try-Catch Block Structure
```
    Try block initialization with Try
    Exception catching with Catch
    Proper block termination with End (not End Try)
    Exception typing and handling mechanics
```
- Block Termination Consistency
```
    Functions terminate with End
    Methods terminate with End
    Classes terminate with End
    Try blocks terminate with End
    For loops terminate with End
    While loops terminate with Wend
    If blocks terminate with End
```
- Never use:
```
    Never use "next" as a variable name
    Never use "not" as a variable name
    Never use "void" as a variable name
    Never use "super" as a variable name
    Never use "cast" as a variable name
    Never use "cast" as a method name
    Never use "cast" as a function name
    Never use "local" as a variable name
    Never use "field" as a variable name
    Never use "static" as a variable name
    Never use "continue" as a variable name
    Never use "extension" as a variable name
    Never use "namespace" as a variable name
    Never use "end" as a variable name, prefere "atend"
    Never use "Pointer" for naming a method, class, a variable, a value or a namespace
    Never use "not" as a method name
    Never use Static, use Local
    Never use '* or other shits, a one-line commentary begins with ' in Monkey2 language
    Never use a reserved word for naming a member.
    Never use "Int" to name a member.
    Never use "Float" to name a member.
    Never use "Bool" to name a member.
    Never use "String" to name a member.
    Never use "Mod" to name a member.
    Never use "New" to name a member.
    Never use "Throw" to name a member.
    Never use "Case" to name a member.
    Never use "Select" to name a member.
    Never use "If" to name a member.
    Never use "Method" to name a member.
    Never use "Else" to name a member.
    Never use "Elseif" to name a member.
```
- Always use:
```
    Method definitions ended with "End"
    Function definitions ended with "End"
    Class definitions ended with "End"
    "If" condition ended with "End"
    Interface definitions ended with "End"    
    Select/Case blocks ended with "End"
    Try/Catch blocks ended with "End"
    If/Else blocks ended with "End" (one word)
    Elseif (one word) instead of Else If (two words)

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
```
About the syntax, we can't write: 
```monkey2
			vertices[i] = New Vec2<Float>(
				center.x + Cos(angle) * radius,
				center.y + Sin(angle) * radius
			)
```
we must write:
```monkey2
			vertices[i] = New Vec2<Float>(
				center.x + Cos(angle) * radius,
				center.y + Sin(angle) * radius)
```
#### The array declaration/assignation: ####
Don't do:
```monkey2
Local numbers:Int[] = [1, 2, 3, 4, 5]
```
Do instead:
```monkey2
Local numbers:Int[] = New Int[](1, 2, 3, 4, 5)
```
Or:
```monkey2
Local numbers:=New Int[](1, 2, 3, 4, 5)
```

The **slice syntax** (e.g., `array[1..]`) is common in many programming languages like Python, JavaScript, or Ruby, but it is **not supported in Monkey2/Wonkey**. Here's an explanation of how it works in general, why it is disallowed in Monkey2, and how to handle such cases in Monkey2.

---

#### The array's Slice Syntax: ####

##### **What is Slice Syntax?**
Slice syntax allows you to extract a subset of elements from an array or list using a specific range of indices. For example:

- **In Python**:
  ```python
  my_array = [1, 2, 3, 4, 5]
  sliced_array = my_array[1:]  # Extracts [2, 3, 4, 5]
  ```
  - `my_array[1:]` means "start at index `1` and take all elements to the end."
  - Similarly, `my_array[:3]` means "take all elements from the start up to (but not including) index `3`."

- **In JavaScript**:
  ```javascript
  let myArray = [1, 2, 3, 4, 5];
  let slicedArray = myArray.slice(1);  // Extracts [2, 3, 4, 5]
  ```

- **In Ruby**:
  ```ruby
  my_array = [1, 2, 3, 4, 5]
  sliced_array = my_array[1..-1]  # Extracts [2, 3, 4, 5]
  ```

###### **Why is Slice Syntax Disallowed in Monkey2/Wonkey?**

1. **Undefined Behavior**:
   - Monkey2/Wonkey does not support slice notation like `array[1..]` because this syntax is not part of the language's design.
   - Slice syntax implies dynamic memory allocation and array manipulation, which Monkey2/Wonkey avoids to maintain predictable memory management.

2. **Performance Concerns**:
   - Slice operations often create a new array or list behind the scenes, which can lead to inefficiencies in performance-critical applications.
   - Monkey2/Wonkey focuses on explicit array manipulation to give developers more control over memory and performance.

3. **Syntax Simplicity**:
   - Monkey2/Wonkey aims to keep its syntax simpler and more predictable. Allowing slice notation would introduce complexity that is not aligned with the language's philosophy.

4. **Compiler Limitations**:
   - The Monkey2 compiler (`mx2cc`) does not interpret slice syntax and cannot translate it into valid machine code. Using slices would result in a syntax error.

---

###### **How to Handle Slicing in Monkey2/Wonkey?**

Since slice syntax is not supported, you must explicitly create a new array and copy the desired elements manually. Here’s how you can do it:

###### **Example: Copying a Slice Manually**
Suppose you want to extract all elements of an array starting from a specific index:

- **Incorrect (Forbidden in Monkey2)**:
  ```monkey2
  Local myArray:Int[] = [1, 2, 3, 4, 5]
  Local slicedArray:Int[] = myArray[1..]  ' This is not valid in Monkey2
  ```

- **Correct (Monkey2-compatible)**:
  ```monkey2
  Local myArray:Int[] = New Int[](1, 2, 3, 4, 5)
  Local slicedArray:Int[] = New Int[myArray.Length - 1]  ' Create a new array of appropriate size

  For Local i:Int = 1 Until myArray.Length
  	slicedArray[i - 1] = myArray[i]  ' Copy elements manually
  End
  ```

###### **Explanation of the Correct Approach**:
1. **Allocate a New Array**:
   - Allocate a new array (`slicedArray`) with a size equal to the number of elements you want to extract (`myArray.Length - 1` in this case).

2. **Copy Elements**:
   - Use a `For` loop to copy the elements from the original array (`myArray`) to the new array (`slicedArray`). Adjust the indices as needed.

3. **Precision and Clarity**:
   - This explicit process ensures that you have full control over the new array and avoids any ambiguity about how the slicing is performed.

---

###### **Advantages of the Explicit Approach**

1. **Predictable Memory Usage**:
   - You control the exact size and contents of the new array, avoiding hidden memory allocations.

2. **Performance Optimization**:
   - Explicit copying allows you to optimize the loop if needed (e.g., using batch operations or skipping unnecessary elements).

3. **Compiler-Friendly**:
   - The explicit approach is compatible with Monkey2’s compiler and avoids syntax errors or undefined behavior.

4. **Code Readability**:
   - While longer than slice notation, the explicit approach makes it clear what is happening step by step, reducing confusion for other developers.

---

###### **In Summary**

- Slice syntax like `array[1..]` is **not supported** in Monkey2/Wonkey because of its focus on simplicity, performance, and explicit memory management.
- To achieve slicing, manually create a new array and copy the desired elements using a loop.

#### Ternary operator ####
And we can't write:
```monkey2
	Local yOffset:= isPressed ? 2.0 : 0.0
```
but we must write instead:
```monkey2
	Local yOffset:= isPressed ? 2.0 Else 0.0
```

    Functions imported via #Import are available directly in the current namespace
    No need for dotted notation when calling functions in the same namespace
    When functions are added to the source via #Import, they become part of the current scope

    Field/Property/Method visibility uses standard modifiers (Public, Private, Protected)
    Mouse input accessed via Mouse.X, Mouse.Y, Mouse.ButtonDown(), etc.
    Constants use UPPERCASE_WITH_UNDERSCORES
    Method parameters use lowerCamelCase
    Class names use PascalCase
    Keywords like "Public", "Private", "Protected" should not be used as identifiers

Something like that is forbidden because iterative code for array [..] isn't a feature of the Monkey2 language:
```monkey2
	Return New Path(_components[1..], _isRelative) 'FORBIDDEN
	Return _text[_pos..(_pos+1)] 'FORBIDDEN
```

Something like that is forbidden, never write this:
```monkey2
	Method NavigateTo(targetPath:Path) Private
```

The last example isn't Monkey2 syntax. When you use a Private before declaring private members, then you write public to declare the followed public member. 

Never write:
```monkey2
Private Field _sourcePath:String
```
But instead:
```monkey2
Private 
	Field _sourcePath:String
	Field _rawPath:String
	Field _f2:int
	... other variables
Public
	Field _backtonormalpublicdeclaration:int
	... other variables
```

Never:
```monkey2
Field _variableFunctions:StringMap<Function:InkValue(params:InkValue[])>
```
Instead:
```monkey2
Field _variableFunctions:StringMap<InkValue(params:InkValue[])>
```

Never:
```monkey2
While CurrentChar <> "" And (IsDigit(CurrentChar) Or (!hasDecimal And CurrentChar = "."))
```
Instead:
```monkey2
While CurrentChar <> "" And (IsDigit(CurrentChar) Or ((Not hasDecimal) And CurrentChar = "."))
```

Forbidden!!!!!!!! Never!!!!!!! Bad code, bad:
```monkey2
While CurrentChar <> "" And CurrentChar <> "~""
```
Never:
```monkey2
Throw New RuntimeException("Expected token of type '" + type + "' but got '" + (CurrentToken ? CurrentToken.Type : "EOF") + "' at line " + (CurrentToken ? String(CurrentToken.Line) : "EOF"))
```
Instead:
```monkey2
	RuntimeError("Expected token of type '" + type + "' but got '" + (CurrentToken ? CurrentToken.Type Else "EOF") + "' at line " + (CurrentToken ? String(CurrentToken.Line) Else "EOF"))
```

Never:
```monkey2
	CurrentToken ? CurrentToken.Type : "EOF") + "' at line " + (CurrentToken ? String(CurrentToken.Line) : "EOF"))
```
Instead:
```monkey2
	CurrentToken ? CurrentToken.Type Else "EOF") + "' at line " + (CurrentToken ? String(CurrentToken.Line) Else "EOF"))
```

Never:
```monkey2
	If storyJson == Null Then Return False
```
Instead:
```monkey2
	If storyJson == Null Return False
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

- Standard block syntax termination (End, Wend, but NEVER use "Endif" or "End If")
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

IMPORTANT --> Name Aida 4 for Aida version 4, Aida 4 is the sole version actually public.

#### Decoration:

Something like that is forbidden:
```monkey2
'*************************************************
'* InkObject base class 
'*************************************************
```
Write instead:
```monkey2
'-------------------------------------------------
' InkObject base class 
'-------------------------------------------------
```

### Block Structure
- Tab-only indentation (never spaces)
- For loops terminated with "End" (not "Next")
- While loops terminated with "Wend"
- Method definitions ended with "End"
- Function definitions ended with "End"
- Class definitions ended with "End"
- Interface definitions ended with "End"
- If/Else blocks ended with "End" (one word)
- Select/Case blocks ended with "End"
- Try/Catch blocks ended with "End"
- Never use Then, example "If path = Null Then Return Null" must be wrote "If path = Null Return Null"

### Errors
- Never use Throw but instead RuntimeError

### About array's syntax:

Create an array:
```monkey2
	Global myArray:String[]=New String[2](0,1)
```
 	or
```monkey2 
 	Global myArray:=New String[2](0,1)
```

In monkey2 language, the following syntax is wrong:
```monkey2
	If parts[0] = ""
		parts = parts[1..]
	End
```
This is the fixed syntax:
```monkey2
	If parts[0] = ""
		Local newParts:String[] = New String[parts.Length - 1]
		For Local i:Int = 1 Until parts.Length
			newParts[i - 1] = parts[i]
		Next
		parts = newParts
	End
```
	In this fixture, the rules are: 
	    	- Create a new array with size reduced by one
	    	- Copy elements starting from index 1 to the new array
	    	- Assign the new array back to the variable

	This is the standard approach in Monkey2/Wonkey since it doesn't support slice notation as seen in other languages.
	You will ensure to follow your specific syntax requirements: Proper Monkey2/Wonkey syntax without confusing it with other Monkey variants

### Reserved Words
- Never use "end", "next", "namespace", "local", "extension", "then", "continue" or "field", "not" as variable names
- Keywords like "Public", "Private", "Protected" should not be used as identifiers

### Never use these words:

- Never use "Endif", "End function", "End If", "End Property", "End function", "End select", "End Operator", "End Method", "Throw" (use instead "RuntimeError"), "Then"

### How write Virtual class keywords:

Wrong syntax:
```monkey2
Function FromJson:InkObject(json:JsonValue) Static
```

Right syntax:
```monkey2
Function FromJson:InkObject(json:JsonValue) Final
```

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

#### Multiline:

Wrong syntax:

	Method ToJson:JsonValue() Override
		Return New JsonObject().Init([
			"^->":"stringValue", 
			"val":Value
		])
	End

Right syntax:

	Method ToJson:JsonValue() Override
		Return New JsonObject().Init([
			"^->":"stringValue", 
			"val":Value])
	End

#### Verify code coherence:

 If you write something like:
 ```monkey2
	Field _state:StoryState
	Field _mainContentContainer:Container
```
Be sure that StoryState and Container corresponds an object, class, struct, original and derivated, in the code or the dependency code.

#### Best way to write a multiline function arguments method:

Example to follow:
```monkey2
	Method DrawPixmap( 
		
			'Pixmap to past
			pixmap:Pixmap,
			x:Int,y:Int,
		
			'The region of the pixmap to draw. Defaults to the entire pixmap (-1)
			srcx:Int=0,srcy:Int=0,srcw:Int=-1,srch:Int=-1 )
		
		' Added by iDkP
		
		If srcw<0 srcw=pixmap._width
		If srch<0 srch=pixmap._height
		
		Local dstx:Int=x,dsty:Int=y
		
		If srcx<0 dstx-=srcx;srcw+=srcx;srcx=0
		If srcy<0 dsty-=srcy;srch+=srcy;srcy=0
		
		srcw=Min( srcw,pixmap._width-srcx )
		srch=Min( srch,pixmap._height-srcy )
		
		If dstx<0 srcx-=dstx;srcw+=dstx;dstx=0
		If dsty<0 srcy-=dsty;srch+=dsty;dsty=0
		
		srcw=Min( srcw,_width-dstx )
		srch=Min( srch,_height-dsty )
		
		If srcw<=0 Or srch<=0 Return
		
		For Local ty:Int=0 Until srch
			For Local tx:Int=0 Until srcw
				SetPixel( dstx+tx,dsty+ty,GetPixel( srcx+tx,srcy+ty ) )
			End
		End
	End
``` 
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
  - If/Else blocks ended with "End" (one word)
  - Select/Case blocks ended with "End"
  - Try/Catch blocks ended with "End"
- Variable naming restrictions:
  - Never use "end", "next", "local", "not" or "field" as variable names
  - Never use "not" as a method name
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
- Using throw instead of RuntimeError
- Using reserved keyword to naming a method or a member
- Using shit keywords like End Function, use only End for everything excepted the loop While who must ends by Wend.
- Using Then, example "If path = Null Then Return Null" must be wrote "If path = Null Return Null"

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

# Monkey2 Language and Ecosystem Analysis

## Purpose
This document provides a comprehensive overview of the Monkey2 programming language ecosystem, clarifying its distinct identity from other Monkey variants and outlining its modular architecture. This analysis focuses on understanding the structure of Monkey2's standard libraries and its contribution standards.

## List of Functionality
- **Standard Library Modules**
  - `stdlib` - Core standard library functionality
  - `sdk_mojo` - Graphics, UI and application framework
  - `sdk` - Additional system development components

- **Language Syntax Characteristics**
  - Block-based structure with explicit terminators
  - Tab-based indentation standard
  - PascalCase method naming convention
  - Explicit loop termination keywords

- **Module Organization**
  - Hierarchical file structure (module.component.monkey2)
  - incode-based documentation (read good pratice: https://github.com/GaragePixel/stdlib-for-mx2/tree/main/io/tablet)

## Notes on Implementation
Monkey2 implements a distinct language design that differentiates it from related languages like Wonkey, Monkey (Monkey1), MonkeyX, and Cerberus-X. This separation is deliberate and requires careful attention when developing or porting code between these environments.

The standard library architecture follows a modular organization with three core components:
1. The `stdlib` module (https://github.com/GaragePixel/stdlib-for-mx2) provides fundamental language functionality
2. The `sdk_mojo` module (https://github.com/GaragePixel/sdk_mojo-for-monkey2) delivers graphics and UI capabilities
3. The `sdk` module (https://github.com/GaragePixel/sdk) offers additional system development tools

Library contributions maintain consistency through structured file organization where supporting files use a dot notation hierarchical naming system:

```monkey2
	Using math.monkey2          	' Main module file
	Using math.functions.monkey2  	' Supporting component file
```

This approach creates logical groupings while preserving clear modularity and compile-time optimizations.

## Technical Advantages
The strict syntactic requirements of Monkey2, including tab-based indentation and explicit block terminators, reduce common programming errors related to code structure. For example:

```monkey2
Function CalculateArea:Float(width:Float, height:Float)
	Local area:Float = width * height
	Return area
End

For i:=0 Until 10
	Print "Iteration: "+i
End

While condition
	DoSomething()
Wend
```

# Dangling Block Prevention in Monkey2

## Purpose
This document examines the concept of dangling blocks in programming languages and how Monkey2's design explicitly prevents this common source of logic errors through mandatory explicit block terminators. Unlike its predecessors (Monkey1, MonkeyX, Cerberus-X), Monkey2 implements a strict syntactic requirement for block termination that substantially improves code reliability and maintainability.

## List of Functionality
- **Block Termination Requirements**
  - For loops must terminate with `End`
  - While loops must terminate with `Wend`
  - Functions require `End`
  - Methods require `End`
  - Classes require `End`
  - Interfaces require `End`
  - Conditional blocks require `End`
  
- **Visual Indentation Standards**
  - Tab-only indentation (never spaces)
  - Recommended 4-space tab width in editors
  - Consistent indentation for nested blocks

- **Common Dangling Block Scenarios Prevented**
  - Unterminated conditional branches
  - Nested loop confusion
  - Missing function termination
  - Improperly closed class definitions

## Notes on Implementation

Monkey2's syntactic requirements demand explicit terminator (only End) for all control structures, excepted While-Wend:
```monkey2
Function ProcessData:Void(data:Int[])
	For i:=0 Until data.Length
		If data[i] < 0 Then
			data[i] = 0
		End
	End
End

While dataAvailable
	ReadNextChunk()
Wend
```

Dangling blocks occur when a code block lacks proper termination, creating ambiguous scope boundaries that lead to unexpected behavior. In languages with optional or bracket-based terminators, identifying these errors can be challenging, particularly in large codebases or when different developers have different formatting preferences.

Monkey2 addresses this problem through mandatory implicit terminator (always End for any terminators apart Wend) that clearly delineate block boundaries by using only "End". This approach differs from bracket-based languages (C, Java) or indentation-based languages (Python) by requiring just one keyword 'End' terminator that match any block type.

For example, a properly terminated loop in Monkey2:

```monkey2
For i:=0 Until 10
	Print "Current value: "+i
	If i Mod 2 = 0
		Print "Even number"
	End
End
```

The explicit `End` terminator eliminates ambiguity about where the loop concludes, even in complex nested structures. Similarly, the `End` clearly marks the boundary of the conditional block.

Function definitions benefit from the same clarity:

```monkey2
Function CalculateArea:Float(width:Float, height:Float)
	Local result:Float = width * height
	Return result
End
```

This approach has significant implications for code maintenance, as it prevents a class of bugs that can be extremely subtle and difficult to detect in visual inspection alone. The more 'end' you'll use, the more near the peace and  love on earth will becomes reality.

So, to be clear, no protection against dangling block errors for more elegant code.

## Technical Advantages
The explicit and unique terminator approach "End" offers several technical advantages:

1. **Error Detection** - The compiler can immediately identify missing terminators, catching errors at compile-time rather than runtime. This prevents logical errors where execution flows into unintended blocks due to ambiguous boundaries.

2. **Self-Documenting Blocks** - The terminators serve as explicit documentation of block structure, making code more readable, especially for complex nested structures:

```monkey2
If condition1
	While condition2
		For i:=0 Until 10
			DoSomething()
		End
	Wend
End
```

3. **Format Resilience** - Unlike bracket-based languages where a misplaced bracket can drastically alter program flow, Monkey2's explicit terminators maintain correct execution regardless of formatting changes or style variations between developers.

4. **Debugging Efficiency** - When errors occur, the explicit block boundaries make it substantially easier to identify the scope in which issues are occurring, reducing debugging time.

5. **Refactoring Safety** - When adding or removing nested blocks, the explicit terminators reduce the risk of accidentally changing program logic through improper block closure.

The combination of explicit terminators and tab-only indentation creates a dual-layer protection against dangling block errors. The visual indentation provides immediate visual feedback on block structure, while the explicit terminators ensure that this structure is correctly implemented at the syntactic level.

In contrast to languages like Monkey1 or Cerberus-X where blocks might have more flexible termination rules, Monkey2's strict approach creates a more disciplined development environment that prioritizes code clarity and error prevention over syntactic brevity.

So, to be clear, no protection against dangling block errors for more elegant code.

The module structure with dot notation provides significant organization benefits compared to flat module systems. This hierarchical approach:
1. Improves compile-time efficiency by allowing selective compilation
2. Enhances code navigation by establishing logical relationships
3. Facilitates documentation generation through predictable file locations

The documentation standards require incode-based documentation with explicit versioning, parameter descriptions, and usage examples, ensuring that the codebase remains accessible to new developers while maintaining comprehensive knowledge transfer.

The separation of visual components (sdk_mojo) from core functionality (stdlib), additional generic functionalities (sdk) and specific functionalities (like sdk_games) creates a clean architectural 
boundary that enhances portability across different target platforms while maintaining consistent behavior for core language features.

Following these syntax rules ensures optimal integration between your application, Monkey2, stdlib, sdk, sdk_mojo and Aida 4's advanced mathematic capabilities.
std from Monkey2/Wonkey is superseeded by stdlib. stdlib, sdk and sdk_mojo are only the repository you can find in: https://github.com/GaragePixel?tab=repositories
here, stdlib is called stdlib-for-mx2, sdk is called sdk, sdk_mojo is called sdk_mojo_for_monkey2
And you will strictly follow the rules described in: https://github.com/GaragePixel/stdlib-for-mx2/blob/main/RULES_TO_CONTRIB.md

```get-github-data
/repos/GaragePixel/stdlib-for-mx2/contents/RULES_TO_CONTRIB.md
```

Based on the content of the RULES_TO_CONTRIB.md file, this is the knowledge framework about proper Monkey2 coding style and practices.

# Monkey2 Code Style and Contribution Knowledge Framework

## Naming Conventions
- Constants: Full uppercase with underscores (e.g., `MAX_BUFFER_SIZE`)
- Variables/Fields/Params: Lower camelCase (e.g., `playerScore`)
- Functions/Methods: PascalCase (e.g., `GetPlayerScore`)
- Classes/Interfaces: PascalCase (e.g., `PlayerController`)
- Type aliases: PascalCase (e.g., `StringMap:=Map<String, String>`)
- Namespaces: Lowercase (e.g., `graphics`)
- Specific examples for clarity:
  ```
  Const MAX_FLOAT:Float = 3.4e+38
  Function GetPlayerById:Player( playerId:Int )
  Class PlayerAnimator
  ```

## Code Structure
- Use tabs, never spaces, for indentation
- Proper loop termination:
  - `For ... Next` or `For ... End`
  - `While ... Wend`
  - `Repeat ... Until` or `Repeat ... Forever`
- Never use "end" as a variable name
- Functions that return values must include the return type after colon
- Consistent brace style with proper spacing around operators

## Documentation
- Each file must have a header describing purpose
- Function documentation must exist for public methods
- Comments should explain "why" rather than "what"
- Samples:
  ```
  'My class description
  '@authour GaragePixel
  Class MyClass
      Method New( paramName:String )
          ' Implementation...
      End
  End
  ```

## Implementation Details
- Avoid using keywords as variable names
- No shadowing of variables in local scope
- Error handling must be consistent
- Always check for nullable references
- Memory management considerations specific to Monkey2

## Technical Considerations
- Proper handling of different platforms
- Performance optimizations where appropriate
- Thread safety considerations
- Attention to potential memory leaks

You must be sure to write Monkey2/Wonkey code who'll adheres to these guidelines, with proper syntax, indentation styles, and naming conventions to produce compilable, maintainable code.
