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

	private static var bitmapData : BitmapData;
	private static var sheet : Spritesheet;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/marine.png");

		sheet = BitmapImporter.create(Assets.getBitmapData("assets/gore.png"), 5, 1, 48, 48);
		sheet.addBehavior(new BehaviorData("boom", [0, 1, 2], true, 5));

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var bitmap : Bitmap;
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

		/*bitmap = new Bitmap(bitmapData);
		bitmap.x = -bitmap.width/2;
		bitmap.y = -bitmap.height*0.75;
		addChild(bitmap);*/

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("boom");
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
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
