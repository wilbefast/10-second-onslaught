import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

class DeployUI extends Sprite 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	
	private static var session_attribut : Session;

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

		background = new Bitmap(background_data);
		addChild(background);

		replaysCounter = new ReplaysCounterUI(session_attribut);
		addChild(replaysCounter);

		resourcesCounter = new ResourcesCounterUI(session_attribut);
		addChild(resourcesCounter);

		buyMarine = new BuyUI("assets/GUI_ic_marine_01.png"); // TODO - parameters
		addChild(buyMarine);

		buyNuke = new BuyUI("assets/GUI_ic_bombe_01.png"); // TODO - parameters
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