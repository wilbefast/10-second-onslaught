import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import openfl.Assets;

import motion.Actuate;
import motion.easing.Quad;

class TimelineUI extends Sprite 
{
	private static var background_bd : BitmapData;
	private static var selectionContainer_bd : BitmapData;
	private static var bar_bd : BitmapData;
	private static var initialised = false;
	
	private var session : Session;
	private var selection : Sprite;
	private var bar_bitmap : Bitmap;
	private var background_bitmap : Bitmap;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			background_bd = Assets.getBitmapData("assets/TimelineBG_01.png");
			selectionContainer_bd = Assets.getBitmapData("assets/TimelineSelect_01.png");
			bar_bd = Assets.getBitmapData("assets/GabariTimeline_01.png");
			
			initialised = true;
		}

		// initialise variables
		session = scene.getSession();
		
		// register callbacks
    this.addEventListener(MouseEvent.CLICK, onMouseClick);
		
		// build draw list

		// ... background
		background_bitmap = new Bitmap(background_bd);
		addChild(background_bitmap);
		
		// ... bar
		bar_bitmap = new Bitmap(bar_bd);
		bar_bitmap.alpha = 0.7;
		bar_bitmap.width = 0;
		addChild(bar_bitmap);

		// ... selection
		var selection_bitmap = new Bitmap(selectionContainer_bd);
		selection_bitmap.x = -selection_bitmap.width/2;
		selection = new Sprite();
		selection.addChild(selection_bitmap);
		addChild(selection);
	}
	
	public function update(time : Float)
	{
		var slotWidth = (stage.stageWidth-selection.width) * 0.1;
		bar_bitmap.width = selection.x = time * slotWidth;
	}
	
	private function onMouseClick(event : MouseEvent) : Void
  {
		var slotWidth = (stage.stageWidth-selection.width) * 0.1;
		session.setTimelineSelection(Math.round(event.stageX / slotWidth));

		var select_x = selection.width/2 + (session.getTimelineSelection() * slotWidth);

		Actuate.tween(selection, 0.3, { x : select_x }, true).ease (Quad.easeOut);
		Actuate.tween(bar_bitmap, 0.3, { width : select_x }, true).ease (Quad.easeOut);
  }
}