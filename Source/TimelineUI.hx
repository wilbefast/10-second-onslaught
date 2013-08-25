import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import openfl.Assets;

class TimelineUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;
	
	private var session : Session ;
	
	private static var selectionContainer_bd : BitmapData;
	
	private var selection : Bitmap;
	
	private var slotWidth : Float ;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/TimelineBG_01.png");
			selectionContainer_bd = Assets.getBitmapData("assets/TimelineSelect_01.png");
			initialised = true;
		}
		
		selection = new Bitmap(selectionContainer_bd);
		slotWidth = width / 10 ;
		selection.x = 0 ;
	
		session = scene.getSession();
		
		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);
		
		addChild(new Bitmap(bitmapData));
		addChild(selection);
	}
	
	public function update()
	{
		
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		slotWidth = width / 10 ;
		session.setTimelineSelection( Math.round(event.localX / slotWidth) );
		trace(session.getTimelineSelection());
		selection.x = session.getTimelineSelection()* slotWidth; // session.getTimelineSelection() * width / 10 ;
		trace(width);
		trace(selection.x);
    }
}