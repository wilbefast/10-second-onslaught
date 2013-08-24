import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

class GameScene extends Scene
{
	// ---------------------------------------------------------------------------
	// ASSET LOADING
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false ;
	// private static var mapD_bd : BitmapData;
	// private static var uiD_bd : BitmapData;
	// private static var replayD_bd : BitmapData;
	// private static var moneyD_bd : BitmapData;
	// private static var buyingMarinesD_bd : BitmapData;
	// private static var buyingBombsD_bd : BitmapData;
	// private static var moreUnitsD_bd : BitmapData;
	// private static var lessUnitsD_bd : BitmapData;
	// private static var unitCostD_bd : BitmapData;
	
	// private static var mapA_bd : BitmapData;
	// private static var uiA_bd : BitmapData;
	// private static var timelineA_bd : BitmapData;

	private static function init()
	{
		// map_bd = Assets.getBitmapData("assets/GabariPlateau_01.png");
		// ui_bd = Assets.getBitmapData("assets/GabariGUI_01.png");

		// replayD_bd = Assets.getBitmapData("assets/GUI_fond_replay_01.png");
		// moneyD_bd = Assets.getBitmapData("assets/GUI_fond_bank_01.png");
		// buyingMarinesD_bd = Assets.getBitmapData("assets/GUI_ic_marine_01.png");
		// buyingBombsD_bd = Assets.getBitmapData("assets/GUI_ic_bombe_01.png");
		// moreUnitsD_bd = Assets.getBitmapData("assets/GUI_button_up_01.png");
		// lessUnitsD_bd = Assets.getBitmapData("assets/GUI_button_down_01.png");
		// unitCostD_bd = Assets.getBitmapData("assets/GUI_fond_achat_01.png");
		initialised = true ;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	// Attributes
	private var session : Session;
	private var timer : Float ;

	// Sprites
	// private var map : Sprite;
	// private var ui : Sprite;

	private var timeline : TimelineUI;
	private var map : MapUI;
	private var deploy : DeployUI;

	// private var replay : Sprite;
	// private var money : Sprite;
	// private var buyingMarines : Sprite;
	// private var buyingBombs : Sprite;
	// private var moreMarines : Sprite;
	// private var moreBombs : Sprite;
	// private var lessMarines : Sprite;
	// private var lessBombs : Sprite;
	// private var marinesCost : Sprite;
	// private var bombsCost : Sprite;
	
	public function new (_timer : Int) // NB - Int is NOT an object (reference) in Haxe !
	{
		super ();

		if (!initialised) 
			init();
		
		// Initialise attributes
		session = new Session(_timer);
		timer = session.getTimer() * 100;

		// Build draw list
		// map = new Sprite();
  	// ui = new Sprite();

  	map = new MapUI();
		timeline = new TimelineUI();
		deploy = new DeployUI();

		// replay = new Sprite();
		// money = new Sprite();
		// buyingMarines = new Sprite();
		// buyingBombs = new Sprite();
		// moreMarines = new Sprite();
		// moreBombs = new Sprite();
		// lessMarines = new Sprite();
		// lessBombs = new Sprite();
		// marinesCost = new Sprite();
		// bombsCost = new Sprite();
	}

	// ---------------------------------------------------------------------------
	// CALLBACKS
	// ---------------------------------------------------------------------------
	
	public override function onResize(event : Event) : Void
	{
		recalculateLayout();
	}

	public override function onEnter(previous : Scene) : Void 
	{
		playDeployPhase();
	}

	// la fin du décompte pour la phase d'attaque. Pour la phase de deploy c'est dans le bouton ButtonDeployEnd
	public override function onFrameEnter(event : Event) : Void
	{
		switch(phase)
		{
			case PHASE_ATTACK:
				timer -= Time.getDelta();
				if (timer < 0) 
					switchPhase();

			case PHASE_DEPLOY:
		}
	}

	public override function onMouseClick(event : MouseEvent) : Void
	{
		switchPhase();
	}

	// ---------------------------------------------------------------------------
	// PHASE MANAGEMENT
	// ---------------------------------------------------------------------------
	
	private static inline var PHASE_DEPLOY : Int = 0;
	private static inline var PHASE_ATTACK : Int = 1;

	private var phase : Int = PHASE_DEPLOY;

	public function switchPhase()
	{
		timer = session.getTimer() ;

		switch(phase)
		{
			case PHASE_DEPLOY:
				playAttackPhase();

			case PHASE_ATTACK:
				playDeployPhase();
		}
	}

	// ---------------------------------------------------------------------------
	// LAYOUTS
	// ---------------------------------------------------------------------------

	public function recalculateLayout()
	{
		switch(phase)
		{
			case PHASE_DEPLOY:
				layoutDeploy();

			case PHASE_ATTACK:
				layoutAttack();
		}
	}

	// ---------------------------------------------------------------------------
	// DEPLOYMENT PHASE
	// ---------------------------------------------------------------------------
	
	private function playDeployPhase()
	{
		// increment # replays if previous phase was attack
		if(phase == PHASE_ATTACK)
			session.incrementNbReplay();

		// phase is now attack phase
		phase = PHASE_DEPLOY;

		// clear all dudes
		GameObjectManager.purgeAll();

		// Reset Layout
		layoutDeploy();
	}
	
	private function layoutDeploy()
	{
		// clear UI
		while (numChildren > 0) 
			this.removeChildAt(0);

		// map
		addChild(map);
		map.width = stage.stageWidth;
		map.height = stage.stageHeight * 0.7;
		map.x = map.y = 0;

		// timeline
		addChild(timeline);
		timeline.width = stage.stageWidth;
		timeline.x = 0;
		timeline.y = map.y + map.height;

		// special deploy layout
		addChild(deploy);
		deploy.y = timeline.y + timeline.height;
		deploy.height = stage.stageHeight - deploy.y;
		deploy.recalculateLayout();
	}



	// ---------------------------------------------------------------------------
	// ATTACK PHASE
	// ---------------------------------------------------------------------------
	
	private function playAttackPhase()
	{
		// phase is now attack phase
		phase = PHASE_ATTACK;

		// clear all dudes
		GameObjectManager.purgeAll();
	
		// change layout
		layoutAttack();

		// ------------------------------------------------------------------------------
		// NB - these dudes should be spawned based on deploy

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

		// create colonies
		for(i in 0 ... 5)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Colony(spawn_width + Math.cos(spawn_angle)*spawn_width/5, 
									spawn_height + Math.sin(spawn_angle)*spawn_height/5);
		}
	}

	public function layoutAttack()
	{
		// clear UI
		while (numChildren > 0) 
			this.removeChildAt(0);

		// timeline
		addChild(timeline);
		timeline.width = stage.stageWidth;
		timeline.x = 0;
		timeline.y = stage.stageHeight - timeline.height;

		// map
		addChild(map);
		map.width = stage.stageWidth;
		map.height = timeline.y;
		map.x = map.y = 0;
		

	}
}