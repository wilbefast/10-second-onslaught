import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;


class EvacuateScene extends Scene 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();

		// draw a shape
		graphics.beginFill(0x00FF00);
		graphics.drawRect(100, 50, 200, 200);

		addChild (new DefaultTextField("Save the colonies!", 200, 200));
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onEnter(previous : Scene) : Void 
	{
	}

	public override function onExit(next : Scene) : Void 
	{
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onResize(event : Event) : Void
	{
	}

	public override function onFrameEnter(event : Event) : Void
	{
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Deploy");
	}
}