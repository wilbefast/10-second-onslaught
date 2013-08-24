import flash.display.BitmapData;
import haxe.ds.StringMap;

class UnitType
{
	public var price : Int;
	public var icon : BitmapData;
	
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	
	public function new (_price : Int, _icon : BitmapData) : Void
	{
		price = _price;
		icon = _icon;
	}
}