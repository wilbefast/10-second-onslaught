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
		sheet.addBehavior(new BehaviorData("idle", [0, 1, 2, 3, 4, 5, 6, 7], true, 10));
		sheet.addBehavior(new BehaviorData("death", [8, 9, 10, 11, 12], false, 10));
		sheet.addBehavior(new BehaviorData("dust", [13, 14, 15], true, 10));

		SoundManager.loadSound("zergling_die");
		SoundManager.loadSound("zergling_attack");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private static inline var SPEED : Float = 96;
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

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("idle");
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

		// dust trail
		// dust_timer -= dt;
		// if(dust_timer < 0)
		// {
		// 	new SpecialEffect(x, y, sheet, "dust");
		// 	dust_timer = 1 + Math.random();
		// }

		// update animation
		animated.update(cast(dt*1000, Int));

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
			else if(weapon.timeTillReloaded == 0)
			{
				weapon.fireAt(target);
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
