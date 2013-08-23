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
		previous = Lib.getTimer();
	}

	private static var instance : Time;

	private static function get()
	{
		if(instance == null)
			instance = new Time();
		return instance;
	}

	// shortcut static functions

	public static function getDelta() : Float
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
	    delta = (current - previous);
	    previous = current;
  }

	public function __getDelta() : Float
	{
    return (cast(delta, Float)  / 1000); // convert to seconds
	}
}
