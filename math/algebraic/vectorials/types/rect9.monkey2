
Namespace stdlib.math.types

'#Import "../../../../syntax/swaps"
'#Import "../../truncatives/minmax"

'Using monkey.types
'Using monkey.math
''Using stdlib.math.types..
''Using stdlib.math.matrices..
'Using aida.std.math.algebraic.truncatives.minmax
'Using stdlib.syntax.swaps

'Alias mnmx:aida.std.math.algebraic.truncatives.minmax

Using stdlib.math.types..
Using stdlib.math.matrices..

#rem

	Library: stdlib & Aida.std & std
	Author: iDkP for GaragePixel
	Since: 2021-01-07
	Version: 2025-05-29

	Version 1.0 - 2025-05-29 - 2025-05-14
		2025-05-29 - Important fix: the original implementation since 2021 was incompletly adapted
		2025-05-29 - Added a user guide and important feature's summary
		2025-05-29 - Added batch operations: MoveOutterBorders, MoveInnerBorders
		2025-05-24 - Added new capabilities in rect, related to rect9, about tiling
		2025-05-18 - New generalist graphical functions for mojo and sdk_mojo (DrawImageFit, DrawImageTiled)
		2025-05-17 - Graphical Rect9 functions for mojo and sdk_mojo
		2025-05-17 - Added Vertices, Corners, NotCorners, Aeras and AerasClock (new properties)
		2025-05-16 - Graphical debugmode functions for mojo and sdk_mojo
		2025-05-15 - Integration in stdlib, new name (rect9)
	Version 0.1 - 2021-02-11 - 2021-01-27
		2021-02-11 - The rect9's rewrote in a geoms-module style
		2021-02-04 - First test V0.1
		2021-01-27 - Rect9 idea (implementation of some old stuff from 2007 and new intuitions)

	Purpose:
		The Rect9 class provides support for manipulating 
		rectangular regions with nine sub regions.

	Example usages:
		Drawing window's decorations, game's windows/dialog boxes, 
		bitmapped contour aeras, button skins...

	Modern description (2025):

		Purpose:
			Rect9 provides an implementation of the 9-patch rectangle system commonly used in UI development. 
			This technique divides a rectangle into 9 distinct regions that can be independently manipulated 
			for creating scalable UI elements while maintaining proper border aesthetics when resized.

		Functionalities:
			- Complete 9-patch representation with discrete control of all patch regions
			- Direct component access for fine-grained control of individual patches
			- Efficient memory layout optimized for both CPU and GPU operations
			- Region-aware scaling that preserves corner dimensions while properly stretching edges
			- Comprehensive constructor set supporting multiple initialization patterns
			- Robust geometric operations including translation, scaling, and intersection
			- Internal/external boundary calculations for content placement    
				
		Application examples: 
			- Window/Panel Skinning with nine-Slice Scaling
			- Custom Dialog Box Layouts
			- Bitmap/Texture Border Rendering
			- Collision Zones/Physics engine boundary systems
			- Map/Grid Region Partitioning/Procedural generation (region-based map creation)
			- Padding-Aware Drawing
			- Resizable Sprite Framing
			- Advanced Clipping or Masking
		
		Technical:
			Stores only two rects (outer, inner) and four paddings, deriving all nine-region aeras on demand. 
			This minimizes memory and avoids bloat, with calculation deferred until needed.

			Dozens of properties and 100+ methods/operators, covering all sensible geometric, logical, 
			and arithmetic operations. Includes intersection, union, scaling, conversion, containment, 
			centering, and more.		

			| Element            | Count |
			|--------------------|-------|
			| Properties         | 91    |
			| Operators          | 29    |
			| Pseudo-operators   | 28    |
			| Functions          | 77    |
			| Private functions  | 11    |
			| Constructors       | 7     |
		
		Description of the model:
		
			| A B C |
			| D E F | <- 9-patch region layout
			| G H I |
			
			This division allows for:
			
			- Non-scaling corners (A, C, G, I)
			- Horizontally scalable top/bottom edges (B, H)
			- Vertically scalable side edges (D, F)
			- Fully scalable center region (E)
			
		A nice implementation:

			Rect9 embodies my philosophy about proper mathematics in game development: 
			data-first primitives over engine-locked components. 
			Where google-godot implemented nine-patch as heavy, 
			scene-integrated nodes focused solely on UI rendering, my implementation delivers 
			a pure mathematical primitive with universal application.

			The core difference is architectural: google-godot mixes rendering concerns with geometry, 
			creating rigid, memory-intensive components that only function within their pipeline. 
			Rect9 instead represents the fundamental 9-region concept as a standalone mathematical model, 
			completely decoupled from rendering specifics.

			Rect9 use universal math primitive. Works everywhere: rendering systems, physics collision detection, 
			layout engines, region-specific transforms, even game logic like trigger zones. 
			It's data-first, generic, and expressives a mathematically solution for 9-region probleme. 

			For Monkey2/Wonkey developers needing versatile, reusable, 
			and fully programmable nine-region mathematics, 
			Rect9 delivers superior performance characteristics and cross-domain versatility 
			that engine-tied implementations simply cannot match. 
			One mathematical primitive, universal application for *nearly* anything!

	Original description (2021): Very condensed technical information from the author:

		Rect9/Box9/Pad and other usage names have been part of my structures for decades. 
		In 2021 I came to rewrite it once again, using my latest techniques, 
		to arrive at modeling the problem with only two rectangles; 
		one for the outside, another for the inside, 
		and then also four numeric variables to memoirize the value of the margins 
		in order to balance the entity between the memory and the calculation time it uses. 
		The spaces that we call 9 boxes would then be calculated according to these two rectangles, 
		on demand, and its resizing should be relative, 
		absolute and constrained by an internal validation process. 
		
		I never planned to write 3000 lines of code but simply to write 
		the logic and identities in the form of properties, 
		there are very few sugars but some ready-to-use functionalities 
		like intersections, contains, transpositions and flips. 
		Okay that produced 3000 lines, but it's one of my prettiest classes, 
		and fully documented!
#end

#rem Technical informations

Is Two-Rect Model knows and used elsewhere?
No, this is an original invention by iDkP from GaragePixel.

