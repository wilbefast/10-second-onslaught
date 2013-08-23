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
		objects.push(newObject);
		addChild(newObject);
	}

	private function __purge(object : GameObject) : Void
	{
		objects.remove(object);
		removeChild(object);
	}

	private function __purgeAll() : Void
	{
		for(a in objects)
			removeChild(a);
		objects.clear();
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
		for(a in objects)
		{
			// purge objects
			if(a.purge)
			{
				a.onPurge();
				__remove(a);
				break;
			}

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