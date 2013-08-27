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
	private static var initialised : Bool = false;
	private static var background_bd : BitmapData;

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var text : TextField;
	private var background : Bitmap;

	public function new () 
	{
		super ();

		if(!initialised)
		{
			background_bd = Assets.getBitmapData("assets/start_screen.jpg");
			initialised = true;
		}

		background = new Bitmap(background_bd);
		addChild(background);

		text = new StarWarsTextField(

			"The year is 4241...\n\n\n"

			+ "20 years ago an alien attack wiped out "

			+ "all life on our home planet IN UNDER 10 SECONDS.\n\n"

			+ "Now at last we have invented a machine to take us back to "

			+ "this most fateful moment.\n\n"

			+ "At last it is time to CHANGE THE PAST: send your SOLDIERS and ORDANANCE back in time "

			+ "to DEFEND THE MOTHERPLANET.\n\n"

			+ "PROTECT OUR MONUMENTS to inspire the people of the future to greater acts of heroism.\n\n"

			+ "The more monuments you save the MORE RESOURCES you will have next time!\n\n"

			+ "Good luck comrade.\n\n\nWe will be watching..."
			);

		addChild(text);
	}

	public function recalculateLayout() : Void
	{
		// title
		background.width = stage.stageWidth;
		background.height = stage.stageHeight;

		// text 
		text.height = stage.stageHeight*1.2;
		text.width = stage.stageWidth*0.6;
		text.x = (stage.stageWidth - text.width)/2;
		text.y = stage.stageHeight;
	}
	
	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------
	
	public override function onEnter(previous : Scene) : Void 
	{
		recalculateLayout();
		Actuate.tween(text, 140, { y : -text.height }, true);
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onResize(event : Event) : Void
	{
		recalculateLayout();
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Game");
	}
}