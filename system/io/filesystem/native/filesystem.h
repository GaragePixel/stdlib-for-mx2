
#ifndef BB_FILESYSTEM_H
#define BB_FILESYSTEM_H

//#include "../../../../lang/native/bbmonkey.h"
#include "bbmonkey.h"
//#include "../../../../lang/native/bbplatform.h"
#include <bbplatform.h>

namespace bbFileSystem{

	bbString appDir();
	
	bbString appPath();
	
	bbArray<bbString> appArgs();
	
	bbBool copyFile( bbString srcPath,bbString dstPath );
	
#if BB_IOS
	bbString getSpecialDir( bbString name );
#endif

#if BB_ANDROID
	FILE *fopenAsset( void *asset );
#endif

}

#endif
