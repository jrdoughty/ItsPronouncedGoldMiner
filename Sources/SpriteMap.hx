import kha.Assets;
import kha2d.Sprite;

class SpriteMap
{
	public static var the(get, null):SpriteMap;
	var spriteMap = new Map<String, Sprite>();
	
	private static function get_the():SpriteMap
	{
		if(the == null)
		{
			the = new SpriteMap();
		}
		return the;
	}
	private function new()
	{
		spriteMap.set("Goldman",new Sprite(Assets.images.boy,400,575));
		spriteMap.set("Lisa",new Sprite(Assets.images.girl,400,575));
		spriteMap.set("Mom",new Sprite(Assets.images.mom,33));
		spriteMap.set("Vincent",new Sprite(Assets.images.vincent,28));
	}
	public function get(s:String):Sprite
	{
		return spriteMap.get(s);
	}
}