
#ifndef BB_RESOURCE_H
#define BB_RESOURCE_H

//#include "../../../../lang/native/bbmonkey.h"
#include "bbmonkey.h"

class bbResource : public bbObject{

	bool _discarded=false;

public:

	bbResource();

	virtual void gcFinalize();
	
	void discard();
	
protected:
	
	virtual void onDiscard();
	
	virtual void onFinalize();
};

#endif