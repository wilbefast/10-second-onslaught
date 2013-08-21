import flash.Lib;
import flash.events.Event;

class Time
{
	private function new()
	{
		// abstract classes have private constructors
	}

	private static var previus : Int = 0; // in milliseconds

	private static var delta : Int = 0; // in milliseconds

	public static function start() : Void
	{
		// events
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrameEnter);
	}

	public static function onFrameEnter(event : Event)
	{
			var current = Lib.getTimer();
	    delta = (current - previus);
	    previus = current;
  }

	public static function getDelta() : Int
	{
    return delta;
	}
}