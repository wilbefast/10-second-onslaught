import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class StartButtonUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;

	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/ButtonGo_01.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new()
	{
		super();

		// load resources
		if(!initialised)
			init();

		addChild(new Bitmap(background_data));
	}
}