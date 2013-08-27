import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;

class VictoryScene extends Scene
{

	private static var bitmapData : BitmapData; 
	private static var initialised = false;
	
	public function new() 
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/vicoty_screen.jpg");
			initialised = true;
		}
		
		var bitmap = new Bitmap(bitmapData) ;
		addChild(bitmap);
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Title");
	}

	public override function onEnter(previous : Scene)
	{
		width = stage.stageWidth ;
		height = stage.stageHeight ;
	}
}