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

	private static var icons_data : StringMap<BitmapData>;

	private static function init() : Void
	{
		icons_data = new StringMap<BitmapData>();

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
		if(!initialised)
			init();

		super();


		// Cache icons
		//var icon_data;
		//if(!icons_data.exists(icon_path))
		//{
			//icon_data = Assets.getBitmapData(icon_path);
			//icons_data.set(icon_path, icon_data);
		//}
		//else
			//icon_data = icons_data.get(icon_path);


		// Build hierarchy
		addChild(new Bitmap(background_data));

		//icon = new Sprite();
		//icon.addChild(new Bitmap(icon_data));
		icon = unitType.getIcon();
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