package;
import util.ButtonManager;
import util.Button;
import kha2d.Sprite;
import kha.Assets;
import kha.input.Mouse;

class World 
{
	public function new() 
	{
		ButtonManager.the;
	}

	public function init()
	{
		Mouse.get().notify(down, up, move, scroll);		
		var bs:Array<Button> = [];
		/*
		for(i in 0...theChat[pointInConvArray].texts.length)
		{
			bs.push(new Button(75,100+i*75, 540, 60,new Sprite(Assets.images.button),theChat[pointInConvArray].texts[i].text,function(l:Int,j:Int,k:Int)
				{
				Project.the.credits -= Std.int(theChat[pointInConvArray].texts[i].cost);
					chatName = theChat[pointInConvArray].texts[i].chat;
					buttonsActive = false;
					Button.clear();
					pointInConvArray = 0;
					pointInTextArray = 0;
					checkForEndLevel();
					down(l,j,k);
				},16));
		}
		*/
	}

	public function down(mButton:Int, x:Int, y:Int)
	{

	}

	public function up(mButton:Int, x:Int, y:Int)
	{
	}	
	public function move(x:Int,y:Int,cx:Int,cy:Int)
	{

	}
	public function scroll(scroll:Int)
	{

	}
}