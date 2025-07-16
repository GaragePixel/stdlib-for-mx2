
Namespace stdlib.syntax

#rem 
@author iDkP from GaragePixel
@since 2025-07-04
@example

	Function myFunc(attribs:VAttribs[])
								Local vattribs:=Bind(attribs)
								Local height:=Int(vattribs.Get("height"))
								Local width:=Float(vattribs.Get("width"))
	
		Print width+height
	End
	
	Function myfn(attribs:VAttribs[])
								Local vattribs:=Bind(attribs)
								Local height:=Int(vattribs.Get("height"))
								Local width:=Float(vattribs.Get("width"))
	
		'Print width+height
	End

	Function Main()
		
		myFunc(Attribs("		title: 		~qmyTitle~q, 
								height: 	10, 
								width: 		10.5"	))
	
	
		myfn(New VAttribs[](	"title"	,	"myTitle",
								"height",	10,
								"width"	,	10.5	))
	End	
#end 

'#Import "../../types/types"
'#Import "../../system/reflection/reflection"
'#Import "../primitives/variants/variantcasts"

Using stdlib.types..
Using stdlib.reflection
Using stdlib.syntax.variantcasts

Function Attribs:VAttribs[]( pair:String )
	Return New TAttribs(pair).Bind()
End

Class TAttribs
	
	Method New( attribs:String )
		_pair=attribs
	End 

	Method Bind:VAttribs[]()

		Local e:=_pair.Split(",")
		Local tkn:String[]
		Local data:=New Stack<Variant>

		For Local i:=Eachin e
			tkn			=	i.Replace("~n","").Split(":")
			tkn[0]		=	Unquote(tkn[0]).Trim()
			tkn[1]		=	Unquote(tkn[1]).Trim()

			data.Add(Cast<Variant>(tkn[0]))
			data.Add(Cast<Variant>(tkn[1]))
		End

		Return data.ToArray()
	End 

	Field _pair:String
End 
