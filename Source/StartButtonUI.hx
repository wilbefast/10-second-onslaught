import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

class StartButtonUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var start_bm : BitmapData;
	private static var stop_bm : BitmapData;
	
	private var bitmap : Bitmap;
	
	private var gameScene : GameScene ;
	
	private static inline var PHASE_DEPLOY : Int = 0;
	private static inline var PHASE_ATTACK : Int = 1;
	private var phase : Int = PHASE_DEPLOY;

	private static function init() : Void
	{
		start_bm = Assets.getBitmapData("assets/GUI2_button_start.png");
		stop_bm = Assets.getBitmapData("assets/GUI2_button_stop.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new(pgameScene : GameScene)
	{
		super();

		gameScene = pgameScene ;
		
		// load resources
		if(!initialised)
			init();

		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);	
		bitmap = new Bitmap(start_bm) ;
		addChild(bitmap);
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		trace("cliked on start button");
		if (phase == PHASE_DEPLOY)
		{
			phase = PHASE_ATTACK ;
			removeChild(bitmap);
			bitmap = new Bitmap(stop_bm) ;
			addChild(bitmap);
		}
		else 
		{
			phase = PHASE_DEPLOY;
			removeChild(bitmap);
			bitmap = new Bitmap(start_bm) ;
			addChild(bitmap);
		}
        gameScene.switchPhase();
    }
}