
Namespace stdlib.math.types

Enum TileMode 
	
	' Added by iDkP for GaragePixel:
	' For now, the tilemode belongs to rect.
	' But look, it really generic. So one day, when TileEnum 
	' will grown, it will be moved in a place where enums are free of tax 
	' and just happy.
		
	Fit=$0000 
		
	Left=$10 'The tiles are aligned to the left edge of a surface
	Right=$20 'The tiles are aligned to the right edge of a surface
	CenterX=$30 'The tiles are aligned in x to the center of a surface	
	FitH=$00 'The tiles are adjusted in x to the center of a surface
		
	Top=$01 'The tiles are aligned to the top edge of a surface
	Bottom=$02 'The tiles are aligned to the bottom edge of a surface
	CenterY=$03 'The tiles are aligned in y to the center of a surface
	FitV=$00 'The tiles are adjusted in x to the center of a surface
		
	Tiled=Left 'TileTopLeft Default: the tiles are aligned to the left of a surface
End 

#rem monkeydoc Convenience type alias for Rect\<Int\>.
#end
Alias Recti:Rect<Int>

#rem monkeydoc Convenience type alias for Rect\<Int\>.
#end
Alias Rectf:Rect<Float>

#rem monkeydoc The Rect class provides support for manipulating rectangular regions.

#end
Struct Rect<T>

	#rem monkeydoc Minimum rect coordinates.
	#end
	Field min:Vec2<T>
	
	#rem monkeydoc Maximum rect coordinates.
	#end
	Field max:Vec2<T>
	
	#rem monkeydoic Creates a new Rect.
	#end
	Method New()
	End
	
	Method New( min:Vec2<T>,max:Vec2<T> )
		Self.min=min
		Self.max=max
	End
	
	Method New( x0:T,y0:T,x1:T,y1:T )
		min=New Vec2<T>( x0,y0 )
		max=New Vec2<T>( x1,y1 )
	End
	
	Method New( x0:T,y0:T,max:Vec2<T> )
		Self.min=New Vec2<T>( x0,y0 )
		Self.max=max
	End
	
	Method New( min:Vec2<T>,x1:T,y1:T )
		Self.min=min
		Self.max=New Vec2<T>( x1,y1 )
	End
	
	#rem monkeydoc Converts the rect to a rect of a different type
	#end
	Operator To<C>:Rect<C>()
		Return New Rect<C>( min.x,min.y,max.x,max.y )
	End
	
	#rem  monkeydoc Converts the rect to a printable string.
	#end
	Operator To:String()
		Return "Rect("+min.x+","+min.y+","+max.x+","+max.y+")"
	End
	
	#rem monkeydoc The minimum X coordinate.
	#end
	Property X:T()
		Return min.x
	Setter( x:T )
		min.x=x
	End
	
	#rem monkeydoc The minimum Y coordinate.
	#end
	Property Y:T()
		Return min.y
	Setter( y:T )
		min.y=y
	End
	
	#rem monkeydoc The width of the rect.

'	Writing to this property modifies the maximum Y coordinate only.
	
	#end
	Property Width:T()
		Return max.x-min.x
'	Setter( width:T )
'		max.x=min.x+width
	End
	
	#rem monkeydoc The height of the rect.

'	Writing to this property modifies the maximum Y coordinate only.
	
	#end
	Property Height:T()
		Return max.y-min.y
'	Setter( height:T )
'		max.y=min.y+height
	End
	
	#rem monkeydoc The minimum X coordinate.
	#end
	Property Left:T()
		Return min.x
	Setter( left:T )
		min.x=left
	End
	
	#rem monkeydoc The minimum Y coordinate.
	#end
	Property Top:T()
		Return min.y
	Setter( top:T )
		min.y=top
	End
	
	#rem monkeydoc The maximum X coordinate.
	#end
	Property Right:T()
		Return max.x
	Setter( right:T )
		max.x=right
	End
	
	#rem monkeydoc The maximum X coordinate.
	#end
	Property Bottom:T()
		Return max.y
	Setter( bottom:T )
		max.y=bottom
	End
	
	#rem monkeydoc The top-left of the rect.
	#end
	Property Origin:Vec2<T>()
		Return min
	Setter( origin:Vec2<T> )
		min=origin
	End
	
	#rem monkeydoc The width and height of the rect.
	#end
	Property Size:Vec2<T>()
		Return max-min
	Setter( size:Vec2<T> )
		max=min+size
	End

	#rem monkeydoc The center of the rect.
	#end	
	Property Center:Vec2<T>()
		Return (min+max)/2
