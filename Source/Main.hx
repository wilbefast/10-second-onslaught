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
		super ();

		// initialise modules
		Scene.add("Title", new TitleScene());

		// start modules
		Time.start();
		Scene.start();
	}
}