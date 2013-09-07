/* 
'Hacksaw' game library for Haxe / OpenFL
(C) Copyright 2013 William Dyce

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 3 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
*/

package hacksaw;

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

	public static function setMuted(newValue : Bool = true) : Void
	{
		return get().__setMuted(newValue);
	}

	// ---------------------------------------------------------------------------
	// MUTE
	// ---------------------------------------------------------------------------

	private var muted : Bool = false;

	private function __setMuted(newValue : Bool) : Void
	{
		muted = newValue;
	}

	// ---------------------------------------------------------------------------
	// SOUNDS
	// ---------------------------------------------------------------------------

	private var sounds : StringMap< { sound : Sound, instances : Int, max_instances : Int } >;

	private var channel : SoundChannel;

	private function __loadSound(name : String, _max_instances : Int) : Void
	{
		sounds.set(name, { 
			sound : Assets.getSound ("assets/" + name + ".wav"), 
			instances : 0,
			max_instances : _max_instances
		});
	}

	private function __playSound(name : String) : Bool
	{
		if(muted)
			return false;

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