package states;

import kha.Framebuffer;
import kha2d.Scene;
import kha2d.Sprite;
import kha.Assets;
import util.Text;
import kha.input.Mouse;
import Data;
import kha2d.Animation;
import util.Button;
import util.ButtonManager;

class RPGDate extends BaseState
{
	var activeLevel:Int = 0;
	var chatName:String = "main";
	var pointInConvArray:Int = 0;
	var pointInTextArray:Int = 0;
	var data = Data.the;
	var chats:Map<String,Dynamic>;
	var buttonsActive:Bool = false;
	var activeBG:String = "";

	var background:Sprite;
	var dash:Sprite;
	var n:Text;
	var t:Text;
	var t2:Text;
	var creditText:Text = new Text("",0,360,40);

	public function new() 
	{
		ButtonManager.the;
	}

	public override function init()
	{
		Mouse.get().notify(down, up, move, scroll);
		n = new Text("",5,456,30);
		t = new Text("",5,486,30);
		t2 = new Text("test",5,516,30);
		creditText = new Text("",5,0,40);
		startLevel();
	}

	public function down(mButton:Int, x:Int, y:Int)
	{
		chats = data.levels[activeLevel].chats;
		if(Reflect.hasField(chats,chatName) && !buttonsActive)
		{
			var theChat:Array<Dialog> = Reflect.field(chats,chatName);
			if(theChat.length > pointInConvArray)
			{
				if(theChat[pointInConvArray].type == "dialog")
				{
					processDialog();
				}
				else if (theChat[pointInConvArray].type == "reaction")
				{
					processReaction();
				}
				else if (theChat[pointInConvArray].type == "choice")
				{
					processChoice();
				}
				creditText.content = Project.the.credits+"";
				checkForEndLevel();
			}
		}
		else
		{
			trace("chat name is " + chatName +" and buttons are considered "+(buttonsActive?"active":"deactivated"));
		}
		dash.visible = !buttonsActive;
	}

	public function processDialog()
	{
		var theChat:Array<Dialog> = Reflect.field(chats,chatName);
		if(theChat[pointInConvArray].texts.length > pointInTextArray)
		{
			var strs:Array<String> = theChat[pointInConvArray].texts[pointInTextArray].text.split("\n");
			n.content = theChat[pointInConvArray].char +": ";
			t.content = strs[0];
			t2.content = strs.length>1?strs[1]:"";
			Project.the.credits -= Std.int(theChat[pointInConvArray].texts[pointInTextArray].cost);
			for(i in data.levels[activeLevel].sprites)
			{
				if(i.idString != "Goldman")
				{
					if(!Project.the.points.exists(i.idString))
					{
						Project.the.points.set(i.idString,0);
					}
					Project.the.points[i.idString] += theChat[pointInConvArray].texts[pointInTextArray].points;
				}
			}
			if(theChat[pointInConvArray].texts[pointInTextArray].chat != null)
			{
				chatName = theChat[pointInConvArray].texts[pointInTextArray].chat;
				pointInTextArray = 0;
				pointInConvArray = 0;
			}
			else
			{
				pointInTextArray++;
				if(pointInTextArray == theChat[pointInConvArray].texts.length)
				{
					pointInConvArray++;
					pointInTextArray = 0;
				}
			}
		}
	}

	public function processReaction()
	{
		var theChat:Array<Dialog> = Reflect.field(chats,chatName);
		pointInTextArray = Math.floor(Math.random() * theChat[pointInConvArray].texts.length);
		t.content = theChat[pointInConvArray].char +": "+ theChat[pointInConvArray].texts[pointInTextArray].text;
		Project.the.credits -= theChat[pointInConvArray].texts[pointInTextArray].cost;
		if(theChat[pointInConvArray].texts[pointInTextArray].chat != null)
		{
			chatName = theChat[pointInConvArray].texts[pointInTextArray].chat;
			pointInConvArray = 0;
			pointInTextArray = 0;
		}
	}

	public function processChoice()
	{
		var theChat:Array<Dynamic> = Reflect.field(chats,chatName);
		var bs:Array<Button> = [];
		t.content = "";
		for(i in 0...theChat[pointInConvArray].texts.length)
		{
			buttonsActive = true;
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
	}

	public function checkForEndLevel()
	{
		if(chatName == "endlevel")
		{
			for(i in data.levels[activeLevel].sprites)
			{
				Scene.the.removeOther(SpriteMap.the.get(i.idString));
			}
			pointInConvArray = 0;
			pointInTextArray = 0;
			activeLevel++;
			chatName = "main";
			trace("level is now "+activeLevel);
			var started:Bool = false;
	
			startLevel();
		}
	}

	private function startLevel()
	{
		//creditText.content = data.levels[activeLevel].days+" days since Dimentia creditText";
		Scene.the.clear();
		if(data.levels[activeLevel].background != activeBG)
		{
			activeBG = data.levels[activeLevel].background;
			if(background == null)
			{
				background = new Sprite(Reflect.field(Assets.images, activeBG),Reflect.field(Assets.images, activeBG).width,Reflect.field(Assets.images, activeBG).height);
			}
		}
		Scene.the.addOther(background);
		for(i in data.levels[activeLevel].sprites)
		{
			var s = SpriteMap.the.get(i.idString);
			s.x = i.x;
			s.y = i.y;
			s.setAnimation(new Animation([i.frame],0));
			Scene.the.addOther(s);
		}
		dash = new Sprite(Assets.images.wallet,800,265);
		dash.y = 335;
		dash.z = 2;
		Scene.the.addOther(dash);
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
