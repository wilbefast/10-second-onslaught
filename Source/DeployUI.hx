import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import haxe.ds.StringMap;

class DeployUI extends Sprite 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	
	private static var session_attribut : Session;
	
	private var byName : StringMap<UnitType>;
	
	private var marine1 : UnitType;
	
	private var nuke2 : UnitType;

	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GabariGUI_01.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var replaysCounter : ReplaysCounterUI;
	private var resourcesCounter : ResourcesCounterUI;
	private var buyMarine : BuyUI;
	private var buyNuke : BuyUI;
	private var startButton : StartButtonUI;

	private var background : Bitmap;

	public function new(pgameScene : GameScene)
	{
		super();
		session_attribut = pgameScene.getSession();

		if(!initialised)
			init();
			
		byName = UnitType.byName;
		marine1 = byName.get(marine);
		nuke1 = byName.get(nuke);

		background = new Bitmap(background_data);
		addChild(background);

		replaysCounter = new ReplaysCounterUI(session_attribut);
		addChild(replaysCounter);

		resourcesCounter = new ResourcesCounterUI(session_attribut);
		addChild(resourcesCounter);

		buyMarine = new BuyUI(marine); // TODO - parameters
		addChild(buyMarine);

		buyNuke = new BuyUI(nuke); // TODO - parameters
		addChild(buyNuke);

		startButton = new StartButtonUI(pgameScene);
		addChild(startButton);

		recalculateLayout();
	}

	public function update()
	{
		replaysCounter.update();
		resourcesCounter.update();
	}
	
	public function recalculateLayout() : Void
	{
		// size
		if(stage != null)
		{
			background.width = stage.stageWidth;
			
			buyMarine.width = buyNuke.width = stage.stageWidth*0.5;
			resourcesCounter.width = replaysCounter.width = stage.stageWidth*0.3;
			startButton.width = Math.min(startButton.height, stage.stageWidth*0.2);

			var rightmost = Math.max(buyMarine.x + buyMarine.width, buyNuke.x + buyNuke.width);
			startButton.x = rightmost + (stage.stageWidth - rightmost - startButton.width)/2;
		}

		// position
		resourcesCounter.y = replaysCounter.height;
		buyMarine.x = replaysCounter.width;
		buyNuke.x = resourcesCounter.width;
		buyNuke.y = buyMarine.y + buyMarine.height;
	}
}