
Namespace stdlib.syntax

#rem MiniLibrary: Arrays slicing window
Since 2025-07-20 (Aida 4)
Author: iDkP from GaragePixel
#end

'Extract (copy) and virtual 2d array window
Function SlidingExtract<T,ChunkFormat>(	src:T[], 'The source
											srcLength:ChunkFormat Ptr,
											srcHeight:ChunkFormat Ptr,
											
										'position of the window to extract:
											srcOffsetX:UInt,
											srcOffsetY:UInt,
											srcOffsetLength:ChunkFormat,
											srcOffsetHeight:ChunkFormat,
											
										'destination array reference
											dst:T[]	)

	#rem  
	
		- Example: 
			scr:
				****** length: 6
				***12* height: 3
				***34* window:
							offsetx: 4
							offsety: 2
							offsetLength: 2
							offsetHeight: 2
			result:
				1234
	#end
End 

'Insert (paste) a virtual 2d array window
Function SlidingInsert<T,ChunkFormat>(	src:T[], 'The source
											srcLength:ChunkFormat Ptr,
											srcHeight:ChunkFormat Ptr,
											
										'destination array reference
										dst:T[],

										'position of the window to extract:
											dstOffsetX:UInt,
											dstOffsetY:UInt,
											dstOffsetLength:ChunkFormat,
											dstOffsetHeight:ChunkFormat	)

	#rem  
	
		- Example: 
			scr:
				1234 -> 12 srcLength: 2
						34 srcHeight: 2
			
			result (dest):
				****** dstLength: 6
				***12* dstHeight: 3
				***34* window:
							dstOffsetx: 4
							dstOffsety: 2
							dstOffsetLength: 2
							dstOffsetHeight: 2
	#end
End 

'Copy a virtual 2d array to another virtual 2d array
Function SlidingCopyTo<T,ChunkFormat>( 	src:T[], 'The source
											srcLength:ChunkFormat Ptr,
											srcHeight:ChunkFormat Ptr,

										'position of the scr window:
											srcOffsetX:UInt,
											srcOffsetY:UInt,
											srcOffsetLength:ChunkFormat,
											srcOffsetHeight:ChunkFormat,

										dest:T[], 'the destination array
											dstLength:ChunkFormat Ptr,
											dstHeight:ChunkFormat Ptr,

										'position of the dest window:
											dstOffsetX:UInt,
											dstOffsetY:UInt	)
	#rem  
	
		- Example: 
			scr:
				****** length: 6
				***00* height: 3
				***00* window:
							offsetx: 4
							offsety: 2
							offsetLength: 2
							offsetHeight: 2
			dest
			
				****** length: 6
				**X*** height: 4
				****** window:
				******	offsetx: 3
						offsety: 2
						
			result:
				******
				**00**
				**00**
				******		
	#end
End 

'Read a window from a virtual 2d array to another virtual 2d array
Function SlidingRead<T,ChunkFormat>( 	this:T[],
	
										'data to write into:
											data:T Ptr,
	
										'dimension x,y of the unidimensional array:
											length:ChunkFormat Ptr,
											height:ChunkFormat Ptr,
													
										'position of the window:
											offsetX:UInt,
											offsetY:UInt,
											offsetLength:ChunkFormat,
											offsetHeight:ChunkFormat,
													
										'Pointer in the window:
											ptrX:UInt,
											ptrY:UInt	)
	
	'Return the content
	data[0]=this[	SlidingGetPtr(	this,
	
									Varptr(length),
									Varptr(height),
											
									Varptr(offsetX),
									Varptr(offsetY),
									Varptr(offsetLength),
									Varptr(offsetHeight),
										
									Varptr(ptrX),
									Varptr(ptrY))	]
End

'Write a window from a virtual 2d array to another virtual 2d array
Function SlidingWrite<T,ChunkFormat>( 	this:T[],
	
										'data to write/set:
											data:T Ptr,
	
										'dimension x,y of the unidimensional array:
											length:ChunkFormat Ptr,
											height:ChunkFormat Ptr,
													
										'position of the window:
											offsetX:UInt,
											offsetY:UInt,
											offsetLength:ChunkFormat,
											offsetHeight:ChunkFormat,
													
										'Pointer in the window:
											ptrX:UInt,
											ptrY:UInt	)
	
	'Return the content
	data[0]=this[	SlidingGetPtr(	this,
	
									Varptr(length),
									Varptr(height),
											
									Varptr(offsetX),
									Varptr(offsetY),
									Varptr(offsetLength),
									Varptr(offsetHeight),
										
									Varptr(ptrX),
									Varptr(ptrY))	]
End

'Get a pointer for read/write in a virtual 2d array from a sliding window
Function SlidingGetPtr<T,ChunkFormat>:ChunkFormat Ptr( 	this:T[],
	
														'dimension x,y of the unidimensional array:
															length:ChunkFormat Ptr,
															height:ChunkFormat Ptr,
																					
														'position of the window:
															offsetX:UInt Ptr,
															offsetY:UInt Ptr,
															offsetLength:ChunkFormat Ptr,
															offsetHeight:ChunkFormat Ptr,
																					
														'Pointer in the window:
															ptrX:UInt Ptr,
															ptrY:UInt Ptr	)

	'The pointer is inside the window
	ptrX[0]=ptrX[0]>offsetLength[0] ? offsetLength[0] Else ptrX[0] 'guard
	ptrY[0]=ptrY[0]>offsetHeight[0] ? offsetHeight[0] Else ptrY[0] 'guard
	
	'The window is inside the 2d array
	offsetX[0]=offsetX[0]<=length[0]-offsetLength[0] ? offsetX[0] Else length[0]-offsetLength[0] 'guard, here <= avoids sub (edge case)
	offsetY[0]=offsetY[0]<=height[0]-offsetHeight[0] ? offsetY[0] Else height[0]-offsetHeight[0] 'guard, here <= avoids sub (edge case)
	
	'Shift the pointer inside the 2d array
	ptrX[0]+=offsetX[0]
	ptrY[0]+=offsetY[0]
	
	'Pointer from 2d array to 1d array
	ptrY[0]*=length[0]-1
	ptrX[0]+=ptrY[0]
	
	'Return the content
	Return ptrX
End
