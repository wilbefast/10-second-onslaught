import flash.media.Sound;
import haxe.ds.StringMap;
import flash.media.SoundChannel

class SoundManager
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		super();
	}

	private static var instance : SoundManager;

	private static function get()
	{
		if(instance == null)
			instance = new SoundManager();
		return instance;
	}

	// shortcut static functions

	public static function loadSound(name : String, _max_instances : Int = 3)
	{
		get().__loadSound(name, _max_instances);
	}

	public static function playSound(name : String)
	{
		return get().__playSound(name);
	}

	// ---------------------------------------------------------------------------
	// SOUNDS
	// ---------------------------------------------------------------------------

	private var sounds : StringMap< { sound : Sound, instances : Int } >

	private var channel : SoundChannel;

	private function __loadSound(name : String, _max_instances : Int = 3) : Void
	{
		sounds.set(name, { 
			sound : Assets.getSound ("assets/" + name + ".wav"), 
			instances : 0,
			max_instances = _max_instances
		});
	}

	private function __playSound(name : String) : Bool
	{
		var value = sounds.get(name);

		if(value.instances <= value.max_instances)
		{
			value.instances++;
			value.sound.play().addEventListener(Event.SOUND_COMPLETE, 
				function() value.instances--);
			return true;
		}
		else
			return false;
	}
}