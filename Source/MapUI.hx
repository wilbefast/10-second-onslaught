import openfl.Assets;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.MouseEvent;

import hacksaw.GameObjectManager;

class MapUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;
	
	private var session : Session ;
	private var bitmap : Bitmap;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/GabariPlateau_01.png");
			initialised = true;
		}
		
		addChild(bitmap = new Bitmap(bitmapData));
		
		session = scene.getSession();
		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);
	}

	public function recalculateLayout()
	{
		bitmap.width = stage.stageWidth;
		bitmap.height = stage.stageHeight;
		
		// game objects
		GameObjectManager.setCameraPosition(stage.stageWidth/2, stage.stageHeight/2);
		GameObjectManager.setCameraZoom(stage.stageWidth / 1280, 
																		stage.stageHeight / 800);
		
	}
	
	public function update()
	{
		
	}
	
	private function onMouseClick(event : MouseEvent) : Void
  {
	}
}