import flash.display.BitmapData;

class NukeType extends UnitType 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new() : Void 
	{
		super();
		this.price = 50;
		this.icon = Assets.getBitmapData("assets/GUI_ic_bombe_01.png");
		this.mouseOverText = "Bombs rock !";
	}
}