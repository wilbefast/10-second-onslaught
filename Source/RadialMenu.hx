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

	private static inline var N_OPTIONS = 2;

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

	private var icons : Array<Sprite>;

	private var onSelectOption : Int->Void;

	public function new(_onSelectOption : Int->Void)
	{
		super();

		if(!initialised)
			init();

		onSelectOption = _onSelectOption;

		icons = new Array<Sprite>();
		for (i in 0 ... N_OPTIONS)
		{
			var icon = new Sprite();
			var icon_bitmap = new Bitmap(data[i]);
			icon_bitmap.scaleX = icon_bitmap.scaleY = 1.5;
			icon_bitmap.x = -icon_bitmap.width / 2;
			icon_bitmap.y = -icon_bitmap.height / 2;
			icon.addChild(icon_bitmap);

			icon.addEventListener(MouseEvent.CLICK, function(event) {
				if(opened)
				{
					onSelectOption(i);
					close();
					event.stopPropagation();
				}
				else
					open();
		 	});

			icons[i] = icon;
			addChild(icon);
		}

		alpha = 0;
	}

	public static inline var RADIUS : Float = 48;

	// ---------------------------------------------------------------------------
	// OPEN AND CLOSE
	// ---------------------------------------------------------------------------
	
	private var opened : Bool = false;

	public function isOpened() : Bool return opened;
	
	public function open() : Void 
	{
		if (opened)
			return;
		
		Actuate.tween(this, 0.3, { alpha : 1.0 }, true)
					.ease (Quad.easeOut);

		var radians_per_options = Math.PI*2/N_OPTIONS;
		for (i in 0 ... N_OPTIONS)
		{
			var radians = radians_per_options*(i /*+ 0.5*/);
			var ox = Math.cos(radians)*RADIUS;
			var oy = Math.sin(radians)*RADIUS;
			Actuate.tween(icons[i], 0.3, { x : ox, y : oy }, true)
					.ease (Quad.easeOut);	
		}
		
		opened = true;
	}
	
	public function close() : Void
	{
		if (!opened)
			return;
		
		Actuate.tween(this, 0.3, { alpha : 0.0 }, true)
					.ease (Quad.easeOut);

		for (i in 0 ... N_OPTIONS)
			Actuate.tween(icons[i], 0.3, { x : 0, y : 0 }, true)
					.ease (Quad.easeOut);
					
		opened = false;
	}
	
	public function toggle()
	{
		if(opened)
			close();
		else
			open();
	}
}