package units;

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
			Assets.getBitmapData("assets/icon_marine_plus.png"), 
			Assets.getBitmapData("assets/icon_marine_minus.png"), 
			Assets.getBitmapData("assets/marine_ghost.png"), 
			function(_x, _y) return new Marine(_x, _y));
		nuke = new UnitType(
			200, 
			Assets.getBitmapData("assets/icon_nuke_plus.png"), 
			Assets.getBitmapData("assets/icon_nuke_minus.png"), 
			Assets.getBitmapData("assets/bombe_ghost.png"), 
			function(_x, _y) return new Nuke(_x, _y));
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public var price : Int;
	public var icon : BitmapData;
	public var icon_cancel : BitmapData;
	public var placeholder : BitmapData;
	public var factory : Float->Float->Unit;

	public function new (
		_price : Int, 
		_icon : BitmapData, 
		_icon_cancel : BitmapData,
		_placeholder : BitmapData, 
		_factory : Float->Float->Unit)
	{
		price = _price;
		icon = _icon;
		icon_cancel = _icon_cancel;
		placeholder = _placeholder;
		factory = _factory;
	}
	
	// ---------------------------------------------------------------------------
	// INSTANTIATE
	// ---------------------------------------------------------------------------
		
	public function instantiate(destX : Float, destY : Float) : Unit
	{
		return factory(destX, destY);
	}
}