import flash.media.Sound;
import flash.media.SoundChannel;
import haxe.ds.StringMap;

import flash.events.Event;

import openfl.Assets;

class SoundManager
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		sounds = new StringMap< { sound : Sound, instances : Int, max_instances : Int } >();
	}

	private static var instance : SoundManager;

	private static function get()
	{
		if(instance == null)
			instance = new SoundManager();
		return instance;
	}

	// shortcut static functions

	public static function loadSound(name : String, _max_instances : Int = 3) : Void
	{
		get().__loadSound(name, _max_instances);
	}

	public static function playSound(name : String) : Bool
	{
		return get().__playSound(name);
	}

	// ---------------------------------------------------------------------------
	// SOUNDS
	// ---------------------------------------------------------------------------

	private var sounds : StringMap< { sound : Sound, instances : Int, max_instances : Int } >;

	private var channel : SoundChannel;

	private function __loadSound(name : String, _max_instances : Int = 3) : Void
	{
		sounds.set(name, { 
			sound : Assets.getSound ("assets/" + name + ".wav"), 
			instances : 0,
			max_instances : _max_instances
		});
	}

	private function __playSound(name : String) : Bool
	{
		var value = sounds.get(name);

		if(value.instances <= value.max_instances)
		{
			value.instances++;
			value.sound.play().addEventListener(Event.SOUND_COMPLETE, 
				function(e) value.instances--);
			return true;
		}
		else
			return false;
	}
}