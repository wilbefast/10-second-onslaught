import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import openfl.Assets;

class MapUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;
	
	private var session : Session ;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/GabariPlateau_01.png");
			initialised = true;
		}
		
		addChild(new Bitmap(bitmapData));
		
		session = scene.getSession();
		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);
	}
	
	public function update()
	{
		
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		trace("X : " + event.localX + " Y : " + event.localY);
	}
}