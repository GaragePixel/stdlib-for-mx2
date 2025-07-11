
Namespace stdlib.types

'------------------------------------------------ Aliases for data types

'Aliases for new naming-conversion
'
'During the 20th century, people implicated in the ingeniery o computers becames to invente 
'a new word for each new wired datatype. But now, we can see it as an irritant non-formalism.
'So then, if we choose the fondamental structure (int or float) followed by the bit number
'used to define this structure, everyone can understand what is exactly implicated,
'we have now a non-folkloric formalism.
'
'It's very useful to name the byte int8 while int32 is the normal integer magnitude,
'the int64 becomes the long type... How many wires? How much is the memory print? 
'We know it instantly.
'
'Today, in 2021, I have make the choice to adopt this convention for this library.

' --------- Aliases for the New Datatype Naming Convention (NDC Aliases)

Alias Int8:Byte
Alias UInt8:UByte
Alias Int16:Short 		'used for the conventional/C/C++/builded-in Bool type
Alias UInt16:UShort
Alias Int32:Int
Alias UInt32:UInt
Alias Int64:Long
Alias UInt64:ULong
Alias Float32:Float 	'float (in lowercase): C, C++, C#, Java - (Float): Haskell, Swift, Aida (Sibly-family language)
						'Float (uppercase) refers to Float64 Python, Ruby, PHP, and OCaml
Alias Float64:Double 	'Single in versions of Octave before 3.2 refer to double-precision numbers Float64

' Other Datatypes

Alias Binary32:Float32
Alias Binary64:Float64
Alias Single:Float32 	'Object Pascal (Delphi), Visual Basic, and MATLAB
