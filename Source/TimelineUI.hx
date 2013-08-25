import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import openfl.Assets;

class TimelineUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;

	public function new()
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/TimelineBG_01.png");
			initialised = true;
		}
		
		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);
		
		addChild(new Bitmap(bitmapData));
	}
	
	public function update()
	{
		
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		trace("cliked on timeline");
    }
}