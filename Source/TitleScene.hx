import flash.Lib;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

import motion.Actuate;

class TitleScene extends Scene 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var text : TextField;

	public function new () 
	{
		super ();

		text = new StarWarsTextField(

			"The year is 4241...\n\n\n"

			+ "20 years ago an alien attack wiped out "

			+ "all life on our home planet in under 10 seconds.\n\n"

			+ "Now at last we have invented a machine to take us back to "

			+ "this most fateful moment.\n\n"

			+ "At last it is time to change the past: send your soldiers and ordanance back in time "

			+ "to defend the Motherplanet.\n\n"

			+ "Good luck comrade.\n\n\nWe will be watching..."
			);

		addChild(text);
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onEnter(previous : Scene) : Void 
	{
		text.height = stage.stageHeight*0.8;
		text.width = stage.stageWidth*0.6;
		text.x = (stage.stageWidth - text.width)/2;
		text.y = stage.stageHeight;

		Actuate.tween(text, 100, { y : -text.height }, true);
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