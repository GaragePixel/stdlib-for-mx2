
Namespace stdlib.reflection

#rem monkeydoc Debug reflected types.
Prints all reflected types and decls.
#end
Function DebugTypes()
	
	For Local type:=Eachin TypeInfo.GetTypes()
		Print type
		For Local decl:=Eachin type.GetDecls()
			Print "  "+decl
		Next
		Print ""
	Next
End

#rem monkeydoc Gets type extensions for a given type.
Returns an array containing all type extensions for a given type.
#end
Function GetTypeExtensions:TypeInfo[]( type:TypeInfo )

	Global _typeExts:StringMap<TypeInfo[]>
	If Not _typeExts
		Local typeExts:=New StringMap<Stack<TypeInfo>>
		For Local type:=Eachin TypeInfo.GetTypes()
			If Not type.Kind.EndsWith( " Extension" ) Continue
			If Not typeExts.Contains( type.SuperType ) typeExts[type.SuperType]=New Stack<TypeInfo>
			typeExts[type.SuperType].Add( type )
		Next
		_typeExts=New StringMap<TypeInfo[]>
		For Local it:=Eachin typeExts
			_typeExts[it.Key]=it.Value.ToArray()
		Next
	End
	Return _typeExts[type]
End

#rem monkeydoc Gets the value of a property.
#end
Function GetProperty:Variant( name:String,instance:Variant )
	
	Local type:=instance.Type
	While type
		Local decl:=type.GetDecl( name )
		If decl And decl.Kind="Property" And decl.Name=name Return decl.Get( instance )
		For Local type:=Eachin GetTypeExtensions( type )
			Local decl:=type.GetDecl( name )
			If decl And decl.Kind="Property" And decl.Name=name Return decl.Get( instance )
		Next
		type=type.SuperType
	Wend
	Return Null
End

Function GetProperty<T>:T( name:String,instance:Variant )
	
	Local value:=GetProperty( name,instance )
	If value Return Cast<T>( value )
	Return Null
End

#rem monkeydoc Sets a property to a value.
#end
Function SetProperty:Bool( name:String,instance:Variant,value:Variant )
	
	Local type:=instance.Type
	While type
		Local decl:=type.GetDecl( name )
		If decl And decl.Kind="Property" And decl.Name=name
			decl.Set( instance,value )
			Return True
		End
		
		For Local type:=Eachin GetTypeExtensions( type )
			Local decl:=type.GetDecl( name )
			If decl And decl.Kind="Property" And decl.Name=name
				decl.Set( instance,value )
				Return True
			End
		Next
		type=type.SuperType
	Wend
	Return False
End

#rem monkeydoc Infers the type of a Variant value even after it has been washed, 
handling both native types and string representations.
@author iDkP from GaragePixel
@since 2025-07-03

Determines type for Variant contents, whether native primitive or string representation.
Fast path for native types, fallback to string parsing for string-wrapped values, capable
to infer the type when the data was 'washed' within a variant.

@param v (String version) The data sample as string to extract the type from
@param v (Variant version) The variant to to extract the type from
@param fromString (Variant version) the data sample comes from a string or is a native type

- Type from string representation:

Alternative to runtime type introspection when normal type casting fails.

Determines if a string represents an integer, float, bool, or should remain string.
Examples: "2" -> int, "2.0" -> float, "2.5" -> float, "true" -> bool, "f2.0" -> string

This approach is for when Variant erases the original type 
and normal casting or TypeOf won't work as expected.

Note:

	Can only return int (IReal), float (IIntegral), bool (INumeric) or string
	Good for occasional type checking (< 1000 calls)
	Character validation loop creates multiple temporary strings
	
	Fast Path (Native Types - O(1))
	Slow Path (String Conversion Fallback)
	Critical Loop Assessment: EXCELLENT for native types

Note and performance:

	String.FromChar() allocations in validation loop are expensive
	Exception handling adds latency for invalid input

	String version: Consistent moderate performance regardless of input
	Variant version: Excellent for native types, fallback to moderate for strings
	
Possible optimisations:

	Possible optimisation: 
	Pre-validate character sets using byte-level operations instead of String.FromChar()
	
Returns types (string version):

@returns __t_int__ for integer values
@returns __t_float__ for floating point values  
@returns _t_bool__ for boolean values
@returns __t_string__ for non-numeric strings

- Type from string representation embedded within a variant:

Determines type for Variant contents, from a string representation.

Return type (variant version, string representation): 

@returns __t_int__ for integer values
@returns __t_float__ for floating point values  
@returns _t_bool__ for boolean values
@returns __t_string__ for non-numeric strings

- Type from raw data embadded within a variant:

Determines type for Variant contents from native primitive.

@Example:
	Print GetType(Cast<Variant>(True)) 		'Bool
	Print GetType(Cast<Variant>(2)) 		'Int
	Print GetType(Cast<Variant>(2.5)) 		'Float
	Print GetType(Cast<Variant>(2.0)) 		'Float
	
