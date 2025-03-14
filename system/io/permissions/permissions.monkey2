
Namespace stdlib.system.io.permissions

#If __TARGET__="android"

#Import "native/Monkey2Permissions.java"

Private

#Import "../../../plugins/jni/jni"

Using stdlib.plugins.jni..

Global _class:jclass
Global _ctor:jmethodID
Global _checkPermission:jmethodID
Global _requestPermissions:jmethodID
Global _requestPermissionsFinished:jmethodID
Global _requestPermissionsResult:jmethodID
Global _instance:jobject

Global _requests:=New Deque<Request>
Global _busy:=False

Function Init()

	If _class Return
	
	Local env:=stdlib.plugins.sdl2.Android_JNI_GetEnv()
	
	_class=env.FindClass( "com/monkey2/lib/Monkey2Permissions" )
	
	_ctor=env.GetMethodID( _class,"<init>","()V" )
	
	_checkPermission=env.GetMethodID( _class,"checkPermission","(Ljava/lang/String;)I" )
	_requestPermissions=env.GetMethodID( _class,"requestPermissions","(Ljava/lang/String;I)V" )
	_requestPermissionsResult=env.GetMethodID( _class,"requestPermissionsResult","()Ljava/lang/String;" )
	
	Local instance:=env.NewObject( _class,_ctor,Null )
		
	_instance=env.NewGlobalRef( instance )
End

Class Request

	Field permissions:String
	Field finished:Void( result:ResultType[] )

	Method New( permissions:String[],finished:Void( result:ResultType[] ) )
	
		Self.permissions=";".Join( permissions )
	
		Self.finished=finished
	End
	
	method Start()
		Assert( Not _busy )
		
		_busy=True
		
		Local env:=stdlib.plugins.sdl2.Android_JNI_GetEnv()
		
		Local callback:=async.CreateAsyncCallback( Finished,True )
	
		env.CallVoidMethod( _instance,_requestPermissions,New Variant[]( permissions,callback ) )
	End
	
	Method Finished()
	
		Local env:=stdlib.plugins.sdl2.Android_JNI_GetEnv()	
		
		Local result:=env.CallStringMethod( _instance,_requestPermissionsResult,null )
		
		_busy=False
		
		StartNextRequest()
		
		Local sresult:=result.Split( ";" )
		
		Local iresult:=New ResultType[sresult.Length]
		For Local i:=0 Until iresult.Length
			iresult[i]=Cast<UInt>( sresult[i] )
		Next
		
		finished( iresult )
	End

End

Function StartNextRequest()

	If Not _busy And Not _requests.Empty _requests.RemoveFirst().Start()
End

Public

#Endif

#rem monkeydoc Check an android permission.

This function is only available on android.

Returns 1 if the given permission has been granted to the app, else 0.

The permission string should be in android manifest form, eg: "android.permission.READ\_EXTERNAL\_STORAGE".

#end
Function CheckPermission:Int( permission:String )
 
#If __TARGET__="android"
 
	Init()

	Local env:=stdlib.plugins.sdl2.Android_JNI_GetEnv()	
	
	Return env.CallIntMethod( _instance,_checkPermission,New Variant[]( permission ) )
	
#Else

	Return -1
	
#Endif

End

Alias ResultType:UInt

#rem monkeydoc Request android permissions.

This function is only available on android.

Attempts to grant the given permissions to the app.

Depending on the permissions, this may cause a modal dialog to be presented to the user.

The permission strings should be in android manifest form, eg: "android.permission.READ\_EXTERNAL\_STORAGE".

See this page for more permissions:

https://developer.android.com/reference/android/Manifest.permission

If the result is an empty array, the operation was cancelled.

#end
Function RequestPermissions( permissions:String[],finished:Void( results:ResultType[] ) )

#If __TARGET__="android"

	Init()

	_requests.AddLast( New Request( permissions,finished ) )
	
	StartNextRequest()
	
#Endif

End
