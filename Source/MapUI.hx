import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;

class MapUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;

	public function new()
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/GabariPlateau_01.png");
			initialised = true;
		}

		addChild(new Bitmap(bitmapData));
	}
}