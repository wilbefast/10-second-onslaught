import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;

class GameScene extends Scene
{
	private var gameState : Bool ; //true deploy, false attack
	private var session : Session ;
	private static var initialised : Bool = false ;
	private static var mapD_bd : BitmapData;
	private static var uiD_bd : BitmapData;
	private static var timelineD_bd : BitmapData;
	private static var mapA_bd : BitmapData;
	private static var uiA_bd : BitmapData;
	private static var timelineA_bd : BitmapData;
	
	private var map_cont : Sprite;
	private var ui_cont : Sprite;
	private var timeline_cont : Sprite;
	
	public function new (ptimer : Int) 
	{
		super ();
		if (!initialised) init();
		gameState = true ;
		session = new Session(ptimer);
		map_cont = new Sprite();
        ui_cont = new Sprite();
		timeline_cont = new Sprite();
	}
	
	public override function onEnter(previous : Scene) : Void 
	{
		if(gameState) playDeployPhase();
	}
	
	private static function init()
	{
		mapD_bd = Assets.getBitmapData("assets/GabariPlateau_01.png");
		uiD_bd = Assets.getBitmapData("assets/GabariGUI_01.png");
		timelineD_bd = Assets.getBitmapData("assets/GabariTimeline_01.png");
		mapA_bd = Assets.getBitmapData("assets/GabariPlateau_01.png");
		uiA_bd = Assets.getBitmapData("assets/GabariGUI_01.png");
		timelineA_bd = Assets.getBitmapData("assets/GabariTimeline_01.png");
		initialised = true ;
	}
	
	//changer par un clic bouton ou la fin du décompte
	public override function onMouseClick(event : MouseEvent) : Void
	{
		switchPhase();
		if (gameState) playDeployPhase();
		else playAttackPhase();
	}
	
	public function switchPhase()
	{
		if (gameState) gameState = false ;
		else
		{
			gameState = true ;
			session.incrementNbReplay();
		}
		trace("gameState : " + gameState + " " + session.getTimer() + " nbReplay :" + session.getNbReplay() );
	}
	
	private function playDeployPhase()
	{
		// clear all dudes
		GameObjectManager.purgeAll();
		// clear UI
		while (numChildren > 0) this.removeChildAt(0);
		// New Layout
		var mapBitmap : Bitmap = new Bitmap(mapD_bd) ;
		var uiBitmap : Bitmap = new Bitmap(uiD_bd) ;
		var timelineBitmap : Bitmap = new Bitmap(timelineD_bd) ;
		mapBitmap.x = 12 ;
		uiBitmap.x = 12 ;
		timelineBitmap.x = 12 ;
		mapBitmap.y = 12 ;
		timelineBitmap.y = mapBitmap.height + 12 ;
		uiBitmap.y = mapBitmap.height + timelineBitmap.height + 12;
		map_cont.addChild(mapBitmap);
		ui_cont.addChild(uiBitmap);
		timeline_cont.addChild(timelineBitmap);
		addChild(map_cont);
		addChild(ui_cont);
		addChild(timeline_cont);
		// button to switch to attack phase
		var buttonSwitchToAttack : ButtonDeployEnd = new ButtonDeployEnd(this);
		buttonSwitchToAttack.x = 12 ;
		buttonSwitchToAttack.y = uiBitmap.y ;
		addChild(buttonSwitchToAttack);
	}
	
	private function playAttackPhase()
	{
		// clear all dudes
		GameObjectManager.purgeAll();
		// clear UI
		while (numChildren > 0) this.removeChildAt(0);
		// New Layout
		var mapBitmap : Bitmap = new Bitmap(mapA_bd) ;
		var uiBitmap : Bitmap = new Bitmap(uiA_bd) ;
		var timelineBitmap : Bitmap = new Bitmap(timelineA_bd) ;
		mapBitmap.x = 12 ;
		uiBitmap.x = 12 ;
		timelineBitmap.x = 12 ;
		mapBitmap.y = 12 ;
		timelineBitmap.y = mapBitmap.height + 12 ;
		uiBitmap.y = mapBitmap.height + timelineBitmap.height + 12;
		map_cont.addChild(mapBitmap);
		ui_cont.addChild(uiBitmap);
		timeline_cont.addChild(timelineBitmap);
		addChild(map_cont);
		addChild(ui_cont);
		addChild(timeline_cont);

		// ------------------------------------------------------------------------------
		// PLACEHOLDER TEST CODE : these dudes should be spawned based on deploy
		// ------------------------------------------------------------------------------

		// create dudes
		var spawn_width = 400; // TODO - get from stage.stageWidth
		var spawn_height = 300; // TODO - get from stage.stageWidth

		// create zerglings
		for(i in 0 ... 30)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Zergling((1 + Math.cos(spawn_angle))*spawn_width, 
										(1 + Math.sin(spawn_angle))*spawn_height);
		}

		// create marines
		for(i in 0 ... 10)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Marine((3 + Math.cos(spawn_angle))*spawn_width/3, 
										(3 + Math.sin(spawn_angle))*spawn_height/3);
		}

	}
}