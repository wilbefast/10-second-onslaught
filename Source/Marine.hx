import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

class PlasmaGun extends UnitWeapon
{
	public function new()
	{
		super(128, 0.1, function(u) u.hitpoints -= 1);
	}
}

class Marine extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/marine.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var bitmap : Bitmap;

	private static inline var HITPOINTS : Int = 100;
	private static inline var RADIUS : Int = 16;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_MARINES;
		weapon = new PlasmaGun();

		bitmap = new Bitmap(bitmapData);
		bitmap.x = -bitmap.width/2;
		bitmap.y = -bitmap.height*0.75;
		addChild(bitmap);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		// get new target
		if(target == null || target.purge)
			refreshTarget();

		// has target
		if(target != null)
		{
			var toTarget = new V2(target.x - x, target.y - y);

			// attack target
			if(toTarget.getNorm() - radius - target.radius <= weapon.range)
				weapon.fireAt(target);
		}
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

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
