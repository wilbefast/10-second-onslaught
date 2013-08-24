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
	private static var mapD_bd : BitmapData;
	private static var uiD_bd : BitmapData;
	private static var timelineD_bd : BitmapData;
	private static var replayD_bd : BitmapData;
	private static var moneyD_bd : BitmapData;
	private static var buyingMarinesD_bd : BitmapData;
	private static var buyingBombsD_bd : BitmapData;
	private static var moreUnitsD_bd : BitmapData;
	private static var lessUnitsD_bd : BitmapData;
	private static var unitCostD_bd : BitmapData;
	
	private static var mapA_bd : BitmapData;
	private static var uiA_bd : BitmapData;
	private static var timelineA_bd : BitmapData;

	private static function init()
	{
		mapD_bd = Assets.getBitmapData("assets/GabariPlateau_01.png");
		uiD_bd = Assets.getBitmapData("assets/GabariGUI_01.png");
		timelineD_bd = Assets.getBitmapData("assets/TimelineBG_01.png");
		mapA_bd = Assets.getBitmapData("assets/GabariPlateau_01.png");
		uiA_bd = Assets.getBitmapData("assets/GabariGUI_01.png");
		timelineA_bd = Assets.getBitmapData("assets/TimelineBG_01.png");
		replayD_bd = Assets.getBitmapData("assets/GUI_fond_replay_01.png");
		moneyD_bd = Assets.getBitmapData("assets/GUI_fond_bank_01.png");
		buyingMarinesD_bd = Assets.getBitmapData("assets/GUI_ic_marine_01.png");
		buyingBombsD_bd = Assets.getBitmapData("assets/GUI_ic_bombe_01.png");
		moreUnitsD_bd = Assets.getBitmapData("assets/GUI_button_up_01.png");
		lessUnitsD_bd = Assets.getBitmapData("assets/GUI_button_down_01.png");
		unitCostD_bd = Assets.getBitmapData("assets/GUI_fond_achat_01.png");
		initialised = true ;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	// Attributes
	private var gameState : Bool; // true deploy, false attack
	private var session : Session;
	private var timer : Float ;

	// Sprites
	private var map : Sprite;
	private var ui : Sprite;
	private var timeline : Sprite;
	private var replay : Sprite;
	private var money : Sprite;
	private var buyingMarines : Sprite;
	private var buyingBombs : Sprite;
	private var moreMarines : Sprite;
	private var moreBombs : Sprite;
	private var lessMarines : Sprite;
	private var lessBombs : Sprite;
	private var marinesCost : Sprite;
	private var bombsCost : Sprite;
	
	public function new (ptimer : Int) // NB - Int is NOT passed as reference in Haxe !
	{
		super ();

		if (!initialised) 
			init();
		
		// Initialise attributes
		gameState = true; 
		session = new Session(ptimer);
		timer = session.getTimer() * 100;

		// Build draw list
		map = new Sprite();
    ui = new Sprite();
		timeline = new Sprite();
		replay = new Sprite();
		money = new Sprite();
		buyingMarines = new Sprite();
		buyingBombs = new Sprite();
		moreMarines = new Sprite();
		moreBombs = new Sprite();
		lessMarines = new Sprite();
		lessBombs = new Sprite();
		marinesCost = new Sprite();
		bombsCost = new Sprite();
	}

	// ---------------------------------------------------------------------------
	// CALLBACKS
	// ---------------------------------------------------------------------------
	
	public override function onEnter(previous : Scene) : Void 
	{
		if(gameState) playDeployPhase();
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
	}

	// la fin du décompte pour la phase d'attaque. Pour la phase de deploy c'est dans le bouton ButtonDeployEnd
	public override function onFrameEnter(event : Event) : Void
	{
		if (!gameState) 
		{
			timer -= Time.getDelta();
			if (timer < 0) switchPhase();
		}
	}

	// ---------------------------------------------------------------------------
	// PHASE MANAGEMENT
	// ---------------------------------------------------------------------------
	
	public function switchPhase()
	{
		timer = session.getTimer() ;
		if (gameState) gameState = false ;
		else
		{
			gameState = true ;
			session.incrementNbReplay();
		}
		if (gameState) playDeployPhase();
		else playAttackPhase();
	}

	// ---------------------------------------------------------------------------
	// DEPLOYMENT PHASE
	// ---------------------------------------------------------------------------
	
	private function playDeployPhase()
	{
		// clear all dudes
		GameObjectManager.purgeAll();
		// clear UI
		while (numChildren > 0) this.removeChildAt(0);
		// New Layout
		layoutDeploy();
	}
	
	private function layoutDeploy()
	{
		var mapBitmap : Bitmap = new Bitmap(mapD_bd) ;
		var uiBitmap : Bitmap = new Bitmap(uiD_bd) ;
		var timelineBitmap : Bitmap = new Bitmap(timelineD_bd) ;
		mapBitmap.x = 12 ;
		uiBitmap.x = 12 ;
		timelineBitmap.x = 12 ;
		mapBitmap.y = 12 ;
		timelineBitmap.y = mapBitmap.height + 12 ;
		uiBitmap.y = mapBitmap.height + timelineBitmap.height + 12;
		map.addChild(mapBitmap);
		ui.addChild(uiBitmap);
		timeline.addChild(timelineBitmap);
		addChild(map);
		addChild(ui);
		addChild(timeline);
		// Score
		var replayBitmap : Bitmap = new Bitmap(replayD_bd);
		replayBitmap.x = 20 ;
		replayBitmap.y = uiBitmap.y ;
		replay.addChild(replayBitmap);
		addChild(replay);
		addChild (new DefaultTextField("" + session.getNbReplay() , 160, uiBitmap.y ));
		var moneyBitmap : Bitmap = new Bitmap(moneyD_bd);
		moneyBitmap.x = 20 ;
		moneyBitmap.y = uiBitmap.y + replayBitmap.height ;
		money.addChild(moneyBitmap);
		addChild(money);
		addChild (new DefaultTextField("" + session.getMoney() , 150, uiBitmap.y + replayBitmap.height + 50 ));
		//Achat d'units
		var buyingMarinesBitmap : Bitmap = new Bitmap(buyingMarinesD_bd);
		buyingMarinesBitmap.x = moneyBitmap.width ;
		buyingMarinesBitmap.y = uiBitmap.y ;
		buyingMarines.addChild(buyingMarinesBitmap);
		addChild(buyingMarines);
		
		var moreMarinesBitmap : Bitmap = new Bitmap(moreUnitsD_bd);
		moreMarinesBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
		moreMarinesBitmap.y = uiBitmap.y ;
		moreMarines.addChild(moreMarinesBitmap);
		addChild(moreMarines);
			
		// Champ indiquant le nombre de marines
		var centernbMarinesWidth = moreMarinesBitmap.x + moreMarinesBitmap.width/2 ;
		var centernbMarinesHeight = uiBitmap.y + buyingMarinesBitmap.height/2 ;
		addChild (new DefaultTextField("0", centernbMarinesWidth, centernbMarinesHeight ));
		
		// Calcul de la hauteur
		var yLessMarines = uiBitmap.y + buyingMarinesBitmap.height - moreMarinesBitmap.height ;
		var lessMarinesBitmap : Bitmap = new Bitmap(lessUnitsD_bd);
		lessMarinesBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
		lessMarinesBitmap.y = yLessMarines ;
		lessMarines.addChild(lessMarinesBitmap);
		addChild(lessMarines);
		
		// Champ pour le cout des marines
		var marinesCostBitmap : Bitmap = new Bitmap(unitCostD_bd);
		marinesCostBitmap.x = moreMarinesBitmap.x + moreMarinesBitmap.width;
		marinesCostBitmap.y = uiBitmap.y ;
		marinesCost.addChild(marinesCostBitmap);
		addChild(marinesCost);
		
		var buyingBombsBitmap : Bitmap = new Bitmap(buyingBombsD_bd);
		buyingBombsBitmap.x = moneyBitmap.width ;
		buyingBombsBitmap.y = uiBitmap.y + buyingMarinesBitmap.height ;
		buyingBombs.addChild(buyingBombsBitmap);
		addChild(buyingBombs);
		
		var moreBombsBitmap : Bitmap = new Bitmap(moreUnitsD_bd);
		moreBombsBitmap.x = moneyBitmap.width + buyingBombsBitmap.width ;
		moreBombsBitmap.y = uiBitmap.y + buyingMarinesBitmap.height ;
		moreBombs.addChild(moreBombsBitmap);
		addChild(moreBombs);
		
		// Calcul de la hauteur
		var yLessBombs = uiBitmap.y + buyingMarinesBitmap.height + buyingMarinesBitmap.height - moreMarinesBitmap.height ;
		var lessBombsBitmap : Bitmap = new Bitmap(lessUnitsD_bd);
		lessBombsBitmap.x = moneyBitmap.width + buyingMarinesBitmap.width ;
		lessBombsBitmap.y = yLessBombs ;
		lessBombs.addChild(lessBombsBitmap);
		addChild(lessBombs);
		
		// Champ indiquant le nombre de bombes
		var centernbBombsWidth = moreBombsBitmap.x + moreBombsBitmap.width/2 ;
		var centernbBombsHeight = uiBitmap.y + buyingMarinesBitmap.height + buyingBombsBitmap.height/2 ;
		addChild (new DefaultTextField("0", centernbBombsWidth, centernbBombsHeight ));
		
		// Champ pour le cout des bombes
		var bombsCostBitmap : Bitmap = new Bitmap(unitCostD_bd);
		bombsCostBitmap.x = moreBombsBitmap.x + moreBombsBitmap.width;
		bombsCostBitmap.y = uiBitmap.y + buyingMarinesBitmap.height  ;
		bombsCost.addChild(bombsCostBitmap);
		addChild(bombsCost);
		
		// Button to switch to attack phase
		var buttonSwitchToAttack : ButtonDeployEnd = new ButtonDeployEnd(this);
		buttonSwitchToAttack.x = bombsCostBitmap.x + bombsCostBitmap.width ;
		buttonSwitchToAttack.y = uiBitmap.y ;
		addChild(buttonSwitchToAttack);
	}



	// ---------------------------------------------------------------------------
	// ATTACK PHASE
	// ---------------------------------------------------------------------------
	
	private function playAttackPhase()
	{
		// clear all dudes
		GameObjectManager.purgeAll();
		
		// clear UI
		while (numChildren > 0) this.removeChildAt(0);
		
		// new Layout
		var mapBitmap : Bitmap = new Bitmap(mapA_bd) ;
		var uiBitmap : Bitmap = new Bitmap(uiA_bd) ;
		var timelineBitmap : Bitmap = new Bitmap(timelineA_bd) ;
		mapBitmap.x = 12 ;
		uiBitmap.x = 12 ;
		timelineBitmap.x = 12 ;
		mapBitmap.y = 12 ;
		timelineBitmap.y = mapBitmap.height + 12 ;
		uiBitmap.y = mapBitmap.height + timelineBitmap.height + 12;
		map.addChild(mapBitmap);
		ui.addChild(uiBitmap);
		timeline.addChild(timelineBitmap);
		addChild(map);
		addChild(ui);
		addChild(timeline);

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
}