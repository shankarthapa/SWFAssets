package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Dynamic):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		
		#end
		
		var data, manifest, library;
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		data = '{"name":"femaleplayer","assets":"aoy4:pathy37:lib%2Ffemaleplayer%2Ffemaleplayer.biny4:sizei1482125y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":null,"version":2,"libraryArgs":["lib/femaleplayer/femaleplayer.bin"],"libraryType":"openfl._internal.formats.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("femaleplayer", library);
		data = '{"name":null,"assets":"aoy4:pathy25:assets%2Ffemaleplayer.swfy4:sizei106847y4:typey6:BINARYy2:idR1y7:preloadtgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("femaleplayer");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("femaleplayer");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_femaleplayer_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_femaleplayer_femaleplayer_bin extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_femaleplayer_json extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("Assets/femaleplayer.swf") #if display private #end class __ASSET__assets_femaleplayer_swf extends haxe.io.Bytes {}
@:keep @:file("/Users/shankarthapa/Documents/dreamhost/hex+flex/haxelib-proj/SWFAssets/Export/html5/obj/libraries/femaleplayer/femaleplayer.bin") #if display private #end class __ASSET__lib_femaleplayer_femaleplayer_bin extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__lib_femaleplayer_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end