'	Setter( center:Vec2<T> )
	End
	
	#rem monkeydoc The top-left of the rect.
	#end
	Property TopLeft:Vec2<T>()
		Return min
	Setter( v:Vec2<T> )
		min=v
	End
	
	#rem monkeydoc The top-right of the rect.
	#end
	Property TopRight:Vec2<T>()
		Return New Vec2<T>( max.x,min.y )
	Setter( v:Vec2<T> )
		max.x=v.x
		min.y=v.y
	End
	
	#rem monkeydoc The bottom-right of the rect.
	#end
	Property BottomRight:Vec2<T>()
		Return max
	Setter( v:Vec2<T> )
		max=v
	End
	
	#rem monkeydoc The bottom-left of the rect.
	#end
	Property BottomLeft:Vec2<T>()
		Return New Vec2<T>( min.x,max.y )
	Setter( v:Vec2<T> )
		min.x=v.x
		max.y=v.y
	End
	
	#rem monkeydoc True if Right\<=Left or Bottom\<=Top.
	#end
	Property Empty:Bool()
		Return max.x<=min.x Or max.y<=min.y
	End

	#rem monkeydoc Adds another rect to the rect and returns the result.
	#end
	Operator+:Rect( r:Rect )
		Return New Rect( min+r.min,max+r.max )
	End
	
	#rem monkeydoc Subtracts another rect from the rect and returns the result.
	#end
	Operator-:Rect( r:Rect )
		Return New Rect( min-r.min,max-r.max )
	End
	
	#rem monkeydoc Multiples the rect by a vector and returns the result.
	#end
	Operator*:Rect( v:Vec2<T> )
		Return New Rect( min.x*v.x,min.y*v.y,max.x*v.x,max.y*v.y )
	End
	
	#rem monkeydoc Divides the rect by a vector and returns the result.
	#end
	Operator/:Rect( v:Vec2<T> )
		Return New Rect( min.x/v.x,min.y/v.y,max.x/v.x,max.y/v.y )
	End
	
	#rem monkeydoc Adds a vector to the rect and returns the result.
	#end
	Operator+:Rect( v:Vec2<T> )
		Return New Rect( min+v,max+v )
	End
	
	#rem monkeydoc Subtracts a vector from the rect and returns the result.
	#end
	Operator-:Rect( v:Vec2<T> )
		Return New Rect( min-v,max-v )
	End
	
	#rem monkeydoc Adds another rect to the rect.
	#end
	Operator+=( r:Rect )
		min+=r.min
		max+=r.max
	End
	
	#rem monkeydoc Subtracts another rect from the rect.
	#end
	Operator-=( r:Rect )
		min-=r.min
		max-=r.max
	End

	#rem monkeydoc Multiples the rect by a vector.
	#end
	Operator*=( v:Vec2<T> )
		min*=v
		max*=v
	End
	
	#rem monkeydoc Divides the rect by a vector.
	#end
	Operator/=( v:Vec2<T> )
		min/=v
		max/=v
	End
	
	#rem monkeydoc Adds a vector to the rect.
	#end
	Operator+=( v:Vec2<T> )
		min+=v
		max+=v
	End
	
	#rem monkeydoc Subtracts a vector from the rect.
	#end
	Operator-=( v:Vec2<T> )
		min-=v
		max-=v
	End
	
	#rem monkeydoc Computes the intersection of the rect with another rect and returns the result.
	#end
	Operator&:Rect( r:Rect )
		Local x0:=Max( min.x,r.min.x )
		Local y0:=Max( min.y,r.min.y )
		Local x1:=Min( max.x,r.max.x )
		Local y1:=Min( max.y,r.max.y )
		Return New Rect( x0,y0,x1,y1 )
	End

	#rem monkeydoc Computes the union of the rest with another rect and returns the result.
	#end	
	Operator|:Rect( r:Rect )
		Local x0:=Min( min.x,r.min.x )
		Local y0:=Min( min.y,r.min.y )
		Local x1:=Max( max.x,r.max.x )
		Local y1:=Max( max.y,r.max.y )
		Return New Rect( x0,y0,x1,y1 )
	End
	
	#rem monkeydoc Intersects the rect with another rect.
	#end
	Operator&=( r:Rect )
		min.x=Max( min.x,r.min.x )
		min.y=Max( min.y,r.min.y )
		max.x=Min( max.x,r.max.x )
		max.y=Min( max.y,r.max.y )
	End
	
	#rem monkeydoc Unions the rect with another rect.
	#end
	Operator|=( r:Rect )
		min.x=Min( min.x,r.min.x )
		min.y=Min( min.y,r.min.y )
		max.x=Max( max.x,r.max.x )
		max.y=Max( max.y,r.max.y )
	End
	
	#rem monkeydoc Gets the rect centered within another rect.
	#end 
	Method Centered:Rect( r:Rect )
		Local x:=(r.Width-Width)/2+r.min.x
		Local y:=(r.Height-Height)/2+r.min.y
		Return New Rect( x,y,x+Width,y+Height )
	End
	
	#rem monkeydoc Checks if the rect contains a vector or another rect.
	#end
	Method Contains:Bool( v:Vec2<T> )
		Return v.x>=min.x And v.x<max.x And v.y>=min.y And v.y<max.y
	End
	
	Method Contains:Bool( r:Rect )
		Return min.x<=r.min.x And max.x>=r.max.x And min.y<=r.min.y And max.y>=r.max.y
	End
	
	#rem monkeydoc Checks if the rect intersects another rect.
	#end
	Method Intersects:Bool( r:Rect )
		Return r.max.x>min.x And r.min.x<max.x And r.max.y>min.y And r.min.y<max.y
	End
	
	#rem monkeydoc Gets a string describing the rect.
	
	Deprecated: Use Operator To:String instead.
	
	#end
	Method ToString:String()
		Return Self
	End

	#rem monkeydoc Creates a stack of rectangles tiled within this rectangle.
	@author iDkP for GaragePixel
	@since 2025-05-23
	
	This method generates rectangles in tiling patterns specified by the TileMode parameter.
	It supports left/right/center horizontal alignment and top/bottom/center vertical alignment, 
	and horizontal/vertical fitting.

	Note: No clipping is performed on the generated rectangles. When using for graphics
	rendering, apply scissoring/clipping to the original rectangle to prevent drawing outside bounds.

	The Tiled method generates all rectangles that would be needed for a complete tiling pattern, 
	including those that would extend beyond the boundary of the original rectangle. 
	This approach maximizes flexibility and performance by allowing the graphics system to handle clipping 
	through hardware scissoring rather than creating partial rectangles, which would be computationally expensive.

	For graphics rendering implementations, simply apply your engine's scissoring or clipping functionality 
	to the original rectangle bounds before drawing the returned stack of rectangles.
	
	@param tile Rectangle to be used as the tiling pattern
	@param mode Controls tiling arrangement (combination of horizontal and vertical modes)
	
	@return Stack of rectangles representing the tiles, or Null if tile has zero dimensions
	#end 	
	Method Tiled<T>:Stack<Rect<T>>( tile:Rect<T>, mode:TileMode=TileMode.Tiled ) Where T Implements IReal Or T Implements INumeric

		' iDkP 2025-05-23:
		'
		' This method uses pointer-based closures to dynamically construct optimal tiling patterns at runtime. 
		' The dual generic parameters allow for mixed-type operations, such as tiling float-based rectangles 
		' within integer-based boundaries. The center alignment logic ensures true visual centering by forcing 
		' odd-numbered tile counts.
		'
		' No clipping is performed on the generated rectangles - when using for graphics rendering, 
		' you must apply scissoring to the original rectangle to prevent drawing outside its boundaries. 
		' This approach maximizes rendering performance by leveraging hardware clipping rather than creating 
		' partial rectangles.

		'------- Guards -------

		If tile.min.x=tile.max.x Or tile.min.y=tile.max.y 'Do not store 'flat' tile
			'Comparing by check typing is faster that computing the sizes or counting the stack
			Return Null
		End
		
		Local result:=new Stack<Rect<T>>()

		If mode = TileMode.Fit 'Semi-Guard
			result.Add(Self)
			Return result 
		End
		
		'------- Setup -------

		Local scalex:Float
		Local scaley:Float
		
		'------- Steppers -------

		Local startx:T
		Local starty:T
		Local endx:T
		Local endy:T
		Local stepx:T
		Local stepy:T
		Local sizetx:T
		Local sizety:T
		
		'------- Define the program handles -------
		
		' _closure_ -> closure looks like stoke uppon something
		
		'We program dynamically the nested-loops using closures defined as:
		
		Local _programX_:Void(				tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			)
		
		Local _programY_:Void(				programx:Void(	tile:Rect<T> Ptr,
															startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
															sizetx:T Ptr,sizety:T Ptr		),

											tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			) 
		
		
		'------- Define the programs -------
		
		'Each programs is wrote as lambda embeddable in the closures
		
		' Program x Tile
		
		Local program_x_Tile:=Lambda(		tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			)
										
			For Local x:T=startx[0] Until endx[0] Step stepx[0]

				result.Add(	New Rect<T>(	x,
											y[0],
											x+sizetx[0],
											y[0]+sizety[0]	)	)
			End
		End

		' Program x Fit
		
		Local program_x_Fit:=Lambda(		tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			)
			
			result.Add(		New Rect<T>(	startx[0],
											y[0],
											startx[0]+sizetx[0],
											y[0]+sizety[0]	)	)
		End

		' Program y Tile
		
		Local program_y_Tile:=Lambda(		programx:Void(	tile:Rect<T> Ptr,
															startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
															sizetx:T Ptr,sizety:T Ptr),
														
											tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			)

			Local CastTyPtr:T Ptr 			'memoirize (only one pointer will be enough)
										
			For Local y:T=starty[0] Until endy[0] Step stepy[0]
				
				CastTyPtr=Varptr(y)
				
				programx(					tile,
											startx,endx,starty,endy,stepx,stepy,CastTyPtr,sizetx,sizety)
			End
		End 

		' Program y Fit
		
		Local program_y_Fit:=Lambda(		programx:Void(	tile:Rect<T> Ptr,
															startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,y:T Ptr,
															sizetx:T Ptr,sizety:T Ptr),
														
											tile:Rect<T> Ptr,
											startx:T Ptr,endx:T Ptr,starty:T Ptr,endy:T Ptr,stepx:T Ptr,stepy:T Ptr,
											sizetx:T Ptr,sizety:T Ptr			)
										
			programx(						tile,
											startx,endx,starty,endy,stepx,stepy,starty,sizetx,sizety)
		End
		
		'------- Parametrize the modes -------
		
		'The steppers are set and the programs are choosen to be mounted in the closures
		
		'Select mode X (horizontal alignment)
		Select UByte(mode) & $F0
			Case TileMode.Right
				startx=X+Width-tile.Width
				endx=X-tile.Width
				stepx=-tile.Width
				scalex=1
				sizetx=scalex*tile.Width
				_programX_=program_x_Tile
			Case TileMode.CenterX
				Local centerX:Float = X + Width / 2
				Local tileCount:Int = Int(Width / tile.Width) 'Calculate center of pattern
				If tileCount Mod 2 = 0 tileCount += 1  'Ensure odd number for true center
				Local halfTiles:Int = tileCount / 2
				startx = (centerX - halfTiles*tile.Width - tile.Width/2)-tile.Width 'Position first tile so middle tile is centered
				endx = X + Width + tile.Width
				stepx=tile.Width
				scalex=1
				sizetx=scalex*tile.Width
				_programX_=program_x_Tile
			Case TileMode.FitH
				startx=X
				scalex=Width/tile.Width
				sizetx=scalex*tile.Width
				_programX_=program_x_Fit
			Default 'Left
				startx=X
				endx=Width+tile.Width+tile.Width
				stepx=tile.Width
				scalex=1
				sizetx=scalex*tile.Width
				_programX_=program_x_Tile
		End
		
		'Select mode Y (vertical alignment)
		Select UByte(mode) & $0F
			Case TileMode.Bottom
				starty=Y+Height-tile.Height
				endy=Y-tile.Height
				stepy=-tile.Height
				scaley=1
				sizety=scaley*tile.Height
				_programY_=program_y_Tile
			Case TileMode.CenterY
				Local centerY:Float = Y + Height / 2
				Local tileCount:Int = Int(Height / tile.Height) 'Calculate center of pattern
				If tileCount Mod 2 = 0 tileCount += 1  'Ensure odd number for true center
				Local halfTiles:Int = tileCount / 2
				starty = (centerY - halfTiles*tile.Height - tile.Height/2)-tile.Height 'Position first tile so middle tile is centered
				endy = Y + Height + tile.Height
				stepy=tile.Height
				scaley=1
				sizety=scaley*tile.Height
				_programY_=program_y_Tile
			Case TileMode.FitV
				starty=Y
				scaley=Height/tile.Height
				sizety=scaley*tile.Height
				_programY_=program_y_Fit
			Default 'Top
				starty=Y
				endy=Height+tile.Height+tile.Height
				stepy=tile.Height
				scaley=1
				sizety=scaley*tile.Height
				_programY_=program_y_Tile
		End
		
		'------- Run the program -------
		
		'Procedure call: Now, we can run the main closure who will executes the choosen programs
		_programY_(_programX_,Varptr(tile),Varptr(startx),Varptr(endx),Varptr(starty),Varptr(endy),Varptr(stepx),Varptr(stepy),Varptr(sizetx),Varptr(sizety))

		Return result
	End
End

#rem monkeydoc Transforms a Rect\<Int\> by an AffineMat3.
#end
Function TransformRecti<T>:Recti( rect:Recti,matrix:AffineMat3<T> )
	
	Local min:=matrix * New Vec2<T>( rect.min.x,rect.min.y )
	Local max:=matrix * New Vec2<T>( rect.max.x,rect.max.y )
		
	Return New Recti( Round( min.x ),Round( min.y ),Round( max.x ),Round( max.y ) )
End

