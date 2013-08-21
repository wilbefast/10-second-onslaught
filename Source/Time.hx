import flash.Lib;
import flash.events.Event;

class Time
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		// events
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrameEnter);
	}

	private static var instance : Time;

	private static function get()
	{
		if(instance == null)
			instance = new Time();
		return instance;
	}

	// shortcut static functions

	public static function getDelta() : Int
	{
    return get().__getDelta();
	}

	// ---------------------------------------------------------------------------
	// DELTA TIME
	// ---------------------------------------------------------------------------

	private static var previous : Int = 0; // in milliseconds

	private static var delta : Int = 0; // in milliseconds

	private function onFrameEnter(event : Event)
	{
			var current = Lib.getTimer();
	    delta = (current - previus);
	    previus = current;
  }

	public function __getDelta() : Int
	{
    return delta;
	}
}