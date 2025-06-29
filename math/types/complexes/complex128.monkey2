
Namespace stdlib.math.types

'Complex
'iDkP from GaragePixel
'2018

Alias Complex:Complex128

Struct Complex128 ' should make it generic?
	
	'Factories

	Function FromCartesien:Complex( real:Double,imag:Double=.0 )
		'Idiom
		Return New Complex( real,imag )
	End
	
	Function FromPolar:Complex( modulus:Double,angle:Double=.0 )
		Return New Complex(modulus * Cos(angle), modulus * Sin(angle))
	End
	
	'Properties
	
	Property Real:Double()
		Return _r
	Setter(real:Double)
		_r=real
	End 		
	
	Property Imag:Double()
		Return _i	
	Setter(imag:Double)
		_i=imag
	End 		
	
	'Instanciation
	
    Method New( real:Double,imag:Double=.0 )
        _r=real
        _i=imag
	End
	
	'Operators
	
	Operator To:String()
		Return "Complex("+_r+","+_i+")"
	End 
		
    Operator +:Complex( this:Complex )
        Return New Complex(_r+this.Real,_i+this.Imag)
	End
	
    Operator -:Complex( this:Complex )
        Return New Complex(_r-this.Real,_i-this.Imag)
	End
	
    Operator *:Complex( this:Complex )
        Return New Complex(_r*this.Real-_i*this.Imag,_i*this.Real+_r*this.Imag)
	End

	Operator /:Complex( this:Complex )
        Local or0:=this.Real
        Local oi0:=this.Imag
        Local sr:=Self._r
        Local si:=Self._i        
		Local er0:=Pow(or0,2)
		Local er1:=Pow(oi0,2)
		Local r:= Float(er0 + er1)
        Return New Complex((sr*or0+si*oi0)/r, (si*or0-sr*oi0)/r)
	End
	
	'Identities

	Method Abs:Double()
        Return Sqr(Sqr(_r)+Sqr(_i))
	End
	
    Method Neg:Complex()
        Return New Complex(-_r,-_i)
	End
	
	'Logical
	
    method Eq:Bool( this:Complex )
	    If _r = this.Real And _i = this.Imag Return True
        Return False
	End
	
    Method No:Bool( this:Complex )
        Return Not Self.Eq(this)
	End
	
	Private 

	Function Sqr:Double(n:Double) 'avoids dependancy
		Return n*n
	End
	
	'Function Sqr<T>:T(n:T) 'avoids dependancy (generic version, just in the case where
	'											I decides to make the complex generic)
	'	Return n*n
	'End
	
	Field _r:Double
	Field _i:Double
	
End
