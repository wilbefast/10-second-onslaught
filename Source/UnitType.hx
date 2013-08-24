import flash.display.BitmapData;
import haxe.ds.StringMap;

class UnitType
{
	private var instanceNumber : Int;
	private var price : Int;
	private var icon : BitmapData;
	private var mouseOverText : String;
	
	public static var byName : StringMap<UnitType>;
	
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	
	public function new () : Void
	{
		
	}
	
	// ---------------------------------------------------------------------------
	// ACCESSORS
	// ---------------------------------------------------------------------------

	public function getPrice() : Int
	{
		return price;
	}
	
	public function getIcon() : BitmapData
	{
		return icon;
	}
	
	public function getMouseOverText() : String
	{
		return mouseOverText;
	}
	
	// ---------------------------------------------------------------------------
	// OTHER METHOD
	// ---------------------------------------------------------------------------

	public function increment() : Void
	{
		instanceNumber++;
	}

	public function decrement() : Void
	{
		instanceNumber--;
	}
}