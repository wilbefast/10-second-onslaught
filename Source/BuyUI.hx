import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;

import haxe.ds.StringMap;

class BuyUI extends Sprite
{
	
private var marine : UnitType;
private var nuke : UnitType;
	
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	private static var up_data : BitmapData;
	private static var down_data : BitmapData;
	
	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GUI_fond_achat_01.png");

		up_data = Assets.getBitmapData("assets/GUI_button_up_01.png");
		down_data = Assets.getBitmapData("assets/GUI_button_down_01.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var icon : Sprite;
	private var up : Sprite;
	private var down : Sprite;

	public function new(unitType : UnitType)
	{
		super();

		if(!initialised)
			init();

		// Build hierarchy
		addChild(new Bitmap(background_data));

		icon = new Sprite();
		icon.addChild(new Bitmap(unitType.icon));
		addChild(icon);

		up = new Sprite();
		up.addChild(new Bitmap(up_data));
		up.x = icon.x + icon.width;
		up.y = icon.y;
		addChild(up);

		down = new Sprite();
		down.addChild(new Bitmap(down_data));
		down.x = icon.x + icon.width;
		down.y = icon.y + icon.height - down.height;
		addChild(down);
	}
}