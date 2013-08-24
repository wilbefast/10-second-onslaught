import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

import flash.media.Sound;

class ZerglingClaws extends UnitWeapon
{
	public function new()
	{
		super(16, 0.5, function(u) u.hitpoints -= 10);
	}
}

class Zergling extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var sheet : Spritesheet;

	private static function init() : Void
	{
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/zergling.png"), 8, 2, 48, 48);
		sheet.addBehavior(new BehaviorData("walk_NE", [0, 1], true, 10));
		sheet.addBehavior(new BehaviorData("bite_NE", [3, 2], false, 10));

		sheet.addBehavior(new BehaviorData("walk_NW", [4, 5], true, 10));
		sheet.addBehavior(new BehaviorData("bite_NW", [7, 6], false, 10));

		sheet.addBehavior(new BehaviorData("walk_N", [8, 9], true, 10));
		sheet.addBehavior(new BehaviorData("bite_N", [11, 10], false, 10));

		sheet.addBehavior(new BehaviorData("walk_SE", [16, 17], true, 10));
		sheet.addBehavior(new BehaviorData("bite_SE", [19, 18], false, 10));

		sheet.addBehavior(new BehaviorData("walk_SW", [20, 21], true, 10));
		sheet.addBehavior(new BehaviorData("bite_SW", [23, 22], false, 10));

		sheet.addBehavior(new BehaviorData("walk_S", [24, 25], true, 10));
		sheet.addBehavior(new BehaviorData("bite_S", [27, 26], false, 10));

		sheet.addBehavior(new BehaviorData("walk_E", [32, 33], true, 10));
		sheet.addBehavior(new BehaviorData("bite_E", [35, 34], false, 10));

		sheet.addBehavior(new BehaviorData("walk_W", [36, 37], true, 10));
		sheet.addBehavior(new BehaviorData("bite_W", [39, 38], false, 10));

		SoundManager.loadSound("zergling_die");
		SoundManager.loadSound("zergling_attack");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private static inline var SPEED : Float = 128;
	private static inline var HITPOINTS : Int = 30;
	private static inline var RADIUS : Int = 16;

	private var animated : AnimatedSprite;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_ALIENS;
		weapon = new ZerglingClaws();

		var shadow = new Bitmap(Unit.shadow_data);
		shadow.x = -shadow.width/2;
		addChild(shadow);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("walk_S");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;
		addChild(animated);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	private var dust_timer : Float = 0;

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
			var toTargetNormalised = toTarget.normalised();

			// face target ...
			var facing = Facing.which(toTargetNormalised);

			// move towards target
			if(toTarget.getNorm() - radius - target.radius > weapon.range)
			{
				x += toTargetNormalised.x * Time.getDelta() * SPEED;
				y += toTargetNormalised.y * Time.getDelta() * SPEED;

				animated.showBehavior("walk_NE");
				//animated.showBehavior(facing + "_move");
			}

			// attack target
			else if(weapon.timeTillReloaded == 0)
			{
				weapon.fireAt(target);

				//animated.showBehavior(facing + "_bite");

				SoundManager.playSound("zergling_attack");
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
		// create gibs
		new SpecialEffect(x, y-1, sheet, "death");

		// play sound
		SoundManager.playSound("zergling_die");
	}
}
