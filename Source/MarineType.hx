import flash.display.BitmapData;

public class MarineType extends UnitType
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new() : Void 
	{
		super();
		this.price = 30;
		this.icon = Assets.getBitmapData("assets/GUI_ic_marine_01.png");
		this.mouseOverText = "Marines are on fire !";
	}	
}