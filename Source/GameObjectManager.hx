import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.ds.GenericStack;
import haxe.ds.StringMap;

class GameObjectManager extends Sprite 
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		super();

		// add to draw list
		Lib.current.stage.addChild(this);
		// events
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, onFrameEnter );
	}

	private static var instance : GameObjectManager;

	private static function get()
	{
		if(instance == null)
			instance = new GameObjectManager();
		return instance;
	}

	// shortcut static functions

	// ---------------------------------------------------------------------------
	// OBJECT LIST
	// ---------------------------------------------------------------------------

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	private function onFrameEnter() : Void
	{
		for(a in objects)
		{
			// update objects
			a.update(Time.getDelta());

			// generate collisions
			for(b in objects)
			{
				if(a.isCollidingWith(b))
					a.onCollisionWith(b);
				if(b.isCollidingWith(a))
					b.onCollisionWith(a);
			}
		}
	}
}