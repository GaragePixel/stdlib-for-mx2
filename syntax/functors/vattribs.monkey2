
Namespace stdlib.syntax

#rem @pro Attributes Minilibrary
@author iDkP from GaragePixel
@since 2025-07-04
@example

	Function myfn(attribs:VAttribs[])
								Local vars:=Bind(args)
								Local height:=Int(vars.Get("height"))
								Local width:=Float(vars.Get("width"))
	
		Print width+height
	End
	
	Function Main()
	
		myfn(New VAttribs[](	"title"	,	"myTitle",
								"height",	10,
								"width"	,	10.5	))
	End
#end 

#Import "../../types/types"
#Import "../../system/reflection/reflection"
#Import "../primitives/variants/variantcasts"

Using stdlib.types..
Using stdlib.reflection
Using stdlib.syntax.variantcasts

Alias VAttribs:Variant 	'Conveniant alias alternative name, usually used in conjonction with a container []
						'It should be remplaced by Var, who was reserved by Mark for this usage.

Alias VarAttribs:cVarAttribs<String,TVar>

Function Bind:VarAttribs(v:Variant[])	'VarAttribs is an array of variant, interleaved as string,variant,string,variant... 
	Return New VarAttribs(v,True)		'Then VarAttribs is then used to make a Map<String,Variant> called VarAttribs
End

Class cVarAttribs<K,V> Extends Map<K,V> Where K=String And V=TVar

	'Should be remplaced by Var, who was reserved by Mark for this usage.
	'The generic types are locked by the VarAttribs alias. We don't have to try calling
	'cVarAttribs from another type declaration or alias. Only the VarAttribs call is valid.
	
	Method New( attrs:Variant[], t:Bool=True ) Override
		Assert((attrs.Length Mod 2) = 0,"Pair missing: array length must be even.")
		Local len:=attrs.Length/2
	
		For Local i:=0 Until len+2 Step 2
			local tvar:=New TVar()
			tvar.Set(attrs[i+1])
			tvar.Type=stdlib.reflection.GetType(attrs[i+1])
			Add(Cast<String>(attrs[i]),tvar)
		End
	End

	Method New( attrs:Stack<Variant>, t:Bool=True ) Override
		Assert((attrs.Length Mod 2) = 0,"Pair missing: array length must be even.")
		Local len:=attrs.Length/2
	
		For Local i:=0 Until len+2 Step 2
			local tvar:=New TVar()
			tvar.Set(attrs[i+1])
			tvar.Type=stdlib.reflection.GetType(attrs[i+1])
			Add(Cast<String>(attrs[i]),tvar)
		End
	End

	Method GetT<T>:T( key:K )
		Local node:=FindNode( key )
		If node Return node.Value
		Return Null
	End

	Method GetBool:Bool( key:K )
		Return Bool(Get(key))
	End
	
	Method GetInt:Int( key:K )
		Return Int(Get(key))
	End

	Method GetFloat:Int( key:K )
		Return Float(Get(key))
	End

	Method GetString:String( key:K )
		Return String(Get(key))
	End

	Method GetB:Bool( key:K )
		Return GetBool(key)
	End
	
	Method GetI:Int( key:K )
		Return GetInt(key)
	End

	Method GetF:Float( key:K )
		Return GetFloat(key)
	End

	Method GetS:String( key:K )
		Return GetString(key)
	End

End
