
Namespace stdlib.config

'EDIT 2025-07-16: OBSOLET, WILL BE UNDONE

' --------------------------------- Reconfigurable data type ranges
'
' It's about the range of the data types. That's affects how the library handles the memory. 
' We can change carefuly the data types affected to the aliases but you'll need 
' to recompile the whole library before a beta.
'
' Anyway, the library don't need to be reconfigured unless a true reason, it can handles
' images until 32K² pixels and can adresses some petabytes of data on a lba.

'#Import "/types/builtin"

'#Import "/types/aliases/bdc"

Using stdlib.types

Alias PInt:UByte32 'maximum range for pointer indexes
