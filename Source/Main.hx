import flash.display.Sprite;
import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;


class Main extends Sprite 
{
	// ---------------------------------------------------------------------------
	// SCENES
	// ---------------------------------------------------------------------------

	private var currentScene : GameScene;

	private var scenes : Map<String, GameScene>;

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();

		// initialise scenes
		scenes = new Map<String, GameScene>();
		scenes["Title"] = currentScene = new TitleScene();

		// initialise timer
		t_prev = Lib.getTimer();

		// REGISTER CALLBACKS
		// -------------------------------------------------------------------------
		Lib.current.stage.addEventListener(Event.RESIZE, function(event) { currentScene.onResize(event); } );
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrameEnter);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(event) { currentScene.onMouseClick(event); } );
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	private function onFrameEnter(event : Event)
	{
		// update scene
		currentScene.onUpdate(getDT());

		// change scene
		if(currentScene.isRequestingSceneChange())
		{
			var nextSceneName = currentScene.getNextSceneName();
			if (scenes.exists(nextSceneName))
			{
				var nextScene = scenes[nextSceneName];
				currentScene.onExit();
				nextScene.onEnter();
				currentScene = nextScene;
			}
			else
				trace("Invalid GameScene name '" + nextSceneName + "' returned by GameScene::getNextSceneName");
		}

	}

	// ---------------------------------------------------------------------------
	// TIMING
	// ---------------------------------------------------------------------------

	private var t_prev : Int = 0;
	private function getDT() : Float
	{
		var t = Lib.getTimer();
    var dt = (t - t_prev) * 0.001;
    t_prev = t;

    return dt;
	}
	
	
}