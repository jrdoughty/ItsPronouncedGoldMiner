package states;

import kha2d.Sprite;
import util.Button;
import kha2d.Scene;
import kha.Assets;
import kha2d.Animation;
import util.Text;

class MenuState extends BaseState
{
	public function new():Void
	{
	}

	public override function init()
	{
		Scene.the.addOther(new Sprite(Assets.images.background, 800, 600, 0));

		new Button(100, 100, 120, 30, new Sprite(Assets.images.button), "PLAY", play, 18);

		new Button(100, 135, 120, 30, new Sprite(Assets.images.button), "HELP", help, 18);
		
		new Button(100, 170, 120, 30, new Sprite(Assets.images.button), "Credits", credits, 18);

		new Text("It's Pronounced", 70, 0, 30);
		new Text("Gold MINER!", 85, 35, 40);

	}

	public function play(b:Int,x:Int,y:Int)
	{
		Project.the.reset();
		Project.the.changeState(new RPGDate());
	}

	public function help(b:Int,x:Int,y:Int)
	{
		//Project.the.changeState(new HelpState());
	}

	public function credits(b:Int,x:Int,y:Int)//sprite:FlxSprite = null)
	{
		//Project.the.changeState(new CreditsState());
	}
	public override function kill():Void
	{
		super.kill();
	}

}