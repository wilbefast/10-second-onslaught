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

	private static var background_data : BitmapData;
	
	private var gameScene : GameScene ;

	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GUI2_button_start.png");

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
			
		addChild(new Bitmap(background_data));
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		trace("cliked on start button");
        gameScene.switchPhase();
    }
}