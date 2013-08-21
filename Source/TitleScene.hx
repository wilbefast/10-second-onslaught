import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class TitleScene extends GameScene 
{
	public function new () 
	{
		super ();
	}

	// ---------------------------------------------------------------------------
	// SCENE SWITCHING
	// ---------------------------------------------------------------------------

	public override function isRequestingSceneChange() : Bool
	{
		// override me !
		return false;
	}

	public override function getNextSceneName() : String
	{
		// override me !
		return "";
	}

	// ---------------------------------------------------------------------------
	// HAXE EVENTS
	// ---------------------------------------------------------------------------

	public override function onResize(event : Event) : Void
	{
		// override me !
	}

	public override function onUpdate(dt : Float) : Void
	{
		// override me !
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}