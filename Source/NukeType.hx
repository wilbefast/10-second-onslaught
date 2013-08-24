import flash.display.BitmapData;

class NukeType extends UnitType 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new() : Void 
	{
		super();
		byName.set("nuke", this);
		this.price = 50;
		this.icon = Assets.getBitmapData("assets/GUI_ic_bombe_01.png");
		this.mouseOverText = "Bombs rock !";
	}
	
	public function getCount() : Int
	{
		super();
		return nukeCount;
	}
	
	public function increment() : Void
	{
		super();
		nukeCount = nukeCount + 1;
	}
}