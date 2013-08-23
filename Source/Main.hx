import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Main extends Sprite
{

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super();

		DefaultFont.load();

		SceneManager.add("Title", new TitleScene());
		SceneManager.add("Deploy", new DeployScene());
		SceneManager.add("Evacuate", new EvacuateScene());
	}
}