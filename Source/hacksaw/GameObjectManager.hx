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
import flash.display.Sprite;
import flash.events.Event;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

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

	public static function get()
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

	public static function getMatching(condition : GameObject->Bool) : GameObjectIterator
	{
		return get().__getMatching(condition);
	}

	public static function countMatching(condition : GameObject->Bool) : Int
	{
		return get().__countMatching(condition);
	}

	public static function getMaximum(evaluation : GameObject->Float, ?condition : GameObject->Bool) : GameObject
	{
		return get().__getMaximum(evaluation, condition);
	}

	public static function setCameraPosition(_x : Float, _y : Float) : Void
	{
		get().__setCameraPosition(_x, _y);
	}
	
	public static function setCameraZoom(_x : Float, _y : Float) : Void
	{
		get().__setCameraZoom(_x, _y);
	}
	
	public static function getWorldPosition(_x : Float, _y : Float) : { x : Float, y : Float }
	{
		return get().__getWorldPosition(_x, _y);
	}

	public static function getViewPosition(_x : Float, _y : Float) : { x : Float, y : Float }
	{
		return get().__getViewPosition(_x, _y);
	}

	// ---------------------------------------------------------------------------
	// OBJECT LIST
	// ---------------------------------------------------------------------------

	private function __add(newObject : GameObject) : Void
	{
		for(i in 0 ... numChildren)
		{
			if(this.getChildAt(i).y > newObject.y)
			{
				addChildAt(newObject, i);
				return;
			}
		}

		// assuming we didn't return, add to the end of the list
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
	// QUERY
	// ---------------------------------------------------------------------------

	private static inline function onlyGameObjects(condition : GameObject->Bool) : Dynamic->Bool
	{
		// Functionception
		return (function(o) return (Std.is(o, GameObject))
																? condition(cast(o, GameObject)) 
																:	false); 
	}

	private function __getMatching(condition : GameObject->Bool) : GameObjectIterator
	{
		return new GameObjectIterator(new ChildIterator(this, onlyGameObjects(condition)));
	}

	private function __countMatching(condition : GameObject->Bool) : Int
	{
		var count = 0;
		for(o in __getMatching(condition))
			count++;
		return count;
	}

	private function __getMaximum(evaluation : GameObject->Float, ?condition : GameObject->Bool) : GameObject
	{
		var max_evaluation : Float = Math.NEGATIVE_INFINITY;
		var max_object : GameObject = null;
		for(object in new GameObjectIterator(new ChildIterator(this)))
		{
			if(Std.is(object, GameObject) && ((condition == null) || condition(object)))
			{
				var object_evaluation = evaluation(object);
				if(object_evaluation > max_evaluation)
				{
					max_object = object;
					max_evaluation = object_evaluation;
				}
			}
		}
		return max_object;
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
				if(a.onPurge != null)
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
				setChildIndex(a, i-1);
			previous_y = a.y;

			// apply pre-render logic
			a.render();
		}
	}

	// ---------------------------------------------------------------------------
	// DRAW LIST
	// ---------------------------------------------------------------------------

	private function __setCameraPosition(_x : Float, _y : Float) : Void
	{
		x = _x;
		y = _y;
	}
	
	private function __setCameraZoom(_x : Float, _y : Float) : Void
	{
		scaleX = _x;
		scaleY = _y;
	}
	
	private function __getWorldPosition(_x : Float, _y : Float) : { x : Float, y : Float }
	{
		return { x : (_x - x)/scaleX, y : (_y - y)/scaleY };
	}

	private function __getViewPosition(_x : Float, _y : Float) : { x : Float, y : Float }
	{
		return { x : (_x + x), y : (_y + y) };
	}
}