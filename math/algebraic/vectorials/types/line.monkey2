
Namespace stdlib.math.types

#rem monkeydoc @hidden
#end
Alias Linef:Line<Float>

#rem monkeydoc @hidden
#end
Struct Line<T>

	Field o:Vec3<T>
	Field d:Vec3<T>
	
	Method New()
	End
	
	Method New( o:Vec3<T>,d:Vec3<T> )
		Self.o=o;Self.d=d
	End
	
	Operator To:String()
		Return "Line("+o+","+d+")"
	End
	
	
	Operator-:Line()
		Return New Line( o,-d )
	End
	
	Operator+:Line( v:Vec3<T> )
		Return New Line( o+v,d )
	End
	
	Operator-:Line( v:Vec3<T> )
		Return New Line( o-v,d )
	End
	
	Operator*:Vec3<T>( time:Double )
		Return o+d*time
	End
	
	Method TNearest:Float( p:Vec3<T> )
		Return ( d.Dot( p-o )/d.Dot( d ) )
	End
	
	Method Nearest:Vec3<T>( p:Vec3<T> )
		Return o+d*( d.Dot( p-o )/d.Dot( d ) )
	End

End
