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
		map.height = stage.stageHeight;
		map.x = map.y = 0;

		// timeline
		addChild(timeline);
		timeline.width = stage.stageWidth;
		timeline.x = 0;
		timeline.y = stage.stageHeight*0.7;

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
			new Zergling(Math.cos(spawn_angle)*spawn_width, 
										Math.sin(spawn_angle)*spawn_height);
		}

		// create marines
		for(i in 0 ... 10)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Marine(Math.cos(spawn_angle)*spawn_width/2, 
										Math.sin(spawn_angle)*spawn_height/2);
		}

		// create colonies
		for(i in 0 ... 5)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Colony(Math.cos(spawn_angle)*spawn_width/5, 
										Math.sin(spawn_angle)*spawn_height/5);
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