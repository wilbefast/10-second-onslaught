/* 
'10 Second Onslaught' OpenFL game
(C) Copyright 2013 William Dyce, Antoine Seilles

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 3 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
*/

package units;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

import hacksaw.GameObject;
import hacksaw.GameObjectManager;
import hacksaw.V2;
import hacksaw.Time;
import hacksaw.Useful;

class Unit extends GameObject 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	public static var shadow_data : BitmapData;

	private static function init() : Void
	{
		shadow_data = Assets.getBitmapData("assets/shadow.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new(_x : Float, _y : Float, _hitpoints : Int, _radius : Float = 0) : Void
	{
		super(_x, _y, _radius);

		if(!initialised)
			init();

		hitpoints = max_hitpoints = _hitpoints;
	}
	
	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		// check for death
		if(hitpoints <= 0)
			purge = true;

		// reload weapon
		if(weapon != null)
			weapon.reload();
	}

	// ---------------------------------------------------------------------------
	// RENDER
	// ---------------------------------------------------------------------------

	private static inline var HEALTHBAR_WIDTH = 32;
	private static inline var HEALTHBAR_HEIGHT = 8;
	private static inline var HEALTHBAR_YOFFSET = 16;

	public override function render() : Void
	{
		// clear
		graphics.clear();

		// healthbar background
		graphics.beginFill(0x000000);
		graphics.drawRect(
			-HEALTHBAR_WIDTH/2, 
			radius*0.7, 
			HEALTHBAR_WIDTH, 
			HEALTHBAR_HEIGHT);

		// healthbar
		var percent_hitpoints : Float = cast(hitpoints, Float)/max_hitpoints;
		graphics.beginFill(0x00FF00);
		graphics.drawRect(
			2 - HEALTHBAR_WIDTH/2, 
		 	2 + radius*0.7, 
			Math.max(5, HEALTHBAR_WIDTH*percent_hitpoints) - 4, 
			HEALTHBAR_HEIGHT - 4);
	}


	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public var immobile : Bool = false;

	public override function onCollisionWith(other : GameObject) : Void
	{
		// repulse
		if(!immobile && Std.is(other, Unit))
		{
			// repulsion vector
			var repulse = new V2(x - other.x, y - other.y);
			x += (radius + other.radius)/repulse.x * 10 * Time.getDelta();
			y +=(radius + other.radius)/repulse.y * 10 * Time.getDelta();
		}
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public var hitpoints : Int;
	private var max_hitpoints : Int;

	public var target : Unit = null;

	public var weapon : UnitWeapon = null;

	public static inline var TEAM_CIVILLIANS : Int = 0;
	public static inline var TEAM_MARINES : Int = 1;
	public static inline var TEAM_ALIENS : Int = 2;
	public static inline var TEAM_INVULNERABLE : Int = 3;
	public var team : Int;

	public function isEnemy(other : Unit) : Bool
	{
		// override me ! 
		return true;
	}

	public function refreshTarget() : Void
	{
		// find new target
		var nearest = GameObjectManager.getMaximum(
			function(other) return -Useful.distance2(x, y, other.x, other.y),
			function(other) return Std.is(other, Unit) && isEnemy(cast(other, Unit)));
		if(nearest != null)
			target = cast(nearest, Unit);
		else
			target = null;
	}
}
