import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

class Main extends Sprite
{

	private static var timer : Int = 10 ;
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super();

		DefaultFont.load();

		SceneManager.add("Title", new TitleScene());
		SceneManager.add("Game", new GameScene(timer));
	}
}