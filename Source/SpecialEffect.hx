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

	public function new(_x : Float, _y : Float, sheet : Spritesheet, behaviourName : String) : Void
	{
		super(_x, _y);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior(behaviourName);
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

		// destroy at end of animation
		if(animated.currentFrameIndex == animated.currentBehavior.frames.length-1)
			this.purge = true;
	}
}