import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

import units.UnitType;
import units.UnitPlacement;
import units.Zergling;
import units.Colony;

import hacksaw.GameObject;
import hacksaw.GameObjectManager;
import hacksaw.Time;

class GameScene extends Scene
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var cancel_data : BitmapData;

	private static var initialised : Bool = false;
	private static function init() : Void
	{
		cancel_data = Assets.getBitmapData("assets/icon_cancel.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	// Attributes
	private var session : Session;
	private var time : Float = 0;
	private var buyMenu : RadialMenu;
	private var sellMenu : RadialMenu;
	
	private var timeline : TimelineUI;
	private var map : MapUI;
	private var top : DeployUI;
	
	public function new (_time : Int, _money : Int ) // NB - Int is NOT an object (reference) in Haxe !
	{
		super ();

		// load assets
		if(!initialised)
			init();
		
		// Initialise attributes
		session = new Session(_time, _money);
		pickedUnitOffset = { x : 0, y : 0};

		// build interface
		map = new MapUI(this);
		timeline = new TimelineUI(this);
		top = new DeployUI(this);

		// build radial menus ...
		// ... buy menu
		buyMenu = new RadialMenu();
		buyMenu.addOption(function() clickBuyUnit(UnitType.marine), UnitType.marine.icon);
		buyMenu.addOption(function() clickBuyUnit(UnitType.nuke), UnitType.nuke.icon);
		// ... sell menu
		sellMenu = new RadialMenu();
		sellMenu.addOption(function() clickSellUnit(), cancel_data);

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
		map.addEventListener(MouseEvent.MOUSE_DOWN, pressOnMap);
		map.addEventListener(MouseEvent.MOUSE_UP, releaseOnMap);
		map.addEventListener(MouseEvent.MOUSE_MOVE, moveOverMap);

		// game objects
		map.addChild(GameObjectManager.get());

		// timeline
		addChild(timeline);
    timeline.addEventListener(MouseEvent.CLICK, clickOnTimeline);

		// radial menus
		addChild(buyMenu);
		addChild(sellMenu);
		
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
					var nbBaseSurvived = 
						GameObjectManager.countMatching(function (o : GameObject) return Std.is(o, Colony));

					if (nbBaseSurvived >= 5) 
						SceneManager.setScene("Victory");

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

	// ---------------------------------------------------------------------------
	// CALLBACKS -- MAP AREA
	// ---------------------------------------------------------------------------

	private function pressOnMap(event : MouseEvent) : Void
	{
		if(phase != PHASE_DEPLOY)
			return;

		// open/close buy menu
		if(!buyMenu.isOpened())
		{
			buyMenu.x = event.stageX;
			buyMenu.y = event.stageY;
			buyMenu.open();
		}
		else
			buyMenu.close();

		// close sell menu
		sellMenu.close();
	}

	private function releaseOnMap(event : MouseEvent) : Void
	{

	}

	private function moveOverMap(event : MouseEvent) : Void
	{
		// move picked unit
		if(pickedUnit != null)
		{
			pickedUnit.setPosition(GameObjectManager.getWorldPosition(
				event.stageX + pickedUnitOffset.x, 
				event.stageY + pickedUnitOffset.y));

			// clear sell unit if moving the unit
			sellUnit = null;
		}
	}

	// ---------------------------------------------------------------------------
	// CALLBACKS -- INTERFACE
	// ---------------------------------------------------------------------------

	private function clickOnTimeline(event : MouseEvent) : Void
	{
		// close any open menus
		buyMenu.close();
		sellMenu.close();

		// delegate event
		timeline.onMouseClick(event);
	}

	private function clickBuyUnit(unitType : UnitType) : Void
	{
		// attempt to buy the unit
		var placement : UnitPlacement 
			= session.tryPlaceUnit(buyMenu.x, buyMenu.y, unitType);

		// success ? 
		if(placement != null)
		{
			// register event from moving or removing previously placed units
			placement.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownOnPlacement);
			placement.addEventListener(MouseEvent.MOUSE_UP, mouseUpOnPlacement);

			// keep menu open only if transaction fails
			buyMenu.close();
		}
		// not enough minerals !
		else
		{

		}

		// in any case close the menu
		
	}

	private function clickSellUnit() : Void
	{
		session.depositMoney(sellUnit.unitType.price);
		sellUnit.purge = true;
	}

	// ---------------------------------------------------------------------------
	// CALLBACKS -- UNIT PLACEMENTS
	// ---------------------------------------------------------------------------

	private var pickedUnit : UnitPlacement;
	private var pickedUnitOffset : { x : Float, y : Float};

	private function mouseDownOnPlacement(event : MouseEvent) : Void
	{
		// grab the unit
		pickedUnit = cast(event.target, UnitPlacement);
		var viewPos = GameObjectManager.getViewPosition(pickedUnit.x, pickedUnit.y);
		pickedUnitOffset = { x : viewPos.x - event.stageX, y : viewPos.y -event.stageY };

		// close any open menus
		buyMenu.close();
		if(sellUnit != pickedUnit)
			sellMenu.close();

		// set unit to sell
		sellUnit = pickedUnit;

		// stop event from reaching underneath
		event.stopPropagation();
	}

	private var sellUnit : UnitPlacement = null;

	private function mouseUpOnPlacement(event : MouseEvent) : Void
	{
		// clear picked unit on mouse-up
		pickedUnit = null;

		// was this a click (mouse, no move, up) ?
		if(sellUnit != null)
		{
			if(!sellMenu.isOpened())
			{
				sellMenu.x = event.stageX;
				sellMenu.y = event.stageY;
			}
			sellMenu.toggle();
		}

		// stop event from reaching underneath
		event.stopPropagation();
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

		buyMenu.close();

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