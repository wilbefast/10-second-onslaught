import flash.display.BitmapData;

public class MarineType extends UnitType
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new() : Void 
	{
		super();
		byName.set("marine", this);
		this.price = 30;
		this.icon = Assets.getBitmapData("assets/GUI_ic_marine_01.png");
		this.mouseOverText = "Marines are on fire !";
	}
	
	public override function getCount() : Int
	{
		return marineCount;
	}
	
	public function increment() : Void
	{
		super();
		marineCount = marineCount + 1;
	}
}