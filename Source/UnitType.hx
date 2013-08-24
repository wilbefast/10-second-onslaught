import flash.display.BitmapData;

class UnitType
{
	private var instanceNumber : Int;
	private var price : Int;
	private var icon : BitmapData;
	private var mouseOverText : String;
	
	// Units
	
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
		return marineCount;
	}
	
	public function getNukeCount() : Int
	{
		return nukeCount;
	}
	
	public function getZergCount() : Int
	{
		return zergCount;
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