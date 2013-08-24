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
	private var timer : Float ;
	private var radialMenu : RadialMenu;
	
	private var timeline : TimelineUI;
	private var map : MapUI;
	private var deploy : DeployUI;
	
	public function new (_timer : Int) // NB - Int is NOT an object (reference) in Haxe !
	{
		super ();

		if (!initialised) 
			init();
		
		// Initialise attributes
		session = new Session(_timer);
		timer = session.getTimer() * 100;
		radialMenu = new RadialMenu();

		map = new MapUI(this);
		timeline = new TimelineUI(this);
		deploy = new DeployUI(this);
	}

	public function getSession()
	{
		return session ;
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
		// build hierarchy
		// ---------------------------------------------------------------------------

		// map
		addChild(map);
		map.width = stage.stageWidth;
		map.height = stage.stageHeight;
		map.x = map.y = 0;

		// game objects
		addChild(GameObjectManager.get());

		// timeline
		addChild(timeline);
		timeline.width = stage.stageWidth;
		timeline.x = 0;
		timeline.y = stage.stageHeight*0.8 - timeline.height;

		// special deploy layout
		addChild(deploy);
		deploy.height = stage.stageHeight*0.2;
		deploy.y = stage.stageHeight - deploy.height;
		deploy.recalculateLayout();

		// radial menu
		addChild(radialMenu);

		// build hierarchy
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
				timer -= Time.getDelta();
				if (timer < 0) 
					switchPhase();

			case PHASE_DEPLOY:
		}
		map.update();
		timeline.update();
		deploy.update();
	}

	public override function onMouseClick(event : MouseEvent) : Void
	{
		if(!radialMenu.isOpen())
		{
			radialMenu.x = event.stageX;
			radialMenu.y = event.stageY;
		}
		radialMenu.toggle();
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
		GameObjectManager.setCameraPosition(map.x + map.width/2, map.y + map.height/2);
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

		// show deploy layout
		Actuate.tween(timeline, 1, { y : stage.stageHeight-deploy.height-timeline.height }, true)
					.ease (Quad.easeOut);
		Actuate.tween(deploy, 1, { y : stage.stageHeight-deploy.height }, true)
					.ease (Quad.easeOut);

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

		// hide deploy layout
		Actuate.tween(timeline, 1, { y : stage.stageHeight-timeline.height }, true)
					.ease (Quad.easeOut);
		Actuate.tween(deploy, 1, { y : stage.stageHeight }, true)
					.ease (Quad.easeOut);

		// create units
		spawnUnits();
	}

	// ---------------------------------------------------------------------------
	// SPAWN UNITS
	// ---------------------------------------------------------------------------

	private function spawnColonies()
	{
			new Colony(0, 0);
			new Colony(-200, -250);
			new Colony(450, 10);
			new Colony(-350, 100);
			new Colony(50, -150);
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

		// create  nukes
		for(i in 0 ... 3)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Nuke(Math.cos(spawn_angle)*spawn_width/2, 
										Math.sin(spawn_angle)*spawn_height/2);
		}


		// create marines
		for(i in 0 ... 10)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Marine(Math.cos(spawn_angle)*spawn_width/4, 
										Math.sin(spawn_angle)*spawn_height/4);
		}
	}
}