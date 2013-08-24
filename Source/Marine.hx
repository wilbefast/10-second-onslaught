import openfl.Assets;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.display.BitmapData;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

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

	private static var sheet : Spritesheet;

	private static function init() : Void
	{
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/marine.png"), 5, 2, 48, 48);
		sheet.addBehavior(new BehaviorData("idle", [0], true, 10));
		sheet.addBehavior(new BehaviorData("shoot", [1, 2], true, 3));
		sheet.addBehavior(new BehaviorData("death", [5, 6, 7, 8, 9], true, 10));

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;

	private static inline var HITPOINTS : Int = 100;
	private static inline var RADIUS : Int = 16;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_MARINES;
		weapon = new PlasmaGun();

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("idle");
		animated.x = -animated.width/2;
		animated.y = -animated.height/2;
		addChild(animated);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		// update animation
		animated.update(cast(dt*1000, Int));

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
		new SpecialEffect(x, y, sheet, "death");
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