Return type (variant version, native primitives):

@returns __t_int__ for integer values
@returns __t_float__ for floating point values  
@returns _t_bool__ for boolean values
@returns __t_string__ for non-numeric strings
#end
Function GetType:TypeInfo( v:String )
	
	'Type from a type as string representation:
	
	Local trimmed:=v.Trim()
	
	' Quick check for empty strings
	If trimmed.Length=0 Return __t_string__
	
	' Check for boolean values first (most restrictive)
	Local lowerTrimmed:=trimmed.ToLower()
	If lowerTrimmed="true" Or lowerTrimmed="false"
		Return __t_bool__
	End
	
	' Check for non-numeric characters (excluding digits, decimal point, minus, plus, e/E for scientific)
	Local validChars:="0123456789.-+eE"
	For Local i:=0 Until trimmed.Length
		If Not validChars.Contains(String.FromChar(trimmed[i]))
			Return __t_string__
		End
	End
	
	Try
		' Try to parse as integer first
		Local intVal:=Int(trimmed)
		Local intStr:=String(intVal)
		
		' If string representation matches exactly, it's an integer
		If trimmed=intStr Return __t_int__
		
		' Check if it could be a float representation of an integer (like "2.0")
		Local floatVal:=Float(trimmed)
		Local backToInt:=Int(floatVal)
		
		' If the float value equals its integer conversion and contains decimal point
		If floatVal=Float(backToInt) And trimmed.Contains(".")
			Return __t_float__
		End
		
		' If we can parse as float but not as matching integer, it's a float
		If Not (floatVal=Float(backToInt))
			Return __t_float__
		End
		
	Catch err:Throwable
		' Parsing failed, definitely a string
		Return __t_string__
	End
	
	' Default case - if we get here, treat as string
	Return __t_string__
End

Function GetType:TypeInfo( v:Variant, fromString:Bool=False )
	
	If fromString 'from a string within a variant
	
		' Use ToString() method instead of String(v) casting
		Local stringRep:=""
		Try
			stringRep = String(v)
		Catch err:Throwable
			' String Casting failed, try alternative extraction
			Return __t_string__  ' Default assumption
		End
		
		Local trimmed:=stringRep.Trim()
		
		' Quick check for empty values
		If trimmed.Length=0 Return __t_string__
		
		' Test for boolean patterns first
		Local lowerTrimmed:=trimmed.ToLower()
		If lowerTrimmed="true" Or lowerTrimmed="false"
			Return __t_bool__
		End
		
		' Test for numeric patterns without direct conversion
		' Check character composition for numeric validity
		Local validChars:="0123456789.-+eE"
		Local hasDecimal:=False
		Local validNumeric:=True
		
		For Local i:=0 Until trimmed.Length
			Local char:=String.FromChar(trimmed[i])
			If Not validChars.Contains(char)
				validNumeric = False
				Exit
			End
			If char="." hasDecimal = True
		End
		
		' If not valid numeric characters, it's a string
		If Not validNumeric Return __t_string__
		
		' Try to determine int vs float based on string pattern
		Try
			' Attempt parsing through temporary string operations
			Local testInt:=Int(trimmed)
			Local testStr:=String(testInt)
			
			' Exact match indicates integer
			If trimmed=testStr Return __t_int__
			
			' Has decimal point but converts to integer value
			If hasDecimal
				Local testFloat:=Float(trimmed)
				If testFloat=Float(testInt)
					Return __t_float__  ' "2.0" case
				Else
					Return __t_float__  ' "2.5" case
				End
			End
			
		Catch err:Throwable
			' Parsing failed, treat as string
			Return __t_string__
		End
		
		' Default fallback
		Return __t_string__
		
	Else 'From native primitive within a variant
		
		' Use type introspection instead of casting to avoid exceptions
		Local vType:=v.Type
		
		' Check against known primitive TypeInfo constants
		If vType=__t_bool__ Return __t_bool__
		If vType=__t_int__ Return __t_int__
		If vType=__t_float__ Return __t_float__
		If vType=__t_string__ Return __t_string__
		
		' Fallback for unknown types - try safe string conversion
		Try
			Local stringRep:=String(v)
			' Use existing string-based detection as fallback
			Return GetType(stringRep)
		Catch err:Throwable
			' Complete fallback
			Return __t_string__
		End
	End 
	
	Return Null
End

#rem monkeydoc Checks if a Variant contains a value of the specified custom type.
@author iDkP from GaragePixel
@since 2025-07-03

Performs runtime type verification for custom types stored in Variants.
Supports exact type matching only.
Safe alternative to casting when type verification is needed first.

@param v The Variant to check
@param t The TypeInfo to match against

@returns True if Variant contains specified type, False otherwise
#end
Function IsType:Bool( v:Variant, t:TypeInfo )
	
	Local type:=v.Type
	
	' Handle null cases
	If Not type Return False
	If Not t Return False
	
	' Exact type matching only
	Return type = t
End
