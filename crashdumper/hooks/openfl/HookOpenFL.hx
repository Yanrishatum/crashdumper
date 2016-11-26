package crashdumper.hooks.openfl;
import crashdumper.hooks.IHookPlatform;
import haxe.io.Bytes;

import lime.app.Application;
import lime.system.System;

import openfl.Lib;
import openfl.utils.ByteArray;
import openfl.events.UncaughtErrorEvent;

/**
 * ...
 * @author larsiusprime
 */
class HookOpenFL implements IHookPlatform
{
	public var fileName(default, null):String="";
	public var packageName(default, null):String="";
	public var version(default, null):String="";
	
	public static inline var PATH_APPDATA:String = "%APPDATA%";			//The ApplicationStorageDirectory. Highly recommended.
	public static inline var PATH_DOCUMENTS:String = "%DOCUMENTS%";		//The Documents directory.
	public static inline var PATH_USERPROFILE:String = "%USERPROFILE%";	//The User's profile folder
	public static inline var PATH_DESKTOP:String = "%DESKTOP%";			//The User's desktop
	public static inline var PATH_APP:String = "%APP%";					//The Application's own directory
	
	public function new() 
	{
    fileName = Application.current.config.file;
    packageName = Application.current.config.packageName;
    version = Application.current.config.version;
	}
	
	public function getFolderPath(str:String):String
	{
		#if (windows || mac || linux || mobile)
			#if (mobile)
				if (!Util.isFirstChar(str, "/") && !Util.isFirstChar("\\"))
				{
					str = Util.uCombine("/" + str);
				}
				str = Util.uCombine([System.applicationStorageDirectory,str]);
			#else
					switch(str)
					{
						case null, "": str = System.applicationStorageDirectory;
						case PATH_APPDATA: str = System.applicationStorageDirectory;
						case PATH_DOCUMENTS: str = System.documentsDirectory;
						case PATH_DESKTOP: str = System.desktopDirectory;
						case PATH_USERPROFILE: str = System.userDirectory;
						case PATH_APP: str = System.applicationDirectory;
					}
			#end
			if (str != "")
			{
				str = Util.fixTrailingSlash(str);
			}
		#end
		return str;
	}
	public function setErrorEvent(onErrorEvent:Dynamic->Void)
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onErrorEvent);
	}
	
	public function getZipBytes(str):Bytes
	{
    var bytes:ByteArray = new ByteArray();
    bytes.writeUTFBytes(str);
    return bytes;
	}
  
}