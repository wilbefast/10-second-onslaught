import flash.Lib;
import flash.events.Event;
import flash.events.MouseEvent;

class SceneManager
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{ 
		byName = new Map<String, Scene>();
		// events
		Lib.current.stage.addEventListener(Event.RESIZE, function(event) { current.onResize(event); } );
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(event) { current.onFrameEnter(event); } );
		// mouse events
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(event) { current.onMouseClick(event); } );
	}

	private static var instance : SceneManager;

	private static function get()
	{
		if(instance == null)
			instance = new SceneManager();
		return instance;
	}

	// shortcut static functions

	public static function setScene(newScene : Scene) : Void
	{
		get().__setScene(newScene);
	}

	public static function setSceneByName(newSceneName : String) : Void
	{
		get().__setSceneByName(newSceneName);
	}


	public static function add(newSceneName : String, newScene : Scene)
	{
		return get().__add(newSceneName, newScene);
	}


	// ---------------------------------------------------------------------------
	// SCENE SWITCHING
	// ---------------------------------------------------------------------------

	private var current : Scene;

	private function __setScene(newScene : Scene) : Void
	{
		current.onExit(newScene);
		newScene.onEnter(current);

		current = newScene;
	}

	private function __setSceneByName(newSceneName : String) : Void
	{
		setScene(byName[newSceneName]);
	}

	// ---------------------------------------------------------------------------
	// SCENES BY NAME
	// ---------------------------------------------------------------------------

	private var byName : Map<String, Scene>;

	private function __add(newSceneName : String, newScene : Scene)
	{
		byName[newSceneName] = newScene;
		if(current == null)
			current = newScene;
	}
}