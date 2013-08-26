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
		marine = new UnitType(
			100, 
			Assets.getBitmapData("assets/GUI_ic_marine_01.png"), 
			function(_x, _y) return new Marine(_x, _y));
		nuke = new UnitType(
			200, 
			Assets.getBitmapData("assets/GUI_ic_bombe_01.png"), 
			function(_x, _y) return new Nuke(_x, _y));
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public var price : Int;
	public var icon : BitmapData;
	public var factory : Float->Float->Unit;

	public function new (_price : Int, _icon : BitmapData, _factory : Float->Float->Unit) : Void
	{
		price = _price;
		icon = _icon;
		factory = _factory;
	}
	
	public function getCount() : Int
	{
			// override me !
			return -1;
	}
	
	// ---------------------------------------------------------------------------
	// INSTANTIATE
	// ---------------------------------------------------------------------------
		
	public function instantiate(destX : Float, destY : Float) : Unit
	{
		return factory(destX, destY);
	}
}