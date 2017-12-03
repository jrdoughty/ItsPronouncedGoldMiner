package;

import kha.Framebuffer;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Assets;
import util.Text;
import kha.input.Mouse;
import Data;
import kha2d.Animation;
import util.Button;

class Project {

	
	public static var the(get, null):Project;
	public var credits:Int = 1000;
	public var date:RPGDate = new RPGDate();
	public var world:World = new World();

	public function new() 
	{
		date.init(0);
	}

	private static function get_the():Project
	{
		if(the == null)
		{
			the = new Project();
		}
		return the;
	}

	public function backToWorld()
	{
		world.init();	
	}

	public function update(): Void {
		Scene.the.update();
	}
	public function render(framebuffer: Framebuffer): Void {	
		var graphics = framebuffer.g2;
		graphics.begin();
		Scene.the.render(graphics);	
		for(i in Text.texts)
		{
			i.render(graphics);
		}
		graphics.end();
	}
}
