import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class GameScene extends Sprite 
{
	public function new () 
	{
		super ();
	}

	// ---------------------------------------------------------------------------
	// SCENE SWITCHING
	// ---------------------------------------------------------------------------

	public function onEnter() : Void 
	{
		// override me !
	}


	public function isRequestingSceneChange() : Bool
	{
		// override me !
		return false;
	}

	public function getNextSceneName() : String // name of scene to switch to
	{
		// override me !
		return "";
	}

	public function onExit() : Void 
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// HAXE EVENTS
	// ---------------------------------------------------------------------------

	public function onResize(event : Event) : Void
	{
		// override me !
	}

	public function onUpdate(dt : Float) : Void
	{
		// override me !
	}
	
	public function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}