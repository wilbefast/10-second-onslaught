import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

class Colony extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/colony.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var bitmap : Bitmap;

	private static inline var HITPOINTS : Int = 200;
	private static inline var RADIUS : Int = 32;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, UnitType.byName.get("Colony"), RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_CIVILLIANS;
		immobile = true;

		bitmap = new Bitmap(bitmapData);
		bitmap.x = -bitmap.width/2;
		bitmap.y = -bitmap.height*0.75;
		addChild(bitmap);
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public override function onPurge() : Void
	{
	}
}
