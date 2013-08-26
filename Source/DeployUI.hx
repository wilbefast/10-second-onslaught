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

	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GabariGUI_01.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	//private var replaysCounter : ReplaysCounterUI;
	private var resourcesCounter : ResourcesCounterUI;
	private var startButton : StartButtonUI;

	public function new(pgameScene : GameScene)
	{
		super();
		session_attribut = pgameScene.getSession();

		if(!initialised)
			init();

		//replaysCounter = new ReplaysCounterUI(session_attribut);
		//addChild(replaysCounter);

		resourcesCounter = new ResourcesCounterUI(session_attribut);
		addChild(resourcesCounter);

		startButton = new StartButtonUI(pgameScene);
		addChild(startButton);

		recalculateLayout();
	}

	public function update()
	{
		//replaysCounter.update();
		resourcesCounter.update();
	}
	
	public function recalculateLayout() : Void
	{
		// size
		if(stage != null)
		{
			var available_height = (stage.stageHeight - y);

			//resourcesCounter.width = replaysCounter.width = stage.stageWidth*0.3;
			resourcesCounter.height = available_height*0.67;

			//replaysCounter.height = available_height*0.33;
		}

		// position
	}
}