import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

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
		
		var text = new StarWarsTextField("She strutted into my office wearing a"
			+ " dress that clung to her like Saran Wrap to a sloppily butchered pork knuckle,"
			+ " bone and sinew jutting and lurching asymmetrically beneath its folds, the tightness"
			+ " exaggerating the granularity of the suet and causing what little palatable meat there"
			+ " was to sweat, its transparency the thief of imagination.");

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
		SceneManager.setScene("Game");
	}
}