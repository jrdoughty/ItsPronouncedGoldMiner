import kha.Assets;
import kha2d.Sprite;
import kha2d.Scene;
class Data {
	public static var the(get, null):Data;
	public var levels:Array<LevelData> = [];

	private static function get_the():Data
	{
		if(the == null)
		{
			the = new Data();
		}
		return the;
	}

	private function new()
	{
		var data = haxe.Json.parse(Assets.blobs.data_json.toString());
		for(i in 0...data.levels.length)
		{
			var lvlArr:Array<Dynamic> = cast data.levels;
			var lvlData = lvlArr[i];
			levels.push(lvlData);
		}
	}
}
typedef LevelData = {
	var chats:Map<String, Array<Dialog>>;
	var background:String;
	var id:Int;
	var sprites:Array<SpriteData>;
	var days:Int;
}

typedef Dialog = {
	var type:String;
	var char:String;
	var texts:Array<Chat>;
}

typedef Chat = {
	var text:String;
	var chat:String;
	var cost:Int;
	var frame:Int;
}

typedef SpriteData = {
	var idString:String;
	var x:Float;
	var y:Float;
	var frame:Int;
}