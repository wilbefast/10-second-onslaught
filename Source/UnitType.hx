import flash.display.BitmapData;
import haxe.ds.StringMap;

class UnitType extends Unit
{
	private var instanceNumber : Int;
	private var price : Int;
	private var icon : BitmapData;
	private var mouseOverText : String;
	
	public static var byName : StringMap<UnitType> ;
	
	//Units
	
	private var marineCount : Int;
	private var nukeCount : Int;
	private var zergCount : Int;
	
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
	
	public function getMarineCount() : Int
	{
		
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
		
	}
}