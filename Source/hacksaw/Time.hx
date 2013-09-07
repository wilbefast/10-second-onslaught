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
