'------------------------------------------------ Data types: Numbers

Namespace stdlib.types

'#Import "../../types/aliases/aliases"

Struct minifloat 'MiniFloat
	'S:bool8 'S is the length of the sign field. It is usually either 0 or 1.
	'E'E is the length of the exponent field.
	'M is the length of the mantissa (significand) field.
	'B is the exponent bias.
End
