import flash.events.MouseEvent;

class VictoryScene extends Scene
{

	public function new() 
	{
		super ();
		addChild (new DefaultTextField("Victory", 200, 200));
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Game");
	}
}