import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;


class TitleScene extends Scene 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();

		// draw a shape
		graphics.beginFill(0xFF0000);
		graphics.drawRect(100, 50, 200, 200);

		addChild (new DefaultTextField("Hello title", 200, 200));


		var bink = new GameObject(300, 20, 3);
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onEnter(previous : Scene) : Void 
	{
		// override me !
	}

	public override function onExit(next : Scene) : Void 
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onResize(event : Event) : Void
	{
		// override me !
	}

	public override function onFrameEnter(event : Event) : Void
	{
		// override me !
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}