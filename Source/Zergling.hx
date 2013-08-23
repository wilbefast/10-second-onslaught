import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

class ZerglingClaws extends UnitWeapon
{
	public function new()
	{
		super(16, 1, function(u) u.hitpoints -= 10);
	}
}

class Zergling extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;

	private static var claws : UnitWeapon;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/zergling.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private static inline var SPEED : Float = 96;
	private static inline var HITPOINTS : Int = 30;
	private static inline var RADIUS : Int = 16;

	private var bitmap : Bitmap;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_ALIENS;
		weapon = new ZerglingClaws();

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

			// move towards target
			if(toTarget.getNorm() - radius - target.radius > weapon.range)
			{
				var toTargetNormalised = toTarget.normalised();
				x += toTargetNormalised.x * Time.getDelta() * SPEED;
				y += toTargetNormalised.y * Time.getDelta() * SPEED;
			}

			// attack target
			else
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
