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

	private static var snd_die : Sound;
	private static var snd_attack : Sound;

	private static function init() : Void
	{
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/marine.png"), 5, 6, 48, 48);
		sheet.addBehavior(new BehaviorData("NW_idle", [0], true, 10));
		sheet.addBehavior(new BehaviorData("NW_shoot", [1, 2, 3, 4], true, 10));
		sheet.addBehavior(new BehaviorData("N_idle", [5], true, 10));
		sheet.addBehavior(new BehaviorData("N_shoot", [6, 7, 8, 9], true, 10));
		sheet.addBehavior(new BehaviorData("SW_idle", [10], true, 10));
		sheet.addBehavior(new BehaviorData("SW_shoot", [11, 12, 13, 14], true, 10));
		sheet.addBehavior(new BehaviorData("S_idle", [15], true, 10));
		sheet.addBehavior(new BehaviorData("S_shoot", [16, 17, 18, 19], true, 10));
		sheet.addBehavior(new BehaviorData("W_idle", [20], true, 10));
		sheet.addBehavior(new BehaviorData("W_shoot", [21, 22, 23, 24], true, 10));
		sheet.addBehavior(new BehaviorData("die", [25, 26, 27, 28, 29], false, 10));

		snd_die = Assets.getSound ("assets/marine_die.wav");
		snd_attack = Assets.getSound ("assets/marine_shoot.wav");

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
					snd_attack.play();
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
		snd_die.play();
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
