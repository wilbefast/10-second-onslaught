import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

class SpecialEffect extends GameObject
{

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;

	private var timer : Float;

	public function new(_x : Float, _y : Float, sheet : Spritesheet, behaviourName : String,
											 offx : Float = 0, offy : Float = 0) : Void
	{
		super(_x, _y);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior(behaviourName);
		animated.x = -animated.width/2 + offx;
		animated.y = -animated.height/2 + offy;
		addChild(animated);

		timer = (cast(animated.currentBehavior.frames.length, Float) / sheet.behaviors[behaviourName].frameRate);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		// update animation
		animated.update(cast(dt*1000, Int));

		// destroy at end of animation
		timer -= dt;
		if((timer < 0) || (animated.currentFrameIndex == animated.currentBehavior.frames.length-1))
			purge = true;
	}
}