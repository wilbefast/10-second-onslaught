import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

class RadialMenu extends Sprite
{
	// ---------------------------------------------------------------------------
	// ASSET LOADING
	// ---------------------------------------------------------------------------

	private static var marineIcon_data : BitmapData; 
	private static var nukeIcon_data : BitmapData; 
	private static var cancelIcon_data : BitmapData; 

	private static var initialised : Bool = false;

	private function init()
	{
		marineIcon_data = Assets.getBitmapData("assets/rad1.png");
		nukeIcon_data = Assets.getBitmapData("assets/rad2.png");
		cancelIcon_data = Assets.getBitmapData("assets/rad3.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var marineIcon : Bitmap;
	private var nukeIcon : Bitmap;
	private var cancelIcon : Bitmap;

	public function new()
	{
		if(!initialised)
			init();

		super();

		marineIcon = new Bitmap(marineIcon_data);
		addChild(marineIcon);

		nukeIcon = new Bitmap(nukeIcon_data);
		addChild(nukeIcon);

		cancelIcon = new Bitmap(cancelIcon_data);
		addChild(cancelIcon);

		alpha = 0;
	}

	private var open : Bool = false;

	public function isOpen() : Bool return open;

	public function toggle()
	{
		if(open)
		{
			Actuate.tween(this, 0.3, { alpha : 0.0 }, true)
						.ease (Quad.easeOut);

			Actuate.tween(marineIcon, 0.3, { x : 0 }, true)
						.ease (Quad.easeOut);

			Actuate.tween(nukeIcon, 0.3, { x : 0 }, true)
						.ease (Quad.easeOut);	

			Actuate.tween(cancelIcon, 0.3, { y : 0 }, true)
						.ease (Quad.easeOut);
		}
		else
		{		
			Actuate.tween(this, 0.3, { alpha : 1.0 }, true)
						.ease (Quad.easeOut);

			Actuate.tween(marineIcon, 0.3, { x : -32 }, true)
						.ease (Quad.easeOut);

			Actuate.tween(nukeIcon, 0.3, { x : 32 }, true)
						.ease (Quad.easeOut);	

			Actuate.tween(cancelIcon, 0.3, { y : -32 }, true)
						.ease (Quad.easeOut);
		}
		open = !open;
	}
}