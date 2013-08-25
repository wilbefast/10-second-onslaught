import flash.display.BitmapData;
import haxe.ds.StringMap;
import openfl.Assets;

class UnitType
{
	// ---------------------------------------------------------------------------
	// TYPES
	// ---------------------------------------------------------------------------

	public static var marine;
	public static var nuke;

	public static function init()
	{
		marine = new UnitType(100, Assets.getBitmapData("assets/GUI_ic_marine_01.png"));
		nuke = new UnitType(200, Assets.getBitmapData("assets/GUI_ic_bombe_01.png"));
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public var price : Int;
	public var icon : BitmapData;

	public function new (_price : Int, _icon : BitmapData) : Void
	{
		price = _price;
		icon = _icon;
	}
	
	public function getCount() : Int
	{
			// override me !
			return -1;
	}
}