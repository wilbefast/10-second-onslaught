import flash.display.BitmapData;

public class ZergType extends UnitType
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new() : Void 
	{
		super();
		this.price = 0;
		this.mouseOverText = "Zergs look like balls !";
	}
	
	public function getCount() : Int 
	{
		super();
		return zergCount;
	}

	public function increment() : Void
	{
			super();
			zergCount = zergCount + 1;
	}
}