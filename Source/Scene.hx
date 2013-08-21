import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Scene extends Sprite 
{
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

	public function onEnter(previous : Scene) : Void 
	{
		// override me !
	}

	public function onExit(next : Scene) : Void 
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public function onResize(event : Event) : Void
	{
		// override me !
	}

	public function onFrameEnter(event : Event) : Void
	{
		// override me !
	}
	
	public function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}