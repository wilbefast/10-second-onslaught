import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

class Colony extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var sheet : Spritesheet;

	private static function init() : Void
	{
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/building.png"), 4, 2, 80, 120);
		sheet.addBehavior(new BehaviorData("sparkle", [0, 1, 2, 3, 4, 5, 6], true, 1));
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;

	private static inline var HITPOINTS : Int = 200;
	private static inline var RADIUS : Int = 32;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_CIVILLIANS;
		immobile = true;

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("sparkle");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;
		animated.currentFrameIndex = Math.floor(Math.random()*6);
		addChild(animated);
	}

	public override function update(dt : Float)
	{
		super.update(dt);

		animated.update(cast(dt*1000, Int));
	}
}
