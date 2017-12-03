package;

import kha.Framebuffer;
import kha2d.Scene;
import kha2d.Sprite;
import states.IState;
import kha.Assets;
import util.Text;
import kha.input.Mouse;
import Data;
import kha2d.Animation;
import util.Button;
import states.RPGDate;

class Project 
{

	public static var the(get, null):Project;
	public var activeState:IState;
	public var credits:Int = 1000;
	public var date:RPGDate = new RPGDate();
	public var world:World = new World();

	public function new() 
	{
		activeState = new states.MenuState();
		activeState.init();
	}

	private static function get_the():Project
	{
		if(the == null)
		{
			the = new Project();
		}
		return the;
	}


	public function update(): Void 
	{
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

	public function changeState(s:IState)
	{
		if(activeState != null)
		{
			activeState.kill();
		}
		activeState = s;
		activeState.init();
	}

	public function reset()
	{
		credits = 1000;
	}
}
