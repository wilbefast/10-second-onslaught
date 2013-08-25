import openfl.Assets;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.display.BitmapData;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

import flash.media.Sound;

class PlasmaGun extends UnitWeapon
{
	public function new()
	{
		super(128, 1, function(u) u.hitpoints -= 10);
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
		// ---------------------------------------------------------------------------
		// ASSETS

		sheet = BitmapImporter.create(Assets.getBitmapData("assets/marine.png"), 10, 6, 48, 48);

		sheet.addBehavior(new BehaviorData("NW_idle", [0], true, 10));
		sheet.addBehavior(new BehaviorData("NW_shoot", [1, 2, 3, 4], true, 10));

		sheet.addBehavior(new BehaviorData("NE_idle", [5], true, 10));
		sheet.addBehavior(new BehaviorData("NE_shoot", [6, 7, 8, 9], true, 10));

		sheet.addBehavior(new BehaviorData("N_idle", [10], true, 10));
		sheet.addBehavior(new BehaviorData("N_shoot", [11, 12, 13, 14], true, 10));

		//! flipped north is not used

		sheet.addBehavior(new BehaviorData("SW_idle", [20], true, 10));
		sheet.addBehavior(new BehaviorData("SW_shoot", [21, 22, 23, 24], true, 10));

		sheet.addBehavior(new BehaviorData("SE_idle", [25], true, 10));
		sheet.addBehavior(new BehaviorData("SE_shoot", [26, 27, 28, 29], true, 10));

		sheet.addBehavior(new BehaviorData("S_idle", [30], true, 10));
		sheet.addBehavior(new BehaviorData("S_shoot", [31, 32, 33, 34], true, 10));

		//! flipped south is not used

		sheet.addBehavior(new BehaviorData("W_idle", [40], true, 10));
		sheet.addBehavior(new BehaviorData("W_shoot", [41, 42, 43, 44], true, 10));

		sheet.addBehavior(new BehaviorData("E_idle", [45], true, 10));
		sheet.addBehavior(new BehaviorData("E_shoot", [46, 47, 48, 49], true, 10));

		sheet.addBehavior(new BehaviorData("die", [50, 51, 52, 53, 54], false, 10));

		//! flipped die is not used

		SoundManager.loadSound("marine_die");
		SoundManager.loadSound("marine_shoot");

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
		animated.showBehavior("S_idle");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;

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
			var targetDistance = toTarget.getNorm() - radius - target.radius;
			
			// face target ...
			var facing = Facing.which(toTarget);

			// attack target
			if(weapon.timeTillReloaded == 0)
			{
				if(targetDistance <= weapon.range)
				{
					animated.showBehavior(facing + "_shoot");
					weapon.fireAt(target);
					SoundManager.playSound("marine_shoot");
				}
				else
					animated.showBehavior(facing + "_idle");
			}
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
		// create gibs
		new SpecialEffect(x, y, sheet, "die");

		// play sound
		SoundManager.playSound("marine_die");
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
