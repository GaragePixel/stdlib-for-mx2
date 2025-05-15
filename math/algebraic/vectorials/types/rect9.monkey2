#rem

	Rect9 Test
	iDkP from GaragePixel
	2022-08-10 - 2025-05-15 (stdlib integration)
#end 

#Import "<stdlib>"
#Import "<sdk_mojo>"

'Using monkey.math
'Using monkey.types
Using stdlib.math.types..
Using stdlib.graphics..
Using sdk_mojo.m2..


'========================================================================================
'------------------------------------------------------------------------------ TEST
'========================================================================================

'========================================================================================
'------------------------------------------------------------------------------ TEST
'========================================================================================

Public 

Function DeviceSize:Vec2i(win:Window)
	Return win.Frame.Size
End

Const WIDTH:Int=1280
Const HEIGHT:Int=720

Class MyWindow Extends Window
	
	Field myRect9:Rect9i
	
	Method New(title:String,width:Int,height:Int,flags:WindowFlags=Null)
		Super.New(title,width,height,flags)
		
		myRect9=New Rect9i(10,10,200,200,50,150,100,100)
		
	End Method
	
	Method OnRender(canvas:Canvas) Override
		
		App.RequestRender()
		
		'----------------- Quit the app
		If Keyboard.KeyDown(Key.Escape|Key.Raw)
			App.Terminate()
		Endif	
		
		'----------------- Get some features
		Local winSize:=DeviceSize(Self)
		Local MousePos:=MouseLocation
		
		'---------------------------------- These following operations demonstrates
		'---------------------------------- some setting capabilities of Rect9
		
		'----------------- Resize the Rect9 within the App's window
		myRect9.Origin=New Vec2i(10,10)
		myRect9.Size=New Vec2i(winSize.x-20,winSize.y-20)
		
		'----------------- Set the MarginsRect at some absolute positions (locking)
		myRect9.Pad(100,100,winSize.x-100,winSize.y-100)
		
		'----------------- Lock the (margins) right edge at an absolute position
		myRect9.PadRight=600
		
		'----------------- Use the properties to resize the rect
		myRect9.Origin=New Vec2i(20,20) ' same than TopLeft
		myRect9.BottomRight=New Vec2i(winSize.x-20,winSize.y-20)
		
		'----------------- Move the rect using the accremental add operator
		myRect9+=New Vec2i(10,10)
		
		'----------------- Move the rect without changing the edge's absolute position 
		'					(Lock mode)
		myRect9 = myRect9.ResizeRect(150,myRect9.min.y,myRect9.max.x,myRect9.max.y)
		
		'----------------- Left will move with the left-edge padding keeped at 0
		myRect9.Left=100
		
		'----------------- Left will move, the MarginsRect's left's edge is locked
		myRect9 = myRect9.ResizeLeft(50)

		'---------------------------------- These following operations demonstrates
		'---------------------------------- how using the "contrains' functions" per aera 
		'---------------------------------- (corners, margins' rect... )
		
		'----------------- Enlight the Rect9's corner's aeras under the mouse
		canvas.Color = New Color(0,0,1)
		
		If myRect9.CornerTopLeftContains(MousePos) 		
															canvas.DrawRect(myRect9.CornerTopLeft)
		Elseif myRect9.CornerTopMiddleContains(MousePos) 		
															canvas.DrawRect(myRect9.CornerTopMiddle)
		Elseif myRect9.CornerTopRightContains(MousePos) 		
															canvas.DrawRect(myRect9.CornerTopRight)
		Elseif myRect9.CornerMiddleLeftContains(MousePos) 		
															canvas.DrawRect(myRect9.CornerMiddleLeft)
		Elseif myRect9.CornerMiddleRightContains(MousePos) 	
															canvas.DrawRect(myRect9.CornerMiddleRight)		
		Elseif myRect9.CornerBottomLeftContains(MousePos) 		
															canvas.DrawRect(myRect9.CornerBottomLeft)
		Elseif myRect9.CornerBottomMiddleContains(MousePos) 	
															canvas.DrawRect(myRect9.CornerBottomMiddle)
		Elseif myRect9.CornerBottomRightContains(MousePos) 	
															canvas.DrawRect(myRect9.CornerBottomRight)
		Elseif myRect9.CornerMiddleContains(MousePos) 			
															canvas.Color = New Color(0,0,1,0.3)
															canvas.DrawRect(myRect9.CornerMiddle)			
		End
		
		'----------------- Draw the Rect9's wireframe with the MojoRect9 extension
		canvas.Rect9.Draw(myRect9,New Color(1,0,0),New Color(1,1,0))
		
		'----------------- Draw some dummies at the middles of the rect8's edges
		canvas.Translate(-5,-5)
		canvas.Color = New Color(1,1,1)
		DrawText(canvas,"X",	myRect9.MiddleTop)
		DrawText(canvas,"X",	myRect9.MiddleBottom)
		DrawText(canvas,"X",	myRect9.MiddleLeft)
		DrawText(canvas,"X",	myRect9.MiddleRight)
		DrawText(canvas,"X",	myRect9.Center)
		
		'----------------- Draw some dummies at the rect8's corners
		DrawText(canvas,"O",	myRect9.TopLeft)
		DrawText(canvas,"O",	myRect9.BottomLeft)
		DrawText(canvas,"O",	myRect9.TopRight)
		DrawText(canvas,"O",	myRect9.BottomRight)	
		
		'----------------- Change the color according the OverPad-test
		If myRect9.OverPad
			canvas.Color = New Color(1,.8,1)
			'Redraw the MarginsRect with the ~new color and using the old matrix
			canvas.Translate(5,5)
			Local newcolor:=canvas.Color
			newcolor.r/=2
			newcolor.g/=2
			newcolor.b/=2
			canvas.Rect9.DrawMarginsRect(myRect9,newcolor) ' Draw with the MojoRect8 extension
			canvas.Translate(-5,-5)
		Else 
			canvas.Color = New Color(.8,0,.8)
		End 
		
		'----------------- ZeroPad-test, change for a more enlighted color :P
		If myRect9.ZeroPad
			canvas.Translate(5,5)
			canvas.Rect9.DrawMarginsRect(myRect9,New Color(1,1,1)) ' Draw with the MojoRect8 extension
			canvas.Translate(-5,-5)
		End 		
		
		'----------------- Draw some dummies at the middles of the rect8's MarginsRect's edges
		DrawText(canvas,"x",	myRect9.MarginsMiddleTop)
		DrawText(canvas,"x",	myRect9.MarginsMiddleBottom)
		DrawText(canvas,"x",	myRect9.MarginsMiddleLeft)
		DrawText(canvas,"x",	myRect9.MarginsMiddleRight)
		DrawText(canvas,"x",	myRect9.MarginsCenter)
		
		'----------------- Draw some dummies at the rect8's MarginsRect's corners
		DrawText(canvas,"o",	myRect9.MarginsTopLeft)
		DrawText(canvas,"o",	myRect9.MarginsBottomLeft)
		DrawText(canvas,"o",	myRect9.MarginsTopRight)
		DrawText(canvas,"o",	myRect9.MarginsBottomRight)	
		
		'----------------- Title Rect-centered horizontally, CornerTop-centered vertically
		canvas.Color = New Color(0,1,0)
		Local title:="Rect8 exemple"
		'okay, it's not really x-centered ^^'
		canvas.DrawText(title,myRect9.Center.x-(4*title.Length),myRect9.CornerTopMiddle.Center.y)
		canvas.Flush() ' A-la Morpheus' style
		
		'----------------- Print some infos
		canvas.Color = New Color(1,1,1)
		canvas.DrawText("Resizes the window and moves the mouse around^^",20,20)
		
		'----------------- Print the formal data
		canvas.DrawText(myRect9,20,40)		
		canvas.DrawText("MarginsRect's right edge's absolute position : "+myRect9.PadRight,20,60)		
	End
	
	Function DrawText(canvas:Canvas,txt:string,pos:Vec2i)
		' Sugar...
		canvas.DrawText(txt,pos.x,pos.y)
	End
End			

Function Main()

	New AppInstance
	
	New MyWindow("",WIDTH,HEIGHT,WindowFlags.Resizable)

	App.Run()
End
