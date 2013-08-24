import openfl.Assets;
import flash.display.Bitmap;
import flash.geom.Rectangle;
import flash.display.BitmapData;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

import flash.media.Sound;

class NukeExplosion extends GameObject
{
	public function new(_x : Float, _y : Float)
	{
		super(_x, _y, 48);

		graphics.beginFill(0xFF0000);
		graphics.drawCircle(0, 0, radius);
	}

	public var timer : Float = 0.5;

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		timer -= dt;
		if(timer < 0)
			purge = true;
	}

	public override function onCollisionWith(other : GameObject) : Void
	{
		if(Std.is(other, Unit))
		{
			var unit : Unit = cast(other, Unit);
			unit.hitpoints -= Math.floor(100*Time.getDelta());
		}
	}

}

class Nuke extends Unit 
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
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/bomb.png"), 1, 1, 48, 67);
		sheet.addBehavior(new BehaviorData("idle", [0], true, 10));

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;
	private var shadow : Bitmap;

	private static inline var HITPOINTS : Int = 40;
	private static inline var RADIUS : Int = 16;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_MARINES;

		shadow = new Bitmap(Unit.shadow_data);
		shadow.x = -shadow.width/2;
		addChild(shadow);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("idle");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;

		addChild(animated);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public var timer : Float = 2;

	public var exploded : Bool = false;

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		timer -= dt;
		if(timer < 0 && !purge)
		{
			new NukeExplosion(x, y);
			purge = true;
			exploded = true;
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
		if(exploded)
		{
			// TODO
		}	
		else
		{
			// TODO
		}
	}
}
