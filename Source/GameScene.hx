import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

class GameScene extends Scene
{
	// ---------------------------------------------------------------------------
	// ASSET LOADING
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false ;

	private static function init()
	{
		initialised = true ;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	// Attributes
	private var session : Session;
	private var time : Float = 0;
	private var radialMenu : RadialMenu;
	
	private var timeline : TimelineUI;
	private var map : MapUI;
	private var top : DeployUI;
	
	public function new (_time : Int, _money : Int ) // NB - Int is NOT an object (reference) in Haxe !
	{
		super ();

		if (!initialised) 
			init();
		
		// Initialise attributes
		session = new Session(_time, _money);
		radialMenu = new RadialMenu(clickOnRadialMenu);

		map = new MapUI(this);
		timeline = new TimelineUI(this);
		top = new DeployUI(this);
	}

	public function getSession()
	{
		return session ;
	}
	
	// ---------------------------------------------------------------------------
	// CALLBACKS -- SCENE
	// ---------------------------------------------------------------------------
	
	public override function onResize(event : Event) : Void
	{
		recalculateLayout();
	}

	public override function onEnter(previous : Scene) : Void 
	{
		// build hierarchy
		// ---------------------------------------------------------------------------

		// map
		addChild(map);
		map.addEventListener(MouseEvent.CLICK, clickOnMap);

		// game objects
		map.addChild(GameObjectManager.get());

		// timeline
		addChild(timeline);
    timeline.addEventListener(MouseEvent.CLICK, clickOnTimeline);

		// radial menu
		addChild(radialMenu);
		
		// top
		addChild(top);

		// start !
		// ---------------------------------------------------------------------------
		recalculateLayout();
		playDeployPhase();
	}

	// la fin du décompte pour la phase d'attaque. Pour la phase de deploy c'est dans le bouton ButtonDeployEnd
	public override function onFrameEnter(event : Event) : Void
	{
		switch(phase)
		{
			case PHASE_ATTACK:
				
				time += Time.getDelta();
				if (time > session.getDuration())
				{
					 var nbBaseSurvived = 0 ;
					 for (it in GameObjectManager.getMatching(function (o : GameObject) return Std.is(o, Colony)))
					 {
						 nbBaseSurvived ++ ;
					 }

					if (nbBaseSurvived == 5) SceneManager.setScene("Victory");
					session.baseSaved(nbBaseSurvived);
					switchPhase();
				}

				timeline.update(time);

				session.instantiateUnits(Math.floor(time));

			case PHASE_DEPLOY:
		}

		map.update();
		top.update();
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
	}

	// ---------------------------------------------------------------------------
	// CALLBACKS -- CUSTOM
	// ---------------------------------------------------------------------------

	public function clickOnMap(event : MouseEvent) : Void
	{
		switch(phase)
		{
			case PHASE_DEPLOY:
				if(!radialMenu.isOpened())
				{
					radialMenu.x = event.stageX;
					radialMenu.y = event.stageY;
				}
				radialMenu.toggle();
		}
	}

	public function clickOnTimeline(event : MouseEvent) : Void
	{
		radialMenu.close();
		timeline.onMouseClick(event);
	}

	public function clickOnRadialMenu(option : Int) : Void
	{
		switch(option)
		{
			case 0: 
				if (session.getMoney() > UnitType.marine.getPrice())
				{
					session.placeUnit(radialMenu.x, radialMenu.y, UnitType.nuke);
					buyMarine();
				}
				
			case 1:
				if (session.getMoney() > UnitType.nuke.getPrice())
				{
					session.placeUnit(radialMenu.x, radialMenu.y, UnitType.marine);
					buyNuke();
				}
		}
		radialMenu.close();
	}
	
	public function buyMarine()
	{
		session.withdrawMoney(UnitType.marine.getPrice());
	}

	public function buyNuke()
	{
		session.withdrawMoney(UnitType.nuke.getPrice());
	}
	
	// ---------------------------------------------------------------------------
	// PHASE MANAGEMENT
	// ---------------------------------------------------------------------------
	
	private static inline var PHASE_DEPLOY : Int = 0;
	private static inline var PHASE_ATTACK : Int = 1;

	private var phase : Int = PHASE_DEPLOY;

	public function switchPhase()
	{
		time = 0;
		session.setTimelineSelection(0);

		switch(phase)
		{
			case PHASE_DEPLOY:
				playAttackPhase();

			case PHASE_ATTACK:
				playDeployPhase();
		}
		top.startButton.changeButton();
	}

	// ---------------------------------------------------------------------------
	// LAYOUTS
	// ---------------------------------------------------------------------------

	public function recalculateLayout()
	{
		// map
		map.recalculateLayout();
		
		// timeline
		timeline.recalculateLayout();
		timeline.y = stage.stageHeight - timeline.height;

		top.recalculateLayout();
	}

	// ---------------------------------------------------------------------------
	// DEPLOYMENT PHASE
	// ---------------------------------------------------------------------------

	private function playDeployPhase()
	{
		session.resetMoney();
		// increment # replays if previous phase was attack
		if(phase == PHASE_ATTACK)
			session.incrementNbReplay();

		// phase is now attack phase
		phase = PHASE_DEPLOY;

		// clear all dudes
		GameObjectManager.purgeAll();

		// create colonies
		spawnColonies();
	}

	// ---------------------------------------------------------------------------
	// ATTACK PHASE
	// ---------------------------------------------------------------------------

	
	private function playAttackPhase()
	{
		// phase is now attack phase
		phase = PHASE_ATTACK;

		radialMenu.close();

		// create units
		spawnUnits();
	}

	// ---------------------------------------------------------------------------
	// SPAWN UNITS
	// ---------------------------------------------------------------------------

	private function spawnColonies()
	{
			new Colony(0, -100);
			new Colony(-200, -220);
			new Colony(450, 50);
			new Colony(-350, 100);
			new Colony(70, 250);
	}

	private function spawnUnits()
	{
		var spawn_width = 800; // TODO - get from stage.stageWidth
		var spawn_height = 600; // TODO - get from stage.stageWidth

		// create zerglings
		for(i in 0 ... 30)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Zergling(Math.cos(spawn_angle)*spawn_width, 
										Math.sin(spawn_angle)*spawn_height);
		}
	}
}