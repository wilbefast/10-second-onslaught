import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

class Zergling extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/zergling.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var bitmap : Bitmap;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, 16, 50); // radius, hitpoints

		if(!initialised)
			init();

		bitmap = new Bitmap(bitmapData);
		bitmap.x = -radius;
		bitmap.y = -radius;
		addChild(bitmap);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public override function onCollisionWith(other : GameObject) : Void
	{
		super.onCollisionWith(other);
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public override function onPurge() : Void
	{
	}
}
