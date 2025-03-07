***** How contribute to stdlib? *****
	
Collaboration on the stdlib is open to all as this library is intended to become 
the standard library for the language. Enter the tatami, humbly greeting 
the portrait of the Great Master Sibly-Sensei.

***** Contribution criteria *****

Please wrap a library that has no dependency, or that has a dependency 
on a library already embedded in the stdlib. 
	
You can write original mx2 code, interfaced on implementation in c/c++. 
But unlike the core language library that must correspond to external code, 
in stdlib, the code can be *eventually* written only in pure mx2. 
Just keep in mind that your sub-library must fulfill a fundamental role, 
because the stdlib must remain lightweight and approach perfection 
(remove more than add). Also respect the hierarchy of directories 
as well as the structure of namespaces. You can consult the actual
roadmap: https://github.com/users/GaragePixel/projects/2/views/3
		
· 	Keep in mind too that hierarchy satisfies the criterion of 'organization' 
	--> https://en.wikipedia.org/wiki/Organizing_principle
		
· 	while namespace structure satisfies the 'ergonomic' criterion, 
	--> https://en.wikipedia.org/wiki/Ergonomics 
	(in the sense that it should be easy to remember the path 
	that leads to the features). 
		
· 	The criterion of 'affordance' also means that the implementation 
	should suggest itself how it could/should be used. 
	--> https://en.wikipedia.org/wiki/Affordance
	
So try to maintain the style of property names,
the way to implement constructors 
and please don't forget to document your code.
	
Concerning the test folder, please submit code that respects
the current file hierarchy and create a test that does not depend
on any library other than stdlib, or a true reason to include
sdklib but no other library (even sdk_mojo).
If sdk is involved, there is a good reason to
think the test is about sdk. So carefully evaluate
whether your test is about stdlib and, if possible, find a way
not to involve sdk.

You can download this folder-test at: https://github.com/GaragePixel/Monkey2_stdlib_tests
it's a large and organized folder that contains also
the tests of sdk and sdk_mojo.
	
Another way to contribute would be, for example, 
to write c/c++ code that would use speedups present in libc, 
or if you can code externally this kind of optimization 
but keep the code as portable as possible 
since mx2 compiles for several platforms. 
You can write code accelerators and interfaces for 
already existing libraries that are only implemented in pure mx2. 
mx2cc produces code who is in itself as fast as c++, 
but does not know how to use some platform-specific accelerators 
that we can make for ourselves in our community. 
This kind of a-la libc library would therefore be welcome.

***** What is really important to add to stdlib? *****

As the sub-libraries was integrated in stdlib, it should be
interesting to create a 'type shared library' when it's possible
to use the same type build on the same data type across the
sub-libraries in order to minimise the overall memory footprint.
These libraries are chosen according to their license on a criterion 
allowing them to be freely adapted and therefore to achieve such an objective.
	
The most anticipated libraries are a free solution for capturing images 
from a webcam and an efficient solution for retrieving input 
from a wacom-style graphics tablet. 
A library that would eventually allow creating a stencil for windows 
or an opacity buffer to manage their transparency would be 
of great use to the community that compiles to Windows. Actually I
added the new constantes in win32 in an attempt to prepare more
features in this scope.
