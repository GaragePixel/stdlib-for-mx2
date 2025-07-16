Namespace stdlib.syntax.strings

#rem 

	Escape sequences as constantes helpers
	iDkP from GaragePixel
	2025-02-11
	
	Note:

		There a bug somewhere who make it impossible in a module to put the escape sequences
		in constante to made Control Character : https://en.wikipedia.org/wiki/Control_character
		So this library manages to work around it. It comes with a set of private functions
		who returns the result of a character code (KLUDGE), while the these functions
		are recorded in a closure who acts like constante that, in front-end, we are able to use.
		
			Example usage (really needs one? ):
				Local aidaWrotes:="The dairy "+QT+ "of my secret life"+QT+" is secret! "+NL+TB+"...and u'll know nothin'!"
				Print NL+"Secret of Aida:"+NL+aidaWrotes

#end 

'	Note:
'		Do nothing in string:
'			EOT, ETX, BEL, BS, VT, CR, FF, UR, LR, SUB, ESC, DEL

Public 'wrapped consts:

'Acts in string:

Const SP:=_SP() 'KLUDGE space grapheme
Const TL:=_TL() '~~ tilde grapheme ~
Const SN:=_SN() '~z null - Acts as an end-of-file for the Windows text-mode file i/o
Const TB:=_TB() '~t tab
Const QT:=_QT() '~q quotation grapheme "
Const NL:=_NL() '~n new line (same as line feed)
Const LF:=_LF() 'Line feed

'Do nothing in string:

Const VT:=_VT()
Const EOT:=_EOT()
Const ETX:=_ETX()
Const BEL:=_BEL()
Const BS:=_BS()
Const CR:=_CR()
Const FF:=_FF()
Const UR:=_UR()
Const LR:=_LR()
Const SUB:=_SUB()
Const ESC:=_ESC()
Const DEL:=_DEL()

Private 'funcs

Function _SP:String() 'KLUDGE space grapheme
	'Follows the nomenclature as a function, not a string constante
	Return " " 
End

Function _SN:String() '~z null 'Acts as an end-of-file for the Windows text-mode file i/o
	Return String.FromChar(0)
End

Function _ETX:String() 'End-of-Text character ^c (do nothing on string)
	Return String.FromChar(3)
End 

Function _EOT:String() 'End-of-Transmission character ^D (do nothing on string)
	Return String.FromChar(4)
End 

Function _BEL:String() 'Bell (do nothing on string)
	Return String.FromChar(7)
End 

Function _BS:String() 'Back space (del) (do nothing on string)
	Return String.FromChar(8)
End

Function _TB:String() '~t tab
	Return String.FromChar(9)
End 

Function _LF:String() 'Line feed
	Return String.FromChar(10)
End 

Function _NL:String() '~n new line (same as line feed)
	Return _LF()
End 

Function _VT:String() 'Vertical tabulation (do nothing on string)
	Return String.FromChar(11)
End

Function _FF:String() 'Form feed (clear) (do nothing on string)
	Return String.FromChar(12)
End

Function _CR:String() '~r return (do nothing on string)
	Return String.FromChar(13)
End 

Function _UR:String() 'Upper Rail (do nothing on string)
	'https://en.wikipedia.org/wiki/Shift_Out_and_Shift_In_characters
	Return String.FromChar(14)
End 

Function _LR:String() 'Lower Rail (do nothing on string)
	'https://en.wikipedia.org/wiki/Shift_Out_and_Shift_In_characters
	Return String.FromChar(15)
End 

Function _SUB:String() 'CTRL+Z (do nothing on string) Acts as an end-of-file for the Windows text-mode file i/o
	Return String.FromChar(17)
End 

Function _ESC:String() 'Escape (clear) (do nothing in the out console)
	Return String.FromChar(18) 'GCC only, Introduces an escape sequence.
End

Function _QT:String() '~q quotation grapheme "
	Return String.FromChar(34)
End

Function _TL:String() '~~ tilde grapheme ~
	Return String.FromChar(126)
End 

Function _DEL:String() 'del (do nothing on string)
	Return String.FromChar(127)
End 
