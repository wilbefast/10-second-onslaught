import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

class GameObjectManager extends Sprite 
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		super();

		// create object list
		objects = new List<GameObject>();

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

	public static function add(newObject : GameObject) : Void
	{
		get().__add(newObject);
	}

	public static function purge(object : GameObject) : Void
	{
		get().__purge(object);
	}

	public static function purgeAll() : Void
	{
		get().__purgeAll();
	}

	public static function load(loader : Iterator<GameObject>) : Void
	{
		get().__load(loader);
	}

	// ---------------------------------------------------------------------------
	// OBJECT LIST
	// ---------------------------------------------------------------------------

	private var objects : List<GameObject>;

	private function __add(newObject : GameObject) : Void
	{
		addChild(newObject);
	}

	private function __purge(object : GameObject) : Void
	{
		removeChild(object);
	}

	private function __purgeAll() : Void
	{
		while (numChildren > 0)
    	removeChildAt(0);
	}

	private function __load(loader : Iterator<GameObject>) : Void
	{
		for(loaded in loader)
			__add(loaded);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	private function onFrameEnter(event : Event) : Void
	{
		var previous_y : Float = Math.NEGATIVE_INFINITY;

		// for each object
		for(i in 0 ... numChildren)
		{
			var a : GameObject = cast(this.getChildAt(i), GameObject);

			// purge objects
			if(a.purge)
			{
				a.onPurge();
				__purge(a);
				break;
			}

			// update objects
			a.update(Time.getDelta());

			// for each other object
			for(j in i+1 ... numChildren)
			{
				var b : GameObject = cast(this.getChildAt(j), GameObject);
				// generate collisions between objects
				if(a.isCollidingWith(b))
					a.onCollisionWith(b);
				if(b.isCollidingWith(a))
					b.onCollisionWith(a);
			}

			// sort objects by y coordinate
			if(a.y < previous_y)
			{
				trace("previous_y = ", previous_y, "y = ", a.y);
				setChildIndex(a, i-1);
			}
			previous_y = a.y;
		}
	}
}