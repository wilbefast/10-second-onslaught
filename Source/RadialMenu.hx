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

	private static inline var N_OPTIONS = 3;

	private static var data : Array<BitmapData>; 

	private static var initialised : Bool = false;

	private function init()
	{
		data = new Array<BitmapData>();
		for (i in 0 ... N_OPTIONS)
			data[i] = Assets.getBitmapData("assets/radial_menu_" + i + ".png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var icons : Array<Bitmap>;

	public function new()
	{
		super();

		if(!initialised)
			init();

		icons = new Array<Bitmap>();
		for (i in 0 ... N_OPTIONS)
		{
			icons[i] = new Bitmap(data[i]);
			addChild(icons[i]);
		}

		alpha = 0;
	}

	private var open : Bool = false;

	public function isOpen() : Bool return open;

	public static inline var RADIUS : Float = 64;

	public function toggle()
	{
		if(open)
		{
			Actuate.tween(this, 0.3, { alpha : 0.0 }, true)
						.ease (Quad.easeOut);

			for (i in 0 ... N_OPTIONS)
				Actuate.tween(icons[i], 0.3, { x : 0, y : 0 }, true)
						.ease (Quad.easeOut);
		}
		else
		{		
			Actuate.tween(this, 0.3, { alpha : 1.0 }, true)
						.ease (Quad.easeOut);

			var radians_per_options = Math.PI*2/N_OPTIONS;
			for (i in 0 ... N_OPTIONS)
			{
				var radians = radians_per_options*(i + 0.5);
				var ox = Math.cos(radians)*RADIUS;
				var oy = Math.sin(radians)*RADIUS;
				Actuate.tween(icons[i], 0.3, { x : ox, y : oy }, true)
						.ease (Quad.easeOut);	
			}
		}
		open = !open;
	}
}