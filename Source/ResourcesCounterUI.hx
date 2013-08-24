import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

class ResourcesCounterUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/GUI_fond_bank_01.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------


	public function new()
	{
		if(!initialised)
			init();

		super();

		addChild(new Bitmap(bitmapData));
	}
}