The "Two-Rect Model"—where a 9-patch or 9-region rectangle is modeled using only two rectangles (outer and inner) plus four paddings, and all nine regions are computed on demand—is not widely documented or standard in most mainstream frameworks or foundational UI/math libraries.
Where It Is (and Isn't) Used
1. Mainstream 9-Patch Implementations (Android, Godot, Qt, Web)

    Android 9-Patch (.9.png)
        Uses bitmap borders to define stretchable areas.
        Internally, Android does calculate regions for stretching, but the API is tied to image rendering and is not exposed as a pure mathematical primitive.
        Does not expose a two-rect pure math abstraction; the regions are inferred at drawing time.

    Godot Engine (NinePatchRect)
        Internally stores margins and draws subregions.
        Exposes margin and patch properties, but does not represent the 9-patch as two rectangles + paddings.
        The model is node-based, not a minimal mathematical primitive.

    Qt (QMargins, QRect, QRectF)
        Exposes rectangles and margins, but not a true 9-region model.
        Composition must be done manually—no dedicated two-rect model.

    CSS Box Model
        Has the concept of content, padding, border, and margin, but not a nine-region or two-rect model with derived subregions.
        All are separate properties, not unified in a geometric primitive.

2. Graphics & Game Libraries

    Most engines (Unity, Unreal, etc.)
        9-slice or 9-patch is implemented for rendering UI, typically by dividing quads or sprites, but not as a pure, reusable two-rect mathematical structure.

3. Academic/Geometric Literature

    General geometric modeling and computational geometry
        There are structures for bounding boxes, margin rects, and region decomposition.
        However, a "two-rect + paddings = 9 regions" abstraction, with all regions derived on demand, is rare as a formally documented pattern.

Technical Advantage of the two-rect model:

The Two-Rect Model is notably unique and advanced:

    Memory efficiency—minimal stored data, with full 9-region semantics.
    Engine independence—it’s a true mathematical primitive, not tied to rendering.
    Derived, not stored—all regions (corners, edges, center) computed as needed, not redundantly stored.

This approach is original and rare, providing both a technical edge and conceptual clarity, especially compared to bulky or engine-locked implementations.

#end 

'========================================================================================
'------------------------------------------------------------------------------ ALIASES
'========================================================================================

#rem monkeydoc Convenience type alias for Rect9\<Int\>.
#end
Alias Rect9i:Rect9<Int>

'#rem monkeydoc Convenience type alias for Rect9\<Short\>.
'#end
'Alias Rect9s:Rect9<Short>

'#rem monkeydoc Convenience type alias for Rect9\<Long\>.
'#end
'Alias Rect9l:Rect9<Long>

#rem monkeydoc Convenience type alias for Rect9\<Float\>.
#end
Alias Rect9f:Rect9<Float>

'#rem monkeydoc Convenience type alias for Rect9\<Double\>.
'#end
'Alias Rect9d:Rect9<Double>

'========================================================================================
'------------------------------------------------------------------------------ STRUCT
'========================================================================================

#rem monkeydoc The Rect9 class provides support for manipulating rectangular regions with nine sub regions.
@author iDkP for GaragePixel
@since 2021-01-07
@version 2025-05-25

This object can to be called "pad". 
		
The programmer can define the pad in two possible ways :
from the rect's border (relative coordinates) 
or from the absolute coordinates
of the "margins-rect" within the rect.

Rect9 provide the "pad"'s properties in order to manipulate
the margins-rect with absolute coordinates.
For the relative coordinates, the vocabulary is about 
"padding".
When it come to access to the nine sub-regions, it used
the word "margins".

	-> 	Absolute coordinates of the "inner-rect" -> "Pad"
	
	-> 	Relative coordinate of the "inner-rect" -> "Padding"
			The coordinates are relative to the 
			same outter-rect's side related the 
			inner-rect's side manipulated.
			Exemple : The outter-rect's right side is 
			related to the outter-rect's right side
			as :
			Inner.Left = Outter.Left	+	MarginsLeft
			Inner.Right = Outter.Right	-	MarginsRight
	
	-> 	Access to the "inner-rect" : "Margins"
	
	-> 	Access around the margins, margins' regions, 
		margins' contains and other tests -> "Corners"
		
	->	The "outter-rect" is the Rect9 aera itself, it use
		no prefixe to manipulate it. Exemple ->  
		Origine/Left/Contains is used to manipulate the 
		rect9's outter-rect's aera directly.

		   				   		Top
		  						/\
	 TopLeft —> |———————|———————————————————|———————————————————| <— TopRight
				|		|	PaddingTop		|					|
				|		|					|CornerTopRight		|
				|		|	MarginsTop		|					|
				|———————|———————————————————|———————————————————|
				|		|					|					|
		Left —>	|		|	CornerMiddle	|CornerMiddleRight	| <— Right
				|		|					|					|
				|———————|———————————————————|———————————————————|
				|		|	MarginsBottom	|					|
				|		|	 				|CornerBottomRight	|
				|		|	PaddingBottom	|					|
  BottomLeft —> |———————|———————————————————|———————————————————| <— BottomRight
								/\
		  					  Bottom	
		  					  
	The outter rect is represented by these getters/setters:
	
		Left/Top/Right/Bottom
		TopLeft/TopRight
		Bottomleft/BottomRight		

	There are some outter rect's positions get-ables:
	
		MiddleLeft/MiddleTop/MiddleRight/MiddleBottom
		MiddleV/MiddleH/Center		
	
	The margins rect is represented by these getters/setters:
	
		MarginsLeft/MarginsTop/MarginsRight/MarginsBottom
		MarginsTopLeft/MarginsTopRight
		MarginsBottomLeft/MarginsBottomRight		

	There are some margins rect's positions get-ables:
	
		MarginsMiddleLeft/MarginsMiddleTop/MarginsMiddleRight/MarginsMiddleBottom
		MarginsMiddleV/MarginsMiddleH/MarginsCenter		
	
	The margins rect is computed by this paddings' getters/setters:
	
		PaddingLeft/PaddingTop/PaddingRight/PaddingBottom
		These parameters can to be called as "the relative coordinates of the margins rect"		
		
	The padding can be setted/getted in absolute coordinates with:
	
		PadLeft/PadTop/PadRight/PadBottom
		These parameters can to be called as "the absolute coordinates of the margins rect"		
		
	The aeras around the margins rect and between the margins and outter rect
	are get by these parameters:
	
		CornerTopLeft/CornerTop/CornerTopRight
		CornerMiddleLeft/CornerMiddle/CornerMiddleRight
		CornerBottomLeft/CornerBottom/CornerBottomRight
		
	Foot Note:

		Designed to have the smallest memory print, 
		it use only 12 reals/numerics types 
		but 51 write-able properties and 39 read-only properties.
		
		The most is programmed in this 91 properties,
		so, against the smallest memory print, the cost is
		some calculation times, kept to reach the optimal
		performances by the extreme binding of the computations.
			
		Rect9 defines 29 operators, 28 pseudo-operators 
		(func operators), 73 public functions, 
		11 private functions and 7 constructors.
			
		The choice to use a rect in order to modelize
		the margins instead to compute it each time
		avoid the managing of some updates/validates commands. 
		It's a compromize between memory and calculations. 
		Also, everything is automatic.

Quick usage guide and some important feature's summaries.
added 2025-05-29

Features:

Minimal storage, maximal access: Rect9 gives you all the nine-patch power you want, 
with just two rects and four paddings under the hood.

The most important feature of the Rect9 struct is its minimal-memory, 
maximal-functionality 9-region model—specifically, the way it only stores two rectangles 
(outer and inner) plus four paddings, yet exposes full nine-patch logic and 91+ properties for UI, 
graphics, and math workflows. Only two rects and four paddings are ever stored, 
so memory use is minimal regardless of how many Rect9s exist.

All derived geometry—edges, corners, center, paddings, margins, regions are computed on demand. 
This exposes 9-patch semantics (stretchable edges, fixed corners) with zero redundancy.
Intuitive math with rects and vectors (+, -, *, &), 
all while maintaining rect integrity and validation.
	
You can use Rect9 for layout, collision, procedural maps, or scalable UI 
without being tied to rendering or a specific engine.

Similar Structures in the Literature:

	Rect9 is a pure mathematical primitive: geometry-first, memory-efficient, and engine-independant, 
	unlike the most current implementations.
	So this is an overview of similar implementations aside my work:
	
	Comparable nine-Region Models:
	
	    google-android nine-Patch (.9.png):
	        Used for scalable UI assets. Defines stretchable regions via 1-pixel borders on a bitmap.
	        Limitation: Tied to rendering pipeline; not a general-purpose geometric primitive.
		        
	    google-godot Engine NinePatchRect:
	        Node for scalable UI panels. Exposes margin and patch region properties.
	        Limitation: Engine-coupled, with less geometric expressiveness and no math operators.
		        
	    Qt QMargins/QRect/QRectF:
	        Offers margin and rectangle manipulation (no true nine-region model).
	        Limitation: No native nine-patch logic—composition required for similar effect.
		        
	    CSS Box Model (Web):
	        Conceptual separation of margin, border, padding, content—no nine-region math, but similar intent.
	        Limitation: Declarative, not a code object; no direct math operations.
	        Anyway the CSS model can produces negative marges, my model no (it performs a validation).
	
A quick user guide:
	
Use margin (outer rect: Margins) for moving the exterior outward.
Use padding (inner rect: Padding/Pad) for moving the interior inward.

Moving the Exterior (Applying Margins / Expanding Outward):

	To "move" or expand the outer rectangle (give it a margin, or make the entire rect9 larger), 
	you work with operations that adjust the outer bounds. 
	This is like adding margin around the entire rect9. Typical approaches:
		
		- Direct Outer Rect Manipulation:
			Set the Outer property directly, or use methods/operators that modify the outer rectangle.
				
		- Margin Properties:
			Properties like MarginsLeft, MarginsTop etc, allow you to grow or shrink the overall bounds.
			    - Increasing these values expands the rect outward.
			    - Decreasing contracts it inward (shrinks toward the center).
				    
		- Operators:
			Overloaded operators like + or | may support union or expansion with another rect 
			or margin vector.	

	    - Use batch operation:
	    	MoveOutterBorders()
				
	Code example:
		
		' Expand the entire rect outward by 10 units on each side:
		rect.Outer = rect.Outer + New Recti(10,10,10,10)
		
		' OR:
		rect.MarginsTop -= 10
		rect.MarginsBottom += 10
		rect.MarginsLeft -= 10
		rect.MarginsRight += 10
		
		' OR, Optimized:
		MoveOutterBorders(10,10,10,10)
		
		' OR, concatenated:
		MoveOutterBorders(10)
		
Moving the Interior (Applying Padding / Contracting Inward):

	To move the inner rectangle inward (like adding padding, 
	or shrinking the usable area inside the rect9), 
	work with inner bounds or the padding properties:
		
	    - Direct Inner Rect Manipulation:
	    	Set the Inner property to adjust the area inside the 9 regions.
		    	
	    - Padding Properties:
	    		Properties like PaddingLeft, PaddingTop etc., let you 
	    		grow or shrink the inner area relative to the outer rectangle.
	        		- Increasing padding moves the inner rect inward 
	        		(shrinks the center area, thickens the borders).
	        		- Decreasing padding expands the center region (thinner borders).
		        		
	    - Pad Properties:
	    	Properties like PadLeft or methods prefixed with Pad provide control 
	    	over the inner rect position in absolute (screen) coordinate, 
	    	regardless of the outer rect.
		    	
	    - Use batch operation:
	    	MoveInnerBorders()
		   
   Code example:
	   
		' Move the inner rect inward by 8 pixels (thicker padding):
		rect.PaddingLeft += 8
		rect.PaddingRight -= 8
		rect.PaddingTop += 8
		rect.PaddingBottom -= 8
		
		' OR, direct assignment:
		rect.Inner = rect.Inner - New Recti(-8,-8,-8,-8)
		
		' OR, optimized:
		MoveInnerBorders(8,8,8,8)

		' OR, concatenated:
		MoveInnerBorders(8)

Notes:
	
    - All adjustments are validated: Mutating operations (+=, etc.) 
    automatically update dependent properties, keeping the rect valid.
    - Margin and padding are conceptually separate: margin affects the container (outer rect), 
    padding affects the content (inner rect).
    - For most UI scenarios, adjust padding to shrink usable content (move inward), 
	and margins to affect the overall placement/size (move outward).
	
#end 

Struct Rect9<T>
	
	'----------------------------------------------------
	'---------------------------------------------------- Constructors
	'----------------------------------------------------
	Public
	'----------------------------------------------------
	#rem monkeydoc Creates a new Rect9.
	#end
	Method New()
		Init()
	End	
	
	#rem monkeydoc Creates a new Rect9.	
	@param rect object from the Rect class.
	@param padLeft the padding from the left border in pixels.
	@param padTop the padding from the top border in pixels.
	@param padRight the padding from the right border in pixels.
	@param padBottom the padding from the bottom border in pixels.
	#end		
	Method New(	rect:Rect<T>,
				padLeft:T=0,padTop:T=0,padRight:T=0,padBottom:T=0	)
				
		_rect0=New Rect<T>()
		_rect0=rect
		_rect1=New Rect<T>()		
		Init(padLeft,padTop,padRight,padBottom)	
	End 

	#rem monkeydoc Creates a new Rect9.
	@param min the left top corner coordinates
	@param min the right bottom corner coordinates
	@param padLeft the padding from the left border in pixels.
	@param padTop the padding from the top border in pixels.
	@param padRight the padding from the right border in pixels.
	@param padBottom the padding from the bottom border in pixels.
	#end			
	Method New(	min:Vec2<T>,max:Vec2<T>, 
				padLeft:T=0,padTop:T=0,padRight:T=0,padBottom:T=0	)
				
		_rect0=New Rect<T>()
		_rect0.min=min
		_rect0.max=max
		_rect1=New Rect<T>()		
		Init(padLeft,padTop,padRight,padBottom)	
	End

	#rem monkeydoc Creates a new Rect9.
	@param x0 the left top corner x coordinates
	@param y0 the left top corner y coordinates
	@param x1 the right bottom corner x coordinates
	@param y1 the right bottom corner y coordinates
	@param padLeft the padding from the left border in pixels.
	@param padTop the padding from the top border in pixels.
	@param padRight the padding from the right border in pixels.
	@param padBottom the padding from the bottom border in pixels.
	#end		
	Method New(	x0:T,y0:T,x1:T,y1:T,
				padLeft:T=0,padTop:T=0,padRight:T=0,padBottom:T=0	)
				
		_rect0=New Rect<T>()
		_rect0.min=New Vec2<T>(x0,y0)
		_rect0.max=New Vec2<T>(x1,y1)
		_rect1=New Rect<T>()		
		Init(padLeft,padTop,padRight,padBottom)				
	End

	#rem monkeydoc Creates a new Rect9.
	@param x0 the left top corner x coordinates
	@param y0 the left top corner y coordinates
	@param max The size of the rectangle from the left top side toward the bottom way
	@param padLeft the padding from the left border in pixels.
	@param padTop the padding from the top border in pixels.
	@param padRight the padding from the right border in pixels.
	@param padBottom the padding from the bottom border in pixels.
	#end		
	Method New(	x0:T,y0:T,max:Vec2<T>,
				padLeft:T=0,padTop:T=0,padRight:T=0,padBottom:T=0	)
				
		_rect0=New Rect<T>()
		_rect0.min=New Vec2<T>(x0,y0)
		_rect0.max=_rect0.max
		_rect1=New Rect<T>()		
		Init(padLeft,padTop,padRight,padBottom)			
	End

	#rem monkeydoc Creates a new Rect9.
	@param min The position of the rectangle from the left top corner
	@param x1 the right bottom corner x coordinates
	@param y1 the right bottom corner y coordinates
	@param padLeft the padding from the left border in pixels.
	@param padTop the padding from the top border in pixels.
	@param padRight the padding from the right border in pixels.
	@param padBottom the padding from the bottom border in pixels.
	#end	
	Method New(	min:Vec2<T>,x1:T,y1:T,
				padLeft:T=0,padTop:T=0,padRight:T=0,padBottom:T=0	)
				
		_rect0=New Rect<T>()
		_rect0.min=min
		_rect0.max=New Vec2<T>(x1,y1)
		_rect1=New Rect<T>()		
		Init(padLeft,padTop,padRight,padBottom)				
	End	

	#rem monkeydoc Creates a new Rect9.
	@param paddings the 4 values padding Left, Top, Right, Bottom in a Vec4.
	The padding is always in this order : 
	Left, Top, Right, Bottom	
	#end	
	Method New(	rect:Rect<T>,
				paddings:Vec4<T>	)
		'the vec4 is used to define the padding in this order : 
		'Left, Top, Right, Bottom
		_rect0=rect
		_rect1=New Rect<T>()
		Init(paddings.w,paddings.x,paddings.y,paddings.z)				
	End 	

	'----------------------------------------------------
	'---------------------------------------------------- Properties : Rects
	'----------------------------------------------------
	
	#rem monkeydoc The outter rect.
	#end	
	Property Outter:Rect<T>()
		Return _rect0
	Setter(r:Rect<T>)
		_rect0=r
		Update()
		Validate()
	End	
	
	#rem monkeydoc Get the margins rect.
	
	Set the absolute coordinate of the pad.
	
	The padding (relative coordinate of the pad from the outter rect) 
	is auto-updated and validated with no time.
	
	The margins rect is always within the outter rect. But in the other case,
	the validation will keep the datas manifold.
	#end	
	Property Inner:Rect<T>()
		Return _rect1
	Setter(r:Rect<T>)
		Pad(r)
	End	
		
	'----------------------------------------------------
	'---------------------------------------------------- Convertors
	'----------------------------------------------------	
	
	#rem monkeydoc Converts the rect9 to a rect9 of a different type.
	#end
	Operator To<T2>:Rect9<T2>()
		'
		' Note:
		'	The normal syntax as wrote for Rect doesn't works:
		'		Operator To<C>:Rect9<C>()
		'			Return New Rect9<C>(New Rect<C>(_rect0.min.x,_rect0.min.y,_rect0.max.x,_rect0.max.y),PaddingLeft,PaddingTop,PaddingRight,PaddingBottom)
		'		End
		'
		'	This alternative neither:
		'		Operator To<T2>:Rect9<T2>()
		'			Return New Rect9<T2>(New Rect<T2>(_rect0.min.x,_rect0.min.y,_rect0.max.x,_rect0.max.y),PaddingLeft,PaddingTop,PaddingRight,PaddingBottom)
		'		End
		'
		'	It's because the type conversion operator works only at the C level for internal datatype only.
		'	So, a solution was found:
		'
		Local r:=New Rect9<T2>
		r._rect0=_rect0	'We cast implicitally at data level!
		r._rect1=_rect1
		r._paddingLeft=_paddingLeft
		r._paddingTop=_paddingTop
		r._paddingRight=_paddingRight
		r._paddingBottom=_paddingBottom
		Return r
	End

	#rem monkeydoc Converts the rect9 to a rect of a different type.
	#end
	Operator To<C>:Rect<C>()
		Return New Rect<C>( min.x,min.y,max.x,max.y )
	End
	
	#rem  monkeydoc Converts the rect9 to a printable string.
	#end
	Operator To:String()
		Return "Rect9("+_rect0.min.x+","+_rect0.min.y+","+_rect0.max.x+","+_rect0.max.y+","+PaddingLeft+","+PaddingTop+","+PaddingRight+","+PaddingBottom+")"
	End	

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Vec2
	'---------------------------------------------------- Operators : Binary operators		
	'---------------------------------------------------- 		
	
	#rem monkeydoc Adds a vector to the rect9 and returns the result.
	#end
	Operator+:Rect9( v:Vec2<T> )
		Local r:=New Rect9( 	_rect0.min+v,_rect0.max+v,
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r.Update()
		r.Validate()
		Return r
	End
	
	#rem monkeydoc Subtracts a vector from the rect9 and returns the result.
	#end
	Operator-:Rect9( v:Vec2<T> )
		Local r:=New Rect9( 	_rect0.min-v,_rect0.max-v,
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r.Update()
		r.Validate()
		Return r
	End
		
	#rem monkeydoc Multiples the rect9 by a vector and returns the result.
	#end
	Operator*:Rect9( v:Vec2<T> )
		Local r:=New Rect9( 	_rect0.min.x*v.x,_rect0.min.y*v.y,_rect0.max.x*v.x,_rect0.max.y*v.y,
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r.Update()
		r.Validate()
		Return r
	End
	
	#rem monkeydoc Divides the rect9 by a vector and returns the result.
	#end
	Operator/:Rect9( v:Vec2<T> )
		Local r:=New Rect9( 	_rect0.min.x/v.x,_rect0.min.y/v.y,_rect0.max.x/v.x,_rect0.max.y/v.y,
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r.Update()
		r.Validate()
		Return r
	End
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Vec2
	'---------------------------------------------------- Operators : Assignment operators		
	'---------------------------------------------------- 			

	#rem monkeydoc Multiples the rect9 by a vector.
	#end
	Operator*=( v:Vec2<T> )
		_rect0.min*=v
		_rect0.max*=v
		Update()
		Validate()
	End
	
	#rem monkeydoc Divides the rect9 by a vector.
	#end
	Operator/=( v:Vec2<T> )
		_rect0.min/=v
		_rect0.max/=v
		Update()
		Validate()
	End
	
	#rem monkeydoc Adds a vector to the rect9.
	#end
	Operator+=( v:Vec2<T> )
		_rect0.min+=v
		_rect0.max+=v
		Update()
		Validate()
	End
	
	#rem monkeydoc Subtracts a vector from the rect9.
	#end
	Operator-=( v:Vec2<T> )
		_rect0.min-=v
		_rect0.max-=v
		Update()
		Validate()
	End
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Rect
	'---------------------------------------------------- Operators : Unary operators		
	'---------------------------------------------------- 	

	#rem monkeydoc Adds another rect to the rect9 and returns the result.
	#end
	Operator+:Rect<T>( r:Rect<T> )
		Return New Rect<T>( _rect0.min+r.min,_rect0.max+r.max )
	End
	
	#rem monkeydoc Subtracts another rect from the rect9 and returns the result.
	#end
	Operator-:Rect<T>( r:Rect<T> )
		Return New Rect<T>( _rect0.min-r.min,_rect0.max-r.max )
	End
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Rect
	'---------------------------------------------------- Operators : Binary operators		
	'---------------------------------------------------- 	
	
	#rem monkeydoc Returns the intersection of the rect9 
	with another rect (intersected).
	#end
	Operator&:Rect<T>( r:Rect<T> )
		Local x0:=Max( _rect0.min.x,r.min.x )
		Local y0:=Max( _rect0.min.y,r.min.y )
		Local x1:=Min( _rect0.max.x,r.max.x )
		Local y1:=Min( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End
	
	#rem monkeydoc Returns the intersection of the rect9 
	with another rect (intersected).
	#end
	Method Intersected:Rect<T>( r:Rect<T> )
		Return Self&r
	End	
	
	#rem monkeydoc Returns the union of the rect9 
	with another rect (united).
	#end	
	Operator|:Rect<T>( r:Rect<T> )
		Local x0:=Min( _rect0.min.x,r.min.x )
		Local y0:=Min( _rect0.min.y,r.min.y )
		Local x1:=Max( _rect0.max.x,r.max.x )
		Local y1:=Max( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End	
	
	#rem monkeydoc Returns the union of the rect9 
	with another rect (united).
	#end
	Method United:Rect<T>( r:Rect<T> )
		Local x0:=Min( _rect0.min.x,r.min.x )
		Local y0:=Min( _rect0.min.y,r.min.y )
		Local x1:=Max( _rect0.max.x,r.max.x )
		Local y1:=Max( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End	
	
	'----------------------------------------------------
	'---------------------------------------------------- Operators : Difference
	'----------------------------------------------------
	
	#rem monkeydoc Returns true if the Rect9 is different to the rect r, 
	otherwise returns false.
	#end
	Operator<>:Bool( r:Rect<T> )
		Return _rect0<>r ?Else False
	End

	#rem monkeydoc Returns true if the Rect9.margins is different to the rect r, 
	otherwise returns false.
	#end
	Method MarginsIsDiff:Bool( r:Rect<T> )
		Return _rect1<>r ?Else False
	End	

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect
	'---------------------------------------------------- Operators : Assignment operators		
	'---------------------------------------------------- 	
	
	#rem monkeydoc Adds another rect to the rect9.
	#end
	Operator+=( r:Rect<T> )
		_rect0.min+=r.min
		_rect0.max+=r.max
	End
	
	#rem monkeydoc Subtracts another rect from the rect9.
	#end
	Operator-=( r:Rect<T> )
		_rect0.min-=r.min
		_rect0.max-=r.max
	End
	
	#rem monkeydoc Intersects the rect9 with another rect.
	#end
	Operator&=( r:Rect<T> )
		_rect0.min.x=Max( _rect0.min.x,r.min.x )
		_rect0.min.y=Max( _rect0.min.y,r.min.y )
		_rect0.max.x=Min( _rect0.max.x,r.max.x )
		_rect0.max.y=Min( _rect0.max.y,r.max.y )
	End
	
	#rem monkeydoc Unions the rect9 with another rect.
	#end
	Operator|=( r:Rect<T> )
		_rect0.min.x=Min( _rect0.min.x,r.min.x )
		_rect0.min.y=Min( _rect0.min.y,r.min.y )
		_rect0.max.x=Max( _rect0.max.x,r.max.x )
		_rect0.max.y=Max( _rect0.max.y,r.max.y )
	End	
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Rect9
	'---------------------------------------------------- Operators : Unary operators	
	'---------------------------------------------------- 	
	
	#rem monkeydoc Adds another rect9 to the rect9 and returns the result.
	#end
	Operator+:Rect9( r:Rect9 )
		Local r0:=New Rect9	( 	_rect0.min+r._rect0.min,_rect0.max+r._rect0.max, 
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r0.Update()
		r0.Validate()
		Return r0
	End
	
	#rem monkeydoc Subtracts another rect9 from the rect9 and returns the result.
	#end
	Operator-:Rect9( r:Rect9 )
		Local r0:=New Rect9	( 	_rect0.min-r._rect0.min,_rect0.max-r._rect0.max,
								_paddingLeft,_paddingTop,_paddingRight,_paddingBottom )
		r0.Update()
		r0.Validate()
		Return r0
	End
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Rect9
	'---------------------------------------------------- Operators : Binary operators		
	'---------------------------------------------------- 	
	
	#rem monkeydoc Returns the intersection of the rect9 
	with another rect (intersected).
	#end
	Operator&:Rect<T>( r:Rect9<T> )
		Local x0:=Max( _rect0.min.x,r.min.x )
		Local y0:=Max( _rect0.min.y,r.min.y )
		Local x1:=Min( _rect0.max.x,r.max.x )
		Local y1:=Min( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End
	
	#rem monkeydoc Returns the intersection of the rect9 
	with another rect (intersected).
	#end
	Method Intersected:Rect<T>( r:Rect9<T> )
		Return Self&r
	End		
	
	#rem monkeydoc Returns the union of the rect9 
	with another rect (united).
	#end	
	Operator|:Rect<T>( r:Rect9<T> )
		Local x0:=Min( _rect0.min.x,r.min.x )
		Local y0:=Min( _rect0.min.y,r.min.y )
		Local x1:=Max( _rect0.max.x,r.max.x )
		Local y1:=Max( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End	
	
	#rem monkeydoc Returns the union of the rect9 
	with another rect (united).
	#end
	Method United:Rect<T>( r:Rect9<T> )
		Local x0:=Min( _rect0.min.x,r.min.x )
		Local y0:=Min( _rect0.min.y,r.min.y )
		Local x1:=Max( _rect0.max.x,r.max.x )
		Local y1:=Max( _rect0.max.y,r.max.y )
		Return New Rect<T>( x0,y0,x1,y1 )
	End	
	
	#rem monkeydoc Returns true if the Rect9 is different to the rect9 r, 
	otherwise returns false.
	#end
	Operator<>:Bool( r:Rect9<T> )
		Return _rect0<>r._rect0 And _rect1<>r._rect1 ?Else False
	End

	#rem monkeydoc Returns true if the Rect9.margins is different to the rect9 r.margins, 
	otherwise returns false.
	#end
	Method MarginsIsDiff:Bool( r:Rect9<T> )
		Return _rect1<>r._rect1 ?Else False
	End		

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9 to Rect9
	'---------------------------------------------------- Operators : Assignment operators		
	'---------------------------------------------------- 			

	#rem monkeydoc Adds another rect to the rect9.
	#end
	Operator+=( r:Rect9 )
		_rect0.min+=r._rect0.min
		_rect0.max+=r._rect0.max
		Update()
		Validate()
	End
	
	#rem monkeydoc Subtracts another rect9 from the rect9.
	#end
	Operator-=( r:Rect9 )
		_rect0.min-=r._rect0.min
		_rect0.max-=r._rect0.max
		Update()
		Validate()
	End
	
	#rem monkeydoc Intersects the rect9 with another rect9.
	#end
	Operator&=( r:Rect9<T> )
		_rect0.min.x=Max( _rect0.min.x,r._rect0.min.x )
		_rect0.min.y=Max( _rect0.min.y,r._rect0.min.y )
		_rect0.max.x=Min( _rect0.max.x,r._rect0.max.x )
		_rect0.max.y=Min( _rect0.max.y,r._rect0.max.y )
		Update()
		Validate()
	End
	
	#rem monkeydoc Unions the rect9 with another rect9.
	#end
	Operator|=( r:Rect9<T> )
		_rect0.min.x=Min( _rect0.min.x,r._rect0.min.x )
		_rect0.min.y=Min( _rect0.min.y,r._rect0.min.y )
		_rect0.max.x=Max( _rect0.max.x,r._rect0.max.x )
		_rect0.max.y=Max( _rect0.max.y,r._rect0.max.y )
		Update()
		Validate()
	End	

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9
	'---------------------------------------------------- Operators : transpose func-operator
	'---------------------------------------------------- 	
	
	#rem monkeydoc Width and height exchanged.
	#end
	Method Transpose()
		Swap(Varptr _paddingRight,Varptr _paddingBottom)
		'Author's note : 
		'	A bit to much complicated to implements 
		'	the -> operator for the rect structure, 
		'	so I've hand-crafted the swap here.
		Local t:=_rect0.max.x
		_rect0.max.x=_rect0.max.y
		_rect0.max.y=t
		Update()
		Validate()
	End	

	#rem monkeydoc Returns a copy of the rectangle 
	that has its width and height exchanged.
	#end
	Method Transposed:Rect9<T>()
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		Swap(Varptr r0._paddingRight,Varptr r0._paddingBottom)
		'Author's note : 
		'	A bit to much complicated to implements 
		'	the -> operator for the rect structure, 
		'	so I've hand-crafted the swap here.
		Local t:=r0._rect0.max.x
		r0._rect0.max.x=r0._rect0.max.y
		r0._rect0.max.y=t		
		r0.Update()
		r0.Validate()
		Return r0	
	End	

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9
	'---------------------------------------------------- Operators : translate func-operator
	'---------------------------------------------------- 	

	#rem monkeydoc Moves the rectangle along the x axis 
	and the y axis, relative to the current position.
	The margins rect is isomorph.
	#end
	Method Translate(x:T,y:T)
		Translate(New Vec2<T>(x,y))
	End		
	
	Method Translate(v:Vec2<T>)
		_rect0+=v
		_rect1+=v
		Update()
		Validate()
	End		

	#rem monkeydoc Returns a copy of the rectangle that is 
	translated along the x axis and the y axis, 
	relative to the current position.
	The margins rect is isomorph.
	#end
	Method Translated:Rect9<T>(x:T,y:T)
		Return Translated(New Vec2<T>(x,y))
	End	
	
	Method Translated:Rect9<T>(v:Vec2<T>)
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0._rect0+=v
		r0.Update()
		r0.Validate()
		Return r0
	End
	
	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9
	'---------------------------------------------------- Operators : move func-operator
	'---------------------------------------------------- 	

	'-------------------------- Positional
	#rem monkeydoc Move the rect9, leaving the top-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end
	Method Move(v:Vec2<T>)
		MoveTopLeft(v)
	End 
	
	'-------------------------- Directional	

	#rem monkeydoc Move the rect9, leaving the left corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MoveLeft(v:T)
		Local oldWidth:=Width
		Left=v
		Right=Left+oldWidth
		UpdateLeft()
		UpdateRight()
		ValidateH()	
	End

	#rem monkeydoc Move the rect9, leaving the top corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MoveTop(v:T)
		Local oldHeight:=Height
		Top=v
		Bottom=Top+oldHeight
		UpdateTop()
		UpdateBottom()
		ValidateV()	
	End

	#rem monkeydoc Move the rect9, leaving the right corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MoveRight(v:T)
		Local oldWidth:=Width
		Right=v
		Left=Right-oldWidth
		UpdateLeft()
		UpdateRight()
		ValidateH()	
	End

	#rem monkeydoc Move the rect9, leaving the bottom corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MoveBottom(v:T)
		Local oldHeight:=Height
		Bottom=v
		Top=Bottom-oldHeight
		UpdateTop()
		UpdateBottom()
		ValidateV()	
	End

	'-------------------------- Bi-Directional

	#rem monkeydoc Move the rect9, leaving the top-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MoveTopLeft(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Top=v.y
		Bottom=Top+oldHeight
		Left=v.x
		Right=Left+oldWidth		
		Update()
		Validate()	
	End 

	#rem monkeydoc Move the rect9, leaving the top-right corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end
	Method MoveTopRight(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Top=v.y
		Bottom=Top+oldHeight
		Right=v.x
		Left=Right-oldWidth		
		Update()
		Validate()				
	End 

	#rem monkeydoc Move the rect9, leaving the bottom-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MoveBottomLeft(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Bottom=v.y
		Top=Bottom-oldHeight
		Left=v.x
		Right=Left+oldWidth			
		Update()
		Validate()							
	End 

	#rem monkeydoc Move the rect9, leaving the bottom-right corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MoveBottomRight(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Bottom=v.y
		Top=Bottom-oldHeight		
		Right=v.x
		Left=Right-oldWidth		
		Update()
		Validate()				
	End 		

	#rem monkeydoc Move the rect9, leaving the center point at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MoveCenter(v:Vec2<T>)
		Local midWidth:=Mid1ds(_rect0.Left,_rect0.Right)
		Local midHeigth:=Mid1ds(_rect0.Top,_rect0.Bottom)
		_rect0.min.x=v.x-midWidth
		_rect0.max.x=v.x+midWidth
		_rect0.min.y=v.y-midHeigth
		_rect0.max.y=v.y+midHeigth
		Update()
		Validate()		
	End 

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9
	'---------------------------------------------------- Operators : moved func-operator
	'---------------------------------------------------- 	

	'-------------------------- Positional
	#rem monkeydoc Moves and return a new Rect9,
	leaving the top-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end
	Method Moved:Rect9<T>(v:Vec2<T>)
		Return MovedTopLeft(v)
	End 
	
	'-------------------------- Directional	

	#rem monkeydoc Moves and return a new Rect9,
	leaving the left corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MovedLeft:Rect9<T>(v:T)
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Left=v
		r0.Right=r0.Left+oldWidth
		r0.UpdateLeft()
		r0.UpdateRight()
		r0.ValidateH()	
		Return r0			
	End

	#rem monkeydoc Moves and return a new Rect9,
	leaving the top corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MovedTop:Rect9<T>(v:T)
		Local oldHeight:=Height
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Top=v
		r0.Bottom=r0.Top+oldHeight
		r0.UpdateTop()
		r0.UpdateBottom()
		r0.ValidateV()	
		Return r0			
	End

	#rem monkeydoc Moves and return a new Rect9,
	leaving the right corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MovedRight:Rect9<T>(v:T)
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Right=v
		r0.Left=r0.Right-oldWidth
		r0.UpdateLeft()
		r0.UpdateRight()
		r0.ValidateH()	
		Return r0			
	End

	#rem monkeydoc Moves and return a new Rect9,
	leaving the bottom corner 
	at the given position v. 
	The rectangle keeps its isomorphism.
	#end
	Method MovedBottom:Rect9<T>(v:T)
		Local oldHeight:=Height
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Bottom=v
		r0.Top=r0.Bottom-oldHeight
		r0.UpdateTop()
		r0.UpdateBottom()
		r0.ValidateV()	
		Return r0	
	End

	'-------------------------- Bi-Directional

	#rem monkeydoc Moves and return a new Rect9,
	leaving the top-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MovedTopLeft:Rect9<T>(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)	
		r0.Top=v.y
		r0.Bottom=r0.Top+oldHeight
		r0.Left=v.x
		r0.Right=r0.Left+oldWidth		
		r0.Update()
		r0.Validate()	
		Return r0						
	End 

	#rem monkeydoc Moves and return a new Rect9,
	leaving the top-right corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end
	Method MovedTopRight:Rect9<T>(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Top=v.y
		r0.Bottom=r0.Top+oldHeight
		r0.Right=v.x
		r0.Left=r0.Right-oldWidth		
		r0.Update()
		r0.Validate()				
		Return r0
	End 

	#rem monkeydoc Moves and return a new Rect9,
	leaving the bottom-left corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MovedBottomLeft:Rect9<T>(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Bottom=v.y
		r0.Top=r0.Bottom-oldHeight
		r0.Left=v.x
		r0.Right=r0.Left+oldWidth			
		r0.Update()
		r0.Validate()						
		Return r0		
	End 

	#rem monkeydoc Moves and return a new Rect9, 
	leaving the bottom-right corner 
	at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MovedBottomRight:Rect9<T>(v:Vec2<T>)
		Local oldHeight:=Height
		Local oldWidth:=Width
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0.Bottom=v.y
		r0.Top=r0.Bottom-oldHeight		
		r0.Right=v.x
		r0.Left=r0.Right-oldWidth		
		r0.Update()
		r0.Validate()				
		Return r0		
	End 		

	#rem monkeydoc Moves and returns a new Rec8, 
	leaving the center point at the given position (x,y). 
	The rectangle keeps its isomorphism.
	#end	
	Method MovedCenter:Rect9<T>(v:Vec2<T>)
		Local midWidth:=Mid1ds(_rect0.Left,_rect0.Right)
		Local midHeigth:=Mid1ds(_rect0.Top,_rect0.Bottom)
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0._rect0.min.x=v.x-midWidth
		r0._rect0.max.x=v.x+midWidth
		r0._rect0.min.y=v.y-midHeigth
		r0._rect0.max.y=v.y+midHeigth
		r0.Update()
		r0.Validate()		
		Return r0
	End 	

	'-------------------------- Transformative
	
	Method Zoom( amount:T )
		_rect0.min.x-=amount
		_rect0.min.y-=amount
		_rect0.max.x+=amount
		_rect0.max.y+=amount
		_rect1.min.x-=amount
		_rect1.min.y-=amount
		_rect1.max.x+=amount
		_rect1.max.y+=amount
	End 

	Method Zoomed:Rect9<T>( amount:T )
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingTop,_paddingRight,_paddingBottom)
		r0._rect0.min.x-=amount
		r0._rect0.min.y-=amount
		r0._rect0.max.x+=amount
		r0._rect0.max.y+=amount
		r0._rect1.min.x-=amount
		r0._rect1.min.y-=amount
		r0._rect1.max.x+=amount
		r0._rect1.max.y+=amount
		Return r0
	End 

	'---------------------------------------------------- 
	'---------------------------------------------------- Rect9
	'---------------------------------------------------- Operators : flip func-operator
	'---------------------------------------------------- 	

	'-------------------------- Flip (on place)

	#rem monkeydoc Flip the rect9 horizontaly and verticaly 
	(margins-rect flipped too).
	#end
	Method Flip()	
		Local t:T
		t=_paddingLeft
		_paddingLeft=_paddingRight
		_paddingRight=t		
		t=_paddingTop
		t=_paddingTop=_paddingBottom
		_paddingBottom=t
		t=_rect0.max.x
		_rect0.max.x=_rect0.min.x
		_rect0.min.x=t	
		t=_rect0.max.y
		_rect0.max.y=_rect0.min.y
		_rect0.min.y=t		
		Update()
		Validate()
	End 		

	#rem monkeydoc Flip the rect9 horizontaly (and the margins-rect too).
	#end
	Method FlipX()	
		Local t:T
		t=_paddingLeft
		_paddingLeft=_paddingRight
		_paddingRight=t	
		t=_rect0.max.x
		_rect0.max.x=_rect0.min.x
		_rect0.min.x=t		
		Update()
		ValidateH()				
	End 

	#rem monkeydoc Flip the rect9 verticaly (and the margins-rect too).
	#end
	Method FlipY()
		Local t:T	
		t=_paddingTop
		t=_paddingTop=_paddingBottom
		_paddingBottom=t
		t=_rect0.max.y
		_rect0.max.y=_rect0.min.y
		_rect0.min.y=t		
		Update()
		ValidateV()
	End 
	
	'-------------------------- Flipped (returns the result)

	#rem monkeydoc Flip the rect9 horizontaly and verticaly 
	(margins-rect flipped too) and returns the result.
	#end
	Method Flipped:Rect9<T>()
		Local r0:=New Rect9(_rect0,_paddingRight,_paddingBottom,_paddingLeft,_paddingTop)
		Local t:=r0._rect0.max.x
		r0._rect0.max.x=r0._rect0.min.x
		r0._rect0.min.x=t	
		t=r0._rect0.max.y
		r0._rect0.max.y=r0._rect0.min.y
		r0._rect0.min.y=t		
		r0.Update()
		r0.Validate()
		Return r0
	End 		

	#rem monkeydoc Flip the rect9 horizontaly (and the margins-rect too)
	and returns the result.
	#end
	Method FlippedX:Rect9<T>()
		Local r0:=New Rect9(_rect0,_paddingRight,_paddingTop,_paddingLeft,_paddingBottom)
		Local t:=r0._rect0.max.x
		r0._rect0.max.x=r0._rect0.min.x
		r0._rect0.min.x=t		
		r0.Update()
		r0.ValidateH()
		Return r0			
	End 

	#rem monkeydoc Flip the rect9 verticaly (and the margins-rect too)
	and returns the result.
	#end
	Method FlippedY:Rect9<T>()
		Local r0:=New Rect9(_rect0,_paddingLeft,_paddingBottom,_paddingRight,_paddingTop)
		Local t:=r0._rect0.max.y
		r0._rect0.max.y=r0._rect0.min.y
		r0._rect0.min.y=t		
		r0.Update()
		r0.ValidateV()		
		Return r0
	End 
	
	'----------------------------------------------------
	'---------------------------------------------------- Properties : States-tests
	'----------------------------------------------------	

	'-------------------------- isFlipped-test

	#rem monkeydoc Test if the left/right or top/bottom edge are inversed.
	#end
	Property isFlipped:Bool()
		Return _rect0.min.x>_rect0.max.x Or _rect0.min.y>_rect0.max.y ?Else False
	End 

	#rem monkeydoc Test if the left/right are inversed.
	#end
	Property isFlippedX:Bool()
		Return _rect0.min.x>_rect0.max.x ?Else False
	End 

	#rem monkeydoc Test if the top/bottom edge are inversed.
	#end
	Property isFlippedY:Bool()
		Return _rect0.min.y>_rect0.max.y ?Else False
	End 
		
	'-------------------------- OverPad-test

	#rem monkeydoc The OverPad-test returns true 
	if the opposite paddings overlaps (virtually, though).
	#end	
	Property OverPad:Bool()
		Return OverPadV Or OverPadH
	End 	

	#rem monkeydoc The OverPad-test returns true 
	if the opposite paddings overlaps (virtually, though).
	
	Vertical version.
	Top and Bottom.
	#end	
	Property OverPadV:Bool()
		Return PadTop>=PadBottom
	End 

	#rem monkeydoc The OverPad-test returns true 
	if the opposite paddings overlaps (virtually, though).
	
	Horizontal version.
	Left and Right.
	#end		
	Property OverPadH:Bool()
		Return PadLeft>=PadRight
	End 	
	
	'-------------------------- ZeroPad-test
	
	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	#end
	Property ZeroPad:Bool()
		Return ZeroPadV Or ZeroPadH
	End 	

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Vertical version.
	Top and Bottom.	
	#end	
	Property ZeroPadV:Bool()
		Return ZeroPadTop Or ZeroPadBottom
	End 

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Horizontal version.
	Left and Right.	
	#end			
	Property ZeroPadH:Bool()
		Return ZeroPadLeft Or ZeroPadRight
	End 

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Horizontal version.
	Left only.	
	#end			
	Property ZeroPadLeft:Bool()
		Return _paddingLeft=0 ?Else False
	End 

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Vertical version.
	Top only.	
	#end		
	Property ZeroPadTop:Bool()
		Return _paddingTop=0 ?Else False
	End 

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Horizontal version.
	Right only.	
	#end
	Property ZeroPadRight:Bool()
		Return _paddingRight=0 ?Else False
	End 

	#rem monkeydoc The ZeroPad-test returns true 
	if the paddings are equal to the outter rect's edges.
	
	Vertical version.
	Bottom only.	
	#end	
	Property ZeroPadBottom:Bool()
		Return _paddingBottom=0 ?Else False
	End 

	'----------------------------------------------------
	'---------------------------------------------------- Properties : math-tests
	'----------------------------------------------------

	#rem monkeydoc Is the rect9 a square?
	#end
	Property Square:Bool()
		Return Height=Width ?Else False
	End 

	#rem monkeydoc Is the margins-rect a square?
	#end
	Property MarginsSquare:Bool()
		Return _rect1.Height=_rect1.Width ?Else False
	End 
	
	'----------------------------------------------------
	'---------------------------------------------------- Properties : Outter Rect
	'----------------------------------------------------
	
	'-------------------------- Geoms : Size

	#rem monkeydoc Minimum outter rect coordinates.
	#end	
	Property min:Vec2<T>()
		Return _rect0.min 
	Setter(v:Vec2<T>)
		Origin=v
	End 

	#rem monkeydoc Maximum outter rect coordinates.
	#end		
	Property max:Vec2<T>()
		Return _rect0.max 
	Setter(v:Vec2<T>)
		_rect0.max=v
		UpdateRight()
		UpdateBottom()
		Validate()
	End 		
	
	'-------------------------- Geoms/Logic : Identity

	#rem monkeydoc True if Right\<=Left or Bottom\<=Top.
	#end
	Property Empty:Bool()
		Return _rect0.Empty
	End
	
	'-------------------------- Geoms : Positional

	#rem monkeydoc The left of the outter rect.
	#end	
	Property x:T()
		Return _rect0.min.x
	Setter (x:T)
		_rect0.min.x=x
		UpdateLeft()
		ValidateV()		
	End
	
	#rem monkeydoc The top of the outter rect.
	#end	
	Property y:T()
		Return _rect0.min.y
	Setter (y:T)
		_rect0.min.y=y
		UpdateTop()
		ValidateH()		
	End	

	#rem monkeydoc The left of the outter rect.
	#end	
	Property X:T() 'same than x
		Return _rect0.min.x
	Setter (x:T)
		_rect0.min.x=x
		UpdateLeft()
		ValidateV()		
	End
	
	#rem monkeydoc The top of the outter rect.
	#end	
	Property Y:T() 'same than y
		Return _rect0.min.y
	Setter (y:T)
		_rect0.min.y=y
		UpdateTop()
		ValidateH()		
	End	

	#rem monkeydoc The top-left of the outter rect.
	#end	
	Property Origin:Vec2<T>()
		Return _rect0.min
	Setter (origin:Vec2<T>)
		_rect0.min=origin
		UpdateLeft()
		UpdateTop()
		Validate()		
	End 		

	#rem monkeydoc The center of the rect9.
	#end		
	Property Center:Vec2<T>()
		' "Center" is "positional" because it's set-able.
		Return _rect0.Center
	Setter(v:Vec2<T>)
		Local midWidth:=Mid1ds(_rect0.Left,_rect0.Right)
		Local midHeigth:=Mid1ds(_rect0.Top,_rect0.Bottom)
		_rect0.min.x=v.x-midWidth
		_rect0.max.x=v.x+midWidth
		_rect0.min.y=v.y-midHeigth
		_rect0.max.y=v.y+midHeigth
		Update()
		Validate()
	End 	
	
	'-------------------------- Geoms : Dimensional

	#rem monkeydoc The width and height of the outter rect.
	#end	
	Property Size:Vec2<T>()
		Return _rect0.Size
	Setter(size:Vec2<T>)
		_rect0.max=_rect0.min+size
		UpdateRight()
		UpdateBottom()
		Validate()		
	End		

	#rem monkeydoc The width of the outter rect.
	#end	
	Property Width:T()
		Return _rect0.Width
	End

	#rem monkeydoc The height of the outter rect.
	#end	
	Property Height:T()
		Return _rect0.Height
	End
	
	'-------------------------- Geoms : Directional

	#rem monkeydoc The minimum X coordinate.
	#end	
	Property Left:T()
		Return _rect0.min.x
	Setter(left:T)
		_rect0.min.x=left
		UpdateLeft()
		ValidateH()
	End

	#rem monkeydoc The minimum Y coordinate.
	#end	
	Property Top:T()
		Return _rect0.min.y
	Setter(top:T)
		_rect0.min.y=top
		UpdateTop()
		ValidateV()
	End	

	#rem monkeydoc The maximum X coordinate.
	#end	
	Property Right:T()
		Return _rect0.max.x
	Setter(right:T)
		_rect0.max.x=right
		UpdateRight()
		ValidateH()	
	End

	#rem monkeydoc The maximum X coordinate.
	#end	
	Property Bottom:T()
		Return _rect0.max.y
	Setter(bottom:T)		
		_rect0.max.y=bottom
		UpdateBottom()
		ValidateV()	
	End

	'-------------------------- Geoms : Bi-Directional
	
	#rem monkeydoc The top-left of the outter rect.
	#end
	Property TopLeft:Vec2<T>()
		Return _rect0.min
	Setter( v:Vec2<T> )
		_rect0.min=v
		UpdateTop()
		UpdateLeft()
		Validate()	
	End
	
	#rem monkeydoc The top-right of the outter rect.
	#end
	Property TopRight:Vec2<T>()
		Return New Vec2<T>( _rect0.max.x,_rect0.min.y )
	Setter( v:Vec2<T> )
		_rect0.max.x=v.x
		_rect0.min.y=v.y
		UpdateTop()
		UpdateRight()
		Validate()	
	End
	
	#rem monkeydoc The bottom-right of the outter rect.
	#end
	Property BottomRight:Vec2<T>()
		Return _rect0.max
	Setter( v:Vec2<T> )
		_rect0.max=v
		UpdateBottom()
		UpdateRight()
		Validate()	
	End
	
	#rem monkeydoc The bottom-left of the outter rect.
	#end
	Property BottomLeft:Vec2<T>()
		Return New Vec2<T>( _rect0.min.x,_rect0.max.y )
	Setter( v:Vec2<T> )
		_rect0.min.x=v.x
		_rect0.max.y=v.y
		UpdateBottom()
		UpdateLeft()
		Validate()	
	End		
	
	'-------------------------- Geoms : Medians
	
	#rem monkeydoc The vertical center of the outter rect.
	#end
	Property MiddleV:T()
		Return Mid1ds(_rect0.Top,_rect0.Bottom)
	End

	#rem monkeydoc The horizontal center of the outter rect.
	#end
	Property MiddleH:T()
		Return Mid1ds(_rect0.Left,_rect0.Right)
	End

	#rem monkeydoc The center of the outter rect's left's side.
	#end	
	Property MiddleLeft:Vec2<T>()
		Local r:Vec2<T>
		r.x=_rect0.Left
		r.y=Mid1ds(_rect0.Top,_rect0.Bottom)
		Return r
	End

	#rem monkeydoc The center of the outter rect's right's side.
	#end	
	Property MiddleRight:Vec2<T>()
		Local r:Vec2<T>
		r.x=_rect0.Right
		r.y=Mid1ds(_rect0.Top,_rect0.Bottom)
		Return r
	End	

	#rem monkeydoc The center of the outter rect's top's side.
	#end		
	Property MiddleTop:Vec2<T>()
		Local r:Vec2<T>
		r.x=Mid1ds(_rect0.Left,_rect0.Right)
		r.y=_rect0.Top
		Return r
	End		

	#rem monkeydoc The center of the outter rect's bottom's side.
	#end		
	Property MiddleBottom:Vec2<T>()
		Local r:Vec2<T>
		r.x=Mid1ds(_rect0.Left,_rect0.Right)
		r.y=_rect0.Bottom
		Return r
	End	
	
	'----------------------------------------------------
	'---------------------------------------------------- Methods : Outter Rect
	'----------------------------------------------------

	'-------------------------- Geoms/Logic : Contains for outter rect

	#rem monkeydoc Checks if the outter rect contains a vector or another rect/rect9.
	#end
	Method Contains:Bool(x:T,y:T)
		Return _rect0.Contains(New Vec2<T>(x,y))
	End	
	
	#rem monkeydoc Checks if the outter rect contains a vector or another rect/rect9.
	#end
	Method Contains:Bool(pos:Vec2<T>)
		Return _rect0.Contains(pos)
	End	

	#rem monkeydoc Checks if the outter rect contains a rect.
	#end	
	Method Contains:Bool( r:Rect<T> )
		Return min.x<=r.min.x And max.x>=r.max.x And min.y<=r.min.y And max.y>=r.max.y
	End	

	#rem monkeydoc Checks if the outter rect contains a rect9.
	#end	
	Method Contains:Bool( r:Rect9<T> )
		Return min.x<=r.min.x And max.x>=r.max.x And min.y<=r.min.y And max.y>=r.max.y
	End		

	'-------------------------- Geoms : Centered
	
	#rem monkeydoc Gets the rect9 centered within another rect9.
	#end 
	Method Centered:Rect9<T>(rect:Rect9<T>)
		Local x:T=(rect.Width-_rect0.Width)/2+rect._rect0.min.x
		Local y:T=(rect.Height-_rect0.Height)/2+rect._rect0.min.y
		Return New Rect9<T>(x,y,x+_rect0.Width,y+_rect0.Height,PaddingLeft,PaddingTop,PaddingRight,PaddingBottom)
	End	
	
	#rem monkeydoc Gets the rect9 centered with a vec2.
	#end 
	Method Centered:Rect9<T>(v:Vec2<T>)
		Local x:T=_rect0.Width/2+v.x
		Local y:T=_rect0.Height/2+v.y
		Return New Rect9<T>(x,y,x+_rect0.Width,y+_rect0.Height,PaddingLeft,PaddingTop,PaddingRight,PaddingBottom)
	End		
	
	#rem monkeydoc Gets the rect centered within another rect.
	#end 
	Method Centered:Rect<T>(rect:Rect<T>)
		Local x:T=(rect.Width-_rect0.Width)/2+rect.min.x
		Local y:T=(rect.Height-_rect0.Height)/2+rect.min.y
		Return New Rect<T>(x,y,x+_rect0.Width,y+_rect0.Height)
	End		
	
	#rem monkeydoc Gets the rect centered with a vec2.
	#end 
	Method CenteredRect:Rect<T>(v:Vec2<T>)
		Local x:T=_rect0.Width/2+v.x
		Local y:T=_rect0.Height/2+v.y
		Return New Rect<T>(x,y,x+_rect0.Width,y+_rect0.Height)
	End	
	
	'-------------------------- Geoms : Resize
	
	#rem monkeydoc Set a new size for the outter rect
	#end		
	Method Resize(min:Vec2<T>,max:Vec2<T>)
		_rect0.min=min
		_rect0.max=max
		Update()
		Validate()
	End 
	
	#rem monkeydoc Set a new size for the outter rect
	#end		
	Method Resize(r:Rect<T>)
		_rect0=r
		Update()
		Validate()
	End 	

	'-------------------------- Geoms : Batch operation - Moves all four borders as a single

	'Method takes all four border deltas (left, top, right, bottom) as parameters 
	'and applies them in one call, then validates once.

	#rem monkeydoc Moves each border of the outter rect outward by the given amounts.
	@added 2025-05-29
	@param left T left edge
	@param top T top edge
	@param right T right edge
	@param bottom T bottom edge
	@param outside T each edges in the same time
	#end
	Method MoveOutterBorders(left:T, top:T, right:T, bottom:T)
		'Sugar
		_rect0.min.x -= left
		_rect0.min.y -= top
		_rect0.max.x += right
		_rect0.max.y += bottom
		Update()
		Validate()
	End

	Method MoveOutterBorders(outside:T)
		'Sugar
		_rect0.min.x -= outside
		_rect0.min.y -= outside
		_rect0.max.x += outside
		_rect0.max.y += outside
		Update()
		Validate()
	End
	
	'-------------------------- Geoms : Resize the Outter, Inner-Locked
	
	#rem monkeydoc Set a new size for the outter rect without scaling the margins rect
	(Resize the outter, Inner-Locked)
	#end	
	Method ResizeOutter:Rect9<T>(x0:T,y0:T,max:Vec2<T>)
		Return ResizeOutter(New Vec2<T>(x0,y0),max)
	End 
	
	Method ResizeOutter:Rect9<T>(min:Vec2<T>,x1:T,y1:T)
		Return ResizeOutter(min,New Vec2<T>(x1,y1))
	End 
	
	Method ResizeOutter:Rect9<T>(x0:T,y0:T,x1:T,y1:T)
		Return ResizeOutter(New Vec2<T>(x0,y0),New Vec2<T>(x1,y1))
	End 
	
	Method ResizeOutter:Rect9<T>(rect:Rect<T>)
		Return ResizeOutter(rect.min,rect.max)	
	End 
	
	Method ResizeOutter:Rect9<T>(min:Vec2<T>,max:Vec2<T>)	 
		Local padLeft:=PadLeft 
		Local padTop:=PadTop
		Local padRight:=PadRight
		Local padBottom:=PadBottom
		Local r:=New Rect9<T>(min,max)	
		r.Pad(padLeft,padTop,padRight,padBottom)
		Return r
	End 
	
	'-------------------------- Geoms : Resize Outter's sides, Inner-Locked
	
	#rem monkeydoc Set a new coordinate for the outter rect's left side 
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end	
	Method ResizeLeft:Rect9<T>(v:T)
		Return ResizeOutter(v,Top,Right,Bottom)
	End

	#rem monkeydoc Set a new coordinate for the outter rect's top side 
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end	
	Method ResizeTop:Rect9<T>(v:T)
		Return ResizeOutter(Left,v,Right,Bottom)
	End

	#rem monkeydoc Set a new coordinate for the outter rect's right side 
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeRight:Rect9<T>(v:T)
		Return ResizeOutter(Left,Top,v,Bottom)
	End

	#rem monkeydoc Set a new coordinate for the outter rect's bottom side 
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeBottom:Rect9<T>(v:T)
		Return ResizeOutter(Left,Top,Right,v)
	End

	#rem monkeydoc Set a new coordinate for the outter rect's top-left corner
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeTopLeft:Rect9<T>(v:Vec2<T>)
		Return ResizeOutter(v.x,v.y,Right,Bottom)
	End

	#rem monkeydoc Set a new coordinate for the outter rect's top-right corner
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeTopRight:Rect9<T>(v:Vec2<T>)
		Return ResizeOutter(Left,v.y,v.x,Bottom)
	End	

	#rem monkeydoc Set a new coordinate for the outter rect's bottom-left corner
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeBottomLeft:Rect9<T>(v:Vec2<T>)
		Return ResizeOutter(v.x,Top,Right,v.y)
	End
	
	#rem monkeydoc Set a new coordinate for the outter rect's bottom-right corner
	without scaling the margins rect.
	(Resize Outter's sides, MarginsRect-Locked)
	#end		
	Method ResizeBottomRight:Rect9<T>(v:Vec2<T>)
		Return ResizeOutter(Left,Top,v.x,v.y)
	End		
	
	'----------------------------------------------------
	'---------------------------------------------------- Properties : Inner Rect
	'----------------------------------------------------
	
	'-------------------------- Geoms/Logic : Identity
	
	#rem monkeydoc True if InnerRight\<=InnerLeft or InnerBottom\<=InnerTop.
	#end
	Property InnerEmpty:Bool()
		Return _rect1.Empty
	End
	'-------------------------- Geoms/Logic : Contains
	
	#rem monkeydoc Checks if the inner rect contains a vector or another rect/rect9.
	#end	
	Method InnerContains:Bool(pos:Vec2<T>)
		Return _rect1.Contains(pos)
	End	
	
	Method InnerContains:Bool( r:Rect9<T> )
		Return _rect1.min.x<=r.min.x And _rect1.max.x>=r.max.x And _rect1.min.y<=r.min.y And _rect1.max.y>=r.max.y
	End	
	
	Method InnerContains:Bool( r:Rect<T> )
		Return _rect1.min.x<=r.min.x And _rect1.max.x>=r.max.x And _rect1.min.y<=r.min.y And _rect1.max.y>=r.max.y
	End		
	
	'-------------------------- Geoms : Positional

	#rem monkeydoc The top-left of the inner rect.
	#end
	Property InnerOrigin:Vec2<T>()
		Return _rect1.min
	End

	#rem monkeydoc Vertices
	Get an array of vertices. The vertices are organized like this:
	
	|	0	1	2	3	|
	|	4	5	6	7	|
	|	8	9	10	11	|
	|	12	13	14	15	|
	
	In this array, the inner rect is represented from the vertices: 5, 6, 10, 9
	and the outter rect, from the vertices: 0, 3, 15, 12
	
	@return Array of vertices
	#end
	Property Vertices:Vec2<T>[]()
		'iDkP addition 2025-05-17
		Local result:=New Vec2<T>[16](
		New Vec2<T>(_rect0.Left,_rect0.Top),	New Vec2<T>(_rect1.Left,_rect0.Top), 	New Vec2<T>(_rect1.Right,_rect0.Top),		New Vec2<T>(_rect0.Right,_rect0.Top),
		New Vec2<T>(_rect0.Left,_rect1.Top),	New Vec2<T>(_rect1.Left,_rect1.Top), 	New Vec2<T>(_rect1.Right,_rect1.Top),		New Vec2<T>(_rect0.Right,_rect1.Top),
		New Vec2<T>(_rect0.Left,_rect1.Bottom),	New Vec2<T>(_rect1.Left,_rect1.Bottom),	New Vec2<T>(_rect1.Right,_rect1.Bottom),	New Vec2<T>(_rect0.Right,_rect1.Bottom),
		New Vec2<T>(_rect0.Left,_rect0.Bottom),	New Vec2<T>(_rect1.Left,_rect0.Bottom),	New Vec2<T>(_rect1.Right,_rect0.Bottom),	New Vec2<T>(_rect0.Right,_rect0.Bottom)	)
		Return result
	End 

	'-------------------------- Geoms : Surfacial

	#rem monkeydoc Get an array of Rects representing the corners organized as:
	
	| 0 x 1 |
	| x x x |
	| 3 x 2 |
	
	@return the array of rects.
	#end 
	Property Corners:Rect<T>[]()
		'iDkP addition 2025-05-17
		Return New Rect<T>[](	CornerTopLeft,		CornerTopRight,		CornerBottomRight,	CornerBottomLeft	)
	End

	#rem monkeydoc Get an array of Rects representing the 'non-corners' organized as:
	
	| x 0 x |
	| 1 x 2 |
	| x 4 x |
	
	@return the array of rects.
	#end
	Property NotCorners:Rect<T>[]()
		'iDkP addition 2025-05-17
		Return New Rect<T>[](	CornerTopMiddle, 	CornerMiddleLeft, 	CornerMiddleRight, 	CornerBottomMiddle	)
	End 

	#rem monkeydoc Get an array of Rects representing each aera organized as:
	
	| 0 1 2 |
	| 3 4 5 |
	| 6 7 8 |
	
	The list enumerate the aera as: 0, 1, 2, 3, 4, 5, 6, 7, 8
	We just read the aera as 3 lines of 3 rectangles.
	
	@return the array of rects.
	#end
	Property Patches:Rect<T>[]()
		'iDkP addition 2025-05-17
		Return New Rect<T>[](	CornerTopLeft,		CornerTopMiddle,	CornerTopRight,		
								CornerMiddleLeft,	CornerMiddle,		CornerMiddleRight,	
								CornerBottomLeft,	CornerBottomMiddle,	CornerBottomRight	)
		
	End

	#rem monkeydoc Get an array of Rects representing each aera organized as:
	
	| 0 1 2 |
	| 7 8 3 |
	| 6 5 4 |
	
	The list enumerate the aera as: 0, 1, 2, 3, 4, 5, 6, 7, 8
	We just turn around the rect9 in the clockway.
	
	@return the array of rects.
	#end
	Property AerasClock:Rect<T>[]()
		'iDkP addition 2025-05-17
		Return New Rect<T>[](	CornerTopLeft,		CornerTopMiddle,	CornerTopRight,		
								CornerMiddleRight,	CornerBottomRight,	CornerBottomMiddle,	
								CornerBottomLeft,	CornerMiddleLeft,	CornerMiddle	)
		
	End
	
	'-------------------------- Geoms : Dimensional

	#rem monkeydoc The width and height of the inner rect.
	#end	
	Property InnerSize:Vec2<T>()
		Return _rect1.Size
	End	
	
	#rem monkeydoc The width of the inner rect.
	#end	
	Property InnerWidth:T()
		Return _rect1.Width
	End

	#rem monkeydoc The height of the inner rect.
	#end		
	Property InnerHeight:T()
		Return _rect1.Height
	End
	
	'-------------------------- Geoms : Directional
	
	#rem monkeydoc The minimum X coordinate.
	#end
	Property InnerLeft:T()
		Return _rect1.min.x
	End
	
	#rem monkeydoc The minimum Y coordinate.
	#end	
	Property InnerTop:T()
		Return _rect1.min.y
	End	 
	
	#rem monkeydoc The maximum X coordinate.
	#end		
	Property InnerRight:T()
		Return _rect1.max.x
	End
	
	#rem monkeydoc The maximum X coordinate.
	#end	
	Property InnerBottom:T()
		Return _rect1.max.y
	End		
	
	'-------------------------- Geoms : Bi-Directional

	#rem monkeydoc The top-left of the rect.
	#end
	Property InnerTopLeft:Vec2<T>()
		Return _rect1.min
	End
	
	#rem monkeydoc The top-right of the rect.
	#end
	Property InnerTopRight:Vec2<T>()
		Return New Vec2<T>(_rect1.max.x,_rect1.min.y)
	End
	
	#rem monkeydoc The bottom-right of the rect.
	#end
	Property InnerBottomRight:Vec2<T>()
		Return _rect1.max
	End
	
	#rem monkeydoc The bottom-left of the rect.
	#end
	Property InnerBottomLeft:Vec2<T>()
		Return New Vec2<T>(_rect1.min.x,_rect1.max.y)
	End	
		
	'-------------------------- Geoms : Center

	#rem monkeydoc The inner rect's center.
	#end
	Property InnerCenter:Vec2<T>()
		Return _rect1.Center
	End 
	
	'-------------------------- Geoms : Medians

	#rem monkeydoc The inner rect's vertical median coordinate.
	#end
	Property InnerMiddleV:T()
		Return Mid1ds(_rect1.Top,_rect1.Bottom)
	End

	#rem monkeydoc The inner rect's horizontal median coordinate.
	#end	
	Property InnerMiddleH:T()
		Return Mid1ds(_rect1.Left,_rect1.Right)
	End

	#rem monkeydoc The median of the inner rect's left.
	#end	
	Property InnerMiddleLeft:Vec2<T>()
		Local r:Vec2<T>
		r.x=_rect1.Left
		r.y=Mid1ds(_rect1.Top,_rect1.Bottom)
		Return r
	End

	#rem monkeydoc The median of the inner rect's right.
	#end	
	Property InnerMiddleRight:Vec2<T>()
		Local r:Vec2<T>
		r.x=_rect1.Right
		r.y=Mid1ds(_rect1.Top,_rect1.Bottom)
		Return r
	End	

	#rem monkeydoc The median of the inner rect's top.
	#end	
	Property InnerMiddleTop:Vec2<T>()
		Local r:Vec2<T>
		r.x=Mid1ds(_rect1.Left,_rect1.Right)
		r.y=_rect1.Top
		Return r
	End		

	#rem monkeydoc The median of the inner rect's bottom.
	#end		
	Property InnerMiddleBottom:Vec2<T>()
		Local r:Vec2<T>
		r.x=Mid1ds(_rect1.Left,_rect1.Right)
		r.y=_rect1.Bottom
		Return r
	End

	'-------------------------- Geoms : Batch operation - Moves all four borders as a single

	'Method takes all four border deltas (left, top, right, bottom) as parameters 
	'and applies them in one call, then validates once.

	#rem monkeydoc Moves each border of the inner rect inward by the given amounts (increasing padding).
	@added 2025-05-29
	@param left T left edge
	@param top T top edge
	@param right T right edge
	@param bottom T bottom edge
	@param inside T each edges in the same time
	#end
	Method MoveInnerBorders(left:T, top:T, right:T, bottom:T)
		'Sugar
		_paddingLeft  += left
		_paddingTop   += top
		_paddingRight += right
		_paddingBottom+= bottom
		Update()
		Validate()
	End

	Method MoveInnerBorders(inside:T)
		'Sugar
		_paddingLeft  += inside
		_paddingTop   += inside
		_paddingRight += inside
		_paddingBottom+= inside
		Update()
		Validate()
	End
	
	'----------------------------------------------------
	'---------------------------------------------------- Properties : Corners
	'----------------------------------------------------

	'-------------------------- Directional

	#rem monkeydoc The corner region's left (topleft union bottomleft).
	#end
	Property CornerLeft:Rect<T>()
		Return CornerTopLeft|CornerBottomLeft
	End

	#rem monkeydoc The corner region's top (topleft union topright).
	#end
	Property CornerTop:Rect<T>()
		Return CornerTopLeft|CornerTopRight
	End

	#rem monkeydoc The corner region's right (topright union bottomright).
	#end
	Property CornerRight:Rect<T>()
		Return CornerTopRight|CornerBottomRight
	End
	
	#rem monkeydoc The corner region's bottom (bottomleft union bottomright).
	#end	
	Property CornerBottom:Rect<T>()
		Return CornerBottomLeft|CornerBottomRight
	End 	

	'-------------------------- Bi-Directional
	
	#rem monkeydoc The corner region's top-left.
	#end
	Property CornerTopLeft:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect0.Top
		r.Bottom=_rect1.Top
		r.Left=_rect0.Left
		r.Right=_rect1.Left
		Return r
	End
	
	#rem monkeydoc The corner region's top-middle.
	#end
	Property CornerTopMiddle:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect0.Top
		r.Bottom=_rect1.Top
		Return r
	End
	
	#rem monkeydoc The corner region's top-right.
	#end
	Property CornerTopRight:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect0.Top
		r.Bottom=_rect1.Top
		r.Left=_rect1.Right
		r.Right=_rect0.Right
		Return r
	End	
		
	#rem monkeydoc The corner region's middle-left.
	#end
	Property CornerMiddleLeft:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1 
		r.Left=_rect0.Left
		r.Right=_rect1.Left
		Return r
	End
	
	#rem monkeydoc The corner region's middle, 
	actually the margins rect's region too.
	#end	
	Property CornerMiddle:Rect<T>()
		Return _rect1
	End
	
	#rem monkeydoc The corner region's middle-right.
	#end		
	Property CornerMiddleRight:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Right=_rect0.Right
		r.Left=_rect1.Right
		Return r		
	End
	
	#rem monkeydoc The corner region's bottom-left.
	#end		
	Property CornerBottomLeft:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect1.Bottom
		r.Bottom=_rect0.Bottom
		r.Left=_rect0.Left
		r.Right=_rect1.Left
		Return r
	End
	
	#rem monkeydoc The corner region's bottom-middle.
	#end			
	Property CornerBottomMiddle:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect1.Bottom
		r.Bottom=_rect0.Bottom
		Return r
	End
	
	#rem monkeydoc The corner region's bottom-right.
	#end		
	Property CornerBottomRight:Rect<T>()
		Local r:=New Rect<T>()
		r=_rect1
		r.Top=_rect1.Bottom
		r.Bottom=_rect0.Bottom
		r.Left=_rect1.Right
		r.Right=_rect0.Right
		Return r
	End		
	
	'-------------------------- Geoms/Logic : Corners' Contains

	'-------------------------- Vec2's components

	#rem monkeydoc Checks if the corner region top-left contains a vector (components).
	#end	
	Method CornerTopLeftContains:Bool(x:T,y:T)
		Return CornerTopLeft.Contains(New Vec2<T>(x,y))
	End	

	#rem monkeydoc Checks if the corner region top-middle contains a vector (components).
	#end		
	Method CornerTopMiddleContains:Bool(x:T,y:T)
		Return CornerTopMiddle.Contains(New Vec2<T>(x,y))
	End

	#rem monkeydoc Checks if the corner region top-right contains a vector (components).
	#end		
	Method CornerTopRightContains:Bool(x:T,y:T)
		Return CornerTopRight.Contains(New Vec2<T>(x,y))		
	End	

	#rem monkeydoc Checks if the corner region middle-left contains a vector (components).
	#end		
	Method CornerMiddleLeftContains:Bool(x:T,y:T)
		Return CornerMiddleLeft.Contains(New Vec2<T>(x,y))
	End	

	#rem monkeydoc Checks if the corner region middle contains a vector (components).
	#end			
	Method CornerMiddleContains:Bool(x:T,y:T)
		Return CornerMiddle.Contains(New Vec2<T>(x,y))
	End	

	#rem monkeydoc Checks if the corner region middle-right contains a vector (components).
	#end			
	Method CornerMiddleRightContains:Bool(x:T,y:T)
		Return CornerMiddleRight.Contains(New Vec2<T>(x,y))
	End	

	#rem monkeydoc Checks if the corner region bottom-left contains a vector (components).
	#end			
	Method CornerBottomLeftContains:Bool(x:T,y:T)
		Return CornerBottomLeft.Contains(New Vec2<T>(x,y))
	End

	#rem monkeydoc Checks if the corner region bottom-middle contains a vector (components).
	#end				
	Method CornerBottomMiddleContains:Bool(x:T,y:T)
		Return CornerBottomMiddle.Contains(New Vec2<T>(x,y))
	End

	#rem monkeydoc Checks if the corner region bottom-right contains a vector (components).
	#end				
	Method CornerBottomRightContains:Bool(x:T,y:T)
		Return CornerBottomRight.Contains(New Vec2<T>(x,y))
	End	

	'-------------------------- Vec2
	
	#rem monkeydoc Checks if the corner region top-left contains a vector.
	#end	
	Method CornerTopLeftContains:Bool(pos:Vec2<T>)
		Return CornerTopLeft.Contains(pos)
	End	

	#rem monkeydoc Checks if the corner region top-middle contains a vector.
	#end		
	Method CornerTopMiddleContains:Bool(pos:Vec2<T>)
		Return CornerTopMiddle.Contains(pos)
	End

	#rem monkeydoc Checks if the corner region top-right contains a vector.
	#end		
	Method CornerTopRightContains:Bool(pos:Vec2<T>)
		Return CornerTopRight.Contains(pos)		
	End	

	#rem monkeydoc Checks if the corner region middle-left contains a vector.
	#end		
	Method CornerMiddleLeftContains:Bool(pos:Vec2<T>)
		Return CornerMiddleLeft.Contains(pos)
	End	

	#rem monkeydoc Checks if the corner region middle contains a vector.
	#end			
	Method CornerMiddleContains:Bool(pos:Vec2<T>)
		Return CornerMiddle.Contains(pos)
	End	

	#rem monkeydoc Checks if the corner region middle-right contains a vector.
	#end			
	Method CornerMiddleRightContains:Bool(pos:Vec2<T>)
		Return CornerMiddleRight.Contains(pos)
	End	

	#rem monkeydoc Checks if the corner region bottom-left contains a vector.
	#end			
	Method CornerBottomLeftContains:Bool(pos:Vec2<T>)
		Return CornerBottomLeft.Contains(pos)
	End

	#rem monkeydoc Checks if the corner region bottom-middle contains a vector.
	#end				
	Method CornerBottomMiddleContains:Bool(pos:Vec2<T>)
		Return CornerBottomMiddle.Contains(pos)
	End

	#rem monkeydoc Checks if the corner region bottom-right contains a vector.
	#end				
	Method CornerBottomRightContains:Bool(pos:Vec2<T>)
		Return CornerBottomRight.Contains(pos)
	End	
			
	'-------------------------- Rect9

	#rem monkeydoc Checks if the corner region top-left contains another rect9.
	#end	
	Method CornerTopLeftContains:Bool(r:Rect9<T>)
		Return CornerTopLeft.Contains(r.Outter)
	End	

	#rem monkeydoc Checks if the corner region top-middle contains another rect9.
	#end		
	Method CornerTopMiddleContains:Bool(r:Rect9<T>)
		Return CornerTopMiddle.Contains(r.Outter)
	End

	#rem monkeydoc Checks if the corner region top-right contains another rect9.
	#end		
	Method CornerTopRightContains:Bool(r:Rect9<T>)
		Return CornerTopRight.Contains(r.Outter)
	End	

	#rem monkeydoc Checks if the corner region middle-left contains another rect9.
	#end		
	Method CornerMiddleLeftContains:Bool(r:Rect9<T>)
		Return CornerMiddleLeft.Contains(r.Outter)
	End	
	
	#rem monkeydoc Checks if the corner region middle contains another rect9.
	#end		
	Method CornerMiddleContains:Bool(r:Rect9<T>)
		Return CornerMiddle.Contains(r.Outter)
	End	

	#rem monkeydoc Checks if the corner region middle-right contains another rect9.
	#end			
	Method CornerMiddleRightContains:Bool(r:Rect9<T>)
		Return CornerMiddleRight.Contains(r.Outter)
	End	

	#rem monkeydoc Checks if the corner region bottom-left contains another rect9.
	#end			
	Method CornerBottomLeftContains:Bool(r:Rect9<T>)
		Return CornerBottomLeft.Contains(r.Outter)
	End

	#rem monkeydoc Checks if the corner region bottom-middle contains another rect9.
	#end			
	Method CornerBottomMiddleContains:Bool(r:Rect9<T>)
		Return CornerBottomMiddle.Contains(r.Outter)
	End

	#rem monkeydoc Checks if the corner region bottom-right contains another rect9.
	#end			
	Method CornerBottomRightContains:Bool(r:Rect9<T>)
		Return CornerBottomRight.Contains(r.Outter)
	End	
		
	'-------------------------- Rect

	#rem monkeydoc Checks if the corner region top-left contains another rect.
	#end	
	Method CornerTopLeftContains:Bool(r:Rect<T>)
		Return CornerTopLeft.Contains(r)
	End	

	#rem monkeydoc Checks if the corner region top-middle contains another rect.
	#end		
	Method CornerTopMiddleContains:Bool(r:Rect<T>)
		Return CornerTopMiddle.Contains(r)
	End

	#rem monkeydoc Checks if the corner region top-right contains another rect.
	#end			
	Method CornerTopRightContains:Bool(r:Rect<T>)
		Return CornerTopRight.Contains(r)
	End	
	
	#rem monkeydoc Checks if the corner region middle-left contains another rect.
	#end			
	Method CornerMiddleLeftContains:Bool(r:Rect<T>)
		Return CornerMiddleLeft.Contains(r)
	End	

	#rem monkeydoc Checks if the corner region middle contains another rect.
	#end				
	Method CornerMiddleContains:Bool(r:Rect<T>)
		Return CornerMiddle.Contains(r)
	End	

	#rem monkeydoc Checks if the corner region middle-right contains another rect.
	#end				
	Method CornerMiddleRightContains:Bool(r:Rect<T>)
		Return CornerMiddleRight.Contains(r)
	End	

	#rem monkeydoc Checks if the corner region bottom-left contains another rect.
	#end				
	Method CornerBottomLeftContains:Bool(r:Rect<T>)
		Return CornerBottomLeft.Contains(r)
	End

	#rem monkeydoc Checks if the corner region bottom-middle contains another rect.
	#end					
	Method CornerBottomMiddleContains:Bool(r:Rect<T>)
		Return CornerBottomMiddle.Contains(r)
	End
	
	#rem monkeydoc Checks if the corner region bottom-right contains another rect.
	#end				
	Method CornerBottomRightContains:Bool(r:Rect<T>)
		Return CornerBottomRight.Contains(r)
	End	
	
	'----------------------------------------------------
	'---------------------------------------------------- Edges : Properties
	'----------------------------------------------------
	
	'-------------------------- Get/Set Padding (positions relative to the Outter's edges)
	
	#rem monkeydoc The left padding (positions relative to the Outter's edges).
	#end
	Property PaddingLeft:T()
		return _paddingLeft
	Setter(padding:T)
		_paddingLeft=padding
		UpdateLeft()
		ValidateH()
	End

	#rem monkeydoc The top padding (positions relative to the Outter's edges).
	#end
	Property PaddingTop:T()
		Return _paddingTop
	Setter(padding:T)
		_paddingTop=padding
		UpdateTop()		
		ValidateV()
	End		
	
	#rem monkeydoc The right padding (positions relative to the Outter's edges).
	#end	
	Property PaddingRight:T()
		Return _paddingRight
	Setter(padding:T)
		_paddingRight=padding
		UpdateRight()
		ValidateH()
	End
	
	#rem monkeydoc The bottom padding (positions relative to the Outter's edges).
	#end	
	Property PaddingBottom:T()
		return _paddingBottom
	Setter(padding:T)
		_paddingBottom=padding
		UpdateBottom()
		ValidateV()
	End

	#rem monkeydoc The top-left of the padding, as a Vec2.
	It's the positions relative to the Outter's edges.
	#end
	Property PaddingTopLeft:Vec2i<T>()
		Return New Vec2<T>(_paddingLeft,_paddingTop)
	Setter(padding:Vec2i<T>)
		_paddingTop=padding.y
		_paddingLeft=padding.x
		UpdateTop()		
		UpdateLeft()
		Validate()
	End	

	#rem monkeydoc The top-right of the padding, as a Vec2.
	It's the positions relative to the Outter's edges.
	#end
	Property PaddingTopRight:Vec2i<T>()
		Return New Vec2<T>(_paddingRight,_paddingTop)
	Setter(padding:Vec2i<T>)
		_paddingTop=padding.y
		_paddingRight=padding.x
		UpdateTop()		
		UpdateRight()
		Validate()
	End		
	
	#rem monkeydoc The bottom-left of the padding, as a Vec2.
	It's the positions relative to the Outter's edges.
	#end	
	Property PaddingBottomLeft:Vec2i<T>()
		Return New Vec2<T>(_paddingLeft,_paddingBottom)
	Setter(padding:Vec2i<T>)
		_paddingBottom=padding.y
		_paddingLeft=padding.x
		UpdateBottom()
		UpdateLeft()
		Validate()
	End	
	
	#rem monkeydoc The bottom-right of the padding, as a Vec2.
	It's the positions relative to the Outter's edges.
	#end			
	Property PaddingBottomRight:Vec2i<T>()
		Return New Vec2<T>(_paddingRight,_paddingBottom)
	Setter(padding:Vec2i<T>)
		_paddingBottom=padding.y
		_paddingRight=padding.x
		UpdateBottom()
		UpdateRight()
		Validate()
	End	
	
	#rem monkeydoc Set the padding.
	It's the positions relative to the Outter's edges.
	#end	
	Method Padding(left:T,top:T,right:T,bottom:T)
		_paddingLeft=left
		_paddingTop=top
		_paddingRight=right
		_paddingBottom=bottom
		Update()
		Validate()	
	End 
	
	Method Padding(allsides:T)
		_paddingLeft=allsides
		_paddingTop=allsides
		_paddingRight=allsides
		_paddingBottom=allsides
		Update()
		Validate()			
	End
	
	'-------------------------- Get/Set Padding's absolute positions

	#rem monkeydoc The left padding (absolute coordinates).
	#end
	Property PadLeft:T()
		Return _rect0.Left+_paddingLeft
	Setter(pos:T)
		If pos<=_rect0.Left 
			pos=_rect0.Left
			_paddingLeft=0
		Else 
			_paddingLeft=pos-_rect0.Left
		End 
		_rect1.Left=_rect0.Left+_paddingLeft
		ValidateH()
	End

	#rem monkeydoc The top padding (absolute coordinates).
	#end	
	Property PadTop:T()
		Return _rect0.Top+_paddingTop
	Setter(pos:T)
		If pos<=_rect0.Top 
			pos=_rect0.Top
			_paddingTop=0
		Else 
			_paddingTop=pos-_rect0.Top
		End 
		_rect1.Top=_rect0.Top+_paddingTop
		ValidateV()
	End		
	
	#rem monkeydoc The right padding (absolute coordinates).
	#end	
	Property PadRight:T()
		Return _rect0.Right-_paddingRight
	Setter(pos:T)
		If pos>=_rect0.Right 
			pos=_rect0.Right
			_paddingRight=0
		Else 
			_paddingRight=_rect0.Right-pos
		End 
		_rect1.Right=_rect0.Right-_paddingRight
		ValidateH()
	End
	
	#rem monkeydoc The bottom padding (absolute coordinates).
	#end	
	Property PadBottom:T()
		Return _rect0.Bottom-_paddingBottom
	Setter(pos:T)
		If pos>=_rect0.Bottom 
			pos=_rect0.Bottom
			_paddingBottom=0
		Else 
			_paddingBottom=_rect0.Bottom-pos
		End 
		_rect1.Bottom=_rect0.Bottom-_paddingBottom
		ValidateV()
	End		

	#rem monkeydoc The top-left of the padding, as a Vec2 (absolute coordinates).
	#end	
	Property PadTopLeft:Vec2<T>()
		Return New Vec2<T>(PadTop,PadLeft)
	Setter (pos:Vec2<T>)
		PadTop=pos.y
		PadLeft=pos.x 
	End 

	#rem monkeydoc The top-right of the padding, as a Vec2 (absolute coordinates).
	#end
	Property PadTopRight:Vec2<T>()
		Return New Vec2<T>(PadTop,PadRight)
	Setter (pos:Vec2<T>)
		PadTop=pos.y
		PadRight=pos.x 
	End 

	#rem monkeydoc The bottom-left of the padding, as a Vec2 (absolute coordinates).
	#end	
	Property PadBottomLeft:Vec2<T>()
		Return New Vec2<T>(PadBottom,PadLeft)
	Setter (pos:Vec2<T>)
		PadBottom=pos.y
		PadLeft=pos.x 
	End 	

	#rem monkeydoc The bottom-right of the padding, as a Vec2 (absolute coordinates).
	#end	
	Property PadBottomRight:Vec2<T>()
		Return New Vec2<T>(PadBottom,PadRight)
	Setter (pos:Vec2<T>)
		PadBottom=pos.y
		PadRight=pos.x 
	End 
	
	#rem monkeydoc Set the padding in absolute coordinates.
	#end	
	Method Pad(left:T,top:T,right:T,bottom:T)
		PadLeft=left
		PadTop=top
		PadRight=right
		PadBottom=bottom
	End 
	
	Method Pad(r:Rect<T>)
		PadLeft=r.Left
		PadTop=r.Top
		PadRight=r.Right
		PadBottom=r.Bottom
	End 
	
	Method Pad(r:Rect9<T>)
		PadLeft=r.Outter.Left
		PadTop=r.Outter.Top
		PadRight=r.Outter.Right
		PadBottom=r.Outter.Bottom
	End 						
	
	'----------------------------------------------------
	'---------------------------------------------------- Edges : System
	'----------------------------------------------------	
	Private
	'----------------------------------------------------	

	'-------------------------- Init

	#rem monkeydoc @hidden
	#end
	Method Init(left:T=0,top:T=0,right:T=0,bottom:T=0)
		_paddingLeft=left
		_paddingTop=top
		_paddingRight=right
		_paddingBottom=bottom	
		Update()
		Validate()
	End	

	'-------------------------- Updates

	#rem monkeydoc @hidden
	#end	
	Method Update()
		_rect1.min.x=_rect0.min.x+_paddingLeft
		_rect1.min.y=_rect0.min.y+_paddingTop
		_rect1.max.x=_rect0.max.x-_paddingRight
		_rect1.max.y=_rect0.max.y-_paddingBottom
	End

	#rem monkeydoc @hidden
	#end	
	Method UpdateLeft()
		_rect1.min.x=_rect0.min.x+_paddingLeft
	End 

	#rem monkeydoc @hidden
	#end	
	Method UpdateTop()
		_rect1.min.y=_rect0.min.y+_paddingTop
	End 	

	#rem monkeydoc @hidden
	#end	
	Method UpdateRight()
		_rect1.max.x=_rect0.max.x-_paddingRight
	End 

	#rem monkeydoc @hidden
	#end	
	Method UpdateBottom()
		_rect1.max.y=_rect0.max.y-_paddingBottom
	End 

	'-------------------------- Validates

	#rem monkeydoc @hidden
	#end	
	Method Validate()
		ValidateH()
 		ValidateV()
	End 

	#rem monkeydoc @hidden
	#end	
	Method ValidateH()
		Local absLeft:=PadLeft
		Local absRight:=PadRight
		If absLeft>absRight
			Local newpos:=Mid1ds(absLeft,absRight)
			_rect1.Left=Clamp(newpos,_rect0.Left,_rect0.Right)
			_rect1.Right=Clamp(newpos,_rect0.Left,_rect0.Right)
		End 		
	End 

	#rem monkeydoc @hidden
	#end	
	Method ValidateV()
		Local absTop:=PadTop
		Local absBottom:=PadBottom
		If absTop>absBottom
			Local newpos:=Mid1ds(absTop,absBottom)
			_rect1.Top=Clamp(newpos,_rect0.Top,_rect0.Bottom)
			_rect1.Bottom=Clamp(newpos,_rect0.Top,_rect0.Bottom)		
		End 
	End 

	'----------------------------------------------------
	'---------------------------------------------------- Fields
	'----------------------------------------------------
	
	'-------------------------- Main variables
	
	#rem monkeydoc @hidden
	#end	
	Field _rect0:Rect<T>
	
	Field _rect1:Rect<T>	
	
	'-------------------------- Parameters
	
	#rem monkeydoc @hidden
	#end	
	Field _paddingLeft:T
	
	Field _paddingTop:T	
	
	Field _paddingRight:T
	
	Field _paddingBottom:T			
			
	'----------------------------------------------------
	'---------------------------------------------------- Tools
	'----------------------------------------------------
	
	#rem monkeydoc @hidden
	#end	
	Function Mid1ds:T(min:T,max:T)
		Return .5*(min+max)
	End

	Function Swap<T>(a:T ptr,b:T ptr)
		'-----------
		'Author : 
		'	Humanity, Adapted by iDkP for RedPix
		'Note :
		'	Mark.... this should be in the monkey or std "module" from years...
		'Year : 2021
		'-----------
		Local t:=a[0]
		a[0]=b[0]
		b[0]=t
	End 
End 

'========================================================================================
'------------------------------------------------------------------------------ TRANSFORM
'========================================================================================

#rem monkeydoc Transforms a Rect\<Int\> by an AffineMat3.
#end
Function TransformRect9i<T>:Rect9i( rect9:Rect9i,matrix:AffineMat3<T> )
	
	Local min:=matrix * New Vec2<T>( rect9.min.x,rect9.min.y )
	Local max:=matrix * New Vec2<T>( rect9.max.x,rect9.max.y )

	Local min:=matrix * New Vec2<T>( rect9.MarginsRect.min.x,rect9.MarginsRect.min.y )
	Local max:=matrix * New Vec2<T>( rect9.MarginsRect.max.x,rect9.MarginsRect.max.y )
	
	rect9.PaddingLeft=matrix * ( rect9.PaddingLeft )
	rect9.PaddingTop=matrix * ( rect9.PaddingTop )
	rect9.PaddingRight=matrix * ( rect9.PaddingRight )
	rect9.PaddingBottom=matrix * ( rect9.PaddingBottom )
		
	Return New Recti( 	Round( min.x ),Round( min.y ),Round( max.x ),Round( max.y ), 
						rect9.PaddingLeft,rect9.PaddingTop,
						rect9.PaddingRight,rect9.PaddingBottom							)
	
End
