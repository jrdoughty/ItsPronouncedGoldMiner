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
import util.ButtonManager;

class RPGDate {
	var activeLevel:Int = 0;
	var chatName:String = "main";
	var pointInConvArray:Int = 0;
	var pointInTextArray:Int = 0;
	var data = Data.the;
	var chats:Map<String,Dynamic>;
	var t:Text = new Text("",0,456,30);
	var creditText:Text = new Text("",0,360,40);
	var buttonsActive:Bool = false;
	var but = Button.buttons;
	var activeBG:String = "";
	var background:Sprite;
	var dash = new Sprite(Assets.images.dash,800,200);

	public function new() 
	{
		ButtonManager.the;
	}

	public function init(lvl:Int)
	{
		activeLevel = lvl;
		Mouse.get().notify(down, up, move, scroll);
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
			t.content = theChat[pointInConvArray].char +": "+ theChat[pointInConvArray].texts[pointInTextArray].text;
			Project.the.credits -= Std.int(theChat[pointInConvArray].texts[pointInTextArray].cost);
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
			for(i in data.levels)
			{
				if(i.id == activeLevel)
				{
					startLevel();
					started = true;
				}
			}
			if(!started)
				Scene.the.clear();
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
				var imgs = Assets.images;
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
		dash.y = 400;
		dash.z = 2;
		Scene.the.addOther(dash);
		//creditText.content = Project.the.credits+"";
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
