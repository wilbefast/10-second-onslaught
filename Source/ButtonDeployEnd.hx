import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import openfl.Assets;

class ButtonDeployEnd extends Sprite
{
	private static var container_bd : BitmapData;
    private static var initialised : Bool = false;
	private var gameScene : GameScene ;
	
	private static function init() : Void
    {
        container_bd = Assets.getBitmapData("assets/ButtonGo_01.png");
        initialised = true;
    }
	
    public function new (pgameScene : GameScene)
    {
        super();
        if(!initialised) init();

		gameScene = pgameScene ;
		
        // register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);

        // container
        addChild(new Bitmap(container_bd));
        
		// for mouse hovering -- in Flash this will change the cursor icon
        this.buttonMode = true;
    }
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		trace("cliked on button to attack");
        gameScene.switchPhase();
    }
}