import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Scene extends Sprite 
{
	// ---------------------------------------------------------------------------
	// SCENE SWITCHING
	// ---------------------------------------------------------------------------

	private static var current : Scene;

	private static var byName : Map<String, Scene> = new Map<String, Scene>();

	public static function add(newSceneName : String, newScene : Scene)
	{
		byName[newSceneName] = newScene;
		if(current == null)
			current = newScene;
	}

	public static function start() : Void
	{
		// events
		Lib.current.stage.addEventListener(Event.RESIZE, function(event) { current.onResize(event); } );
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(event) { current.onFrameEnter(event); } );
		// mouse events
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(event) { current.onMouseClick(event); } );
	}

	public static function change(newScene : Scene) : Void
	{
		current.onExit(newScene);
		newScene.onEnter(current);

		current = newScene;
	}

	public static function changeByName(newSceneName : String) : Void
	{
		change(byName[newSceneName]);
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	private function onEnter(previous : Scene) : Void 
	{
		// override me !
	}

	private function onExit(next : Scene) : Void 
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	private function onResize(event : Event) : Void
	{
		// override me !
	}

	private function onFrameEnter(event : Event) : Void
	{
		// override me !
	}
	
	private function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}