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
		super(_x, _y, 16);

		if(!initialised)
			init();

		hitpoints = 30;
		team = Unit.TEAM_ALIENS;

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
		super.update(dt);
		
		if(target == null || target.purge)
			refreshTarget();
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public override function onCollisionWith(other : GameObject) : Void
	{
		super.onCollisionWith(other);
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_MARINES || other.team == Unit.TEAM_CIVILLIANS);
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public override function onPurge() : Void
	{
	}
}
