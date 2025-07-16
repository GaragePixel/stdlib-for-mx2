
Namespace stdlib.aliases.prefixes

#rem monkeydoc Prefixes minilibrary
@author iDkP from GaragePixel
@since 2025-07-07
@source https://discord.com/channels/796336780302876683/796338396003172352/1391643077650812938

The prefixes are Aliases of types used with the multiple-return parameters' workaround.
This technique was called by iDkP: 'TCO' (Template-Contrained Overload).

12 prefixes for 'template specialization' (Static return-type dispatch by constraint)
are usable for each functions that uses the technique.
This library implements the most generic terms used for this kind of functions.

We can create specific alias but for coherence, we will follow some rules:
- prefixes are surrounded by an underscore and begins always by a p.
- We can use the 16 primitive datatypes for a set of prefixes used by a set of functions.
- Using the lest frequenctly used type as first, then the most frequently used for the last avoids
the collisions. The number of 'primitive prefixes' is 16.
TypeInfo->DeclInfo->CString->String->UShort->UInt->ULong->
Long->Short->Double->Byte->UByte-Int->Float->Object->Variant

|---------|------|--------|----------------|
| Type    | Bits | Signed | Floating Point |
|---------|------|--------|----------------|
| UShort  | 16   | No     | No             |
| UInt    | 32   | No     | No             |
|---------|------|--------|----------------|
| ULong   | 64   | No     | No             |
| Long    | 64   | Yes    | No             |
|---------|------|--------|----------------|
| Short   | 16   | Yes    | No             |
| Double  | 64   | Yes    | Yes            |
|---------|------|--------|----------------|
| Byte    | 8    | Yes    | No             |
| UByte   | 8    | No     | No             |
|---------|------|--------|----------------|
| Int     | 32   | Yes    | No             |
| Float   | 32   | Yes    | Yes            |
|---------|------|--------|----------------|
| Object  | --   | --     | --             |
| Variant | --   | --     | --             |
|---------|------|--------|----------------|
#end

' Prefix's natural sequence
Alias _p0_:UShort,		_p1_:UInt
Alias _p2_:ULong,		_p3_:Long
Alias _p4_:Short,		_p5_:Double
Alias _p6_:Byte,		_p7_:UByte
Alias _p8_:Int,			_p9_:Float
Alias _p10_:Object,		_p11_:Variant

' Scaling, opacity, ratios
Alias _pFastPct_:_p0_ 'for integer output only
Alias _pPct_:_p1_ 'can handles float as output
Alias _pFract_:_p2_

' Angle units, trigonometry, rotation
Alias _pRad_:_p0_
Alias _pDeg_:_p1_

' Logic programming
Alias _pTrue_:_p0_			
Alias _pFalse_:_p1_

' Philosophy, formal logic
Alias _pTruth_:_p0_
Alias _pUntruth_:_p1_

' Electronics, switches
Alias _pOn_:_p0_
Alias _pOff_:_p1_

' Doors, sockets, circuits
Alias _pOpen_:_p0_
Alias _pClosed_:_p1_

' UI, features, controls
Alias _pEnabled_:_p0_
Alias _pDisabled_:_p1_

' Status, processes
Alias _pActive_:_p0_
Alias _pInactive_:_p1_

' Flags, configuration
Alias _pSet_:_p0_
Alias _pUnset_:_p1_

' Logic, assertions
Alias _pAffimed_:_p0_
Alias _pNegated_:_p1_

' User input, options
Alias _pYes_:_p0_
Alias _pNo_:_p1_
