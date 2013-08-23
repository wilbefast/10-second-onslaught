import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;

class Button extends Sprite
{

	private static var container_bd : BitmapData;
    private static var initialised : Bool = false;
	
	private var container : Sprite;
	
	private static function init() : Void
    {
		container_bd = Assets.getBitmapData("assets/button.png");
		
		initialised = true ;
	}
	
	public function new() 
	{
		super();
        if(!initialised) init();
		this.addEventListener(MouseEvent.CLICK, onMouseClick);
		
		// container
        container = new Sprite();
        container.addChild(new Bitmap(container_bd));
		
		addChild(container);
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
       
    }
}