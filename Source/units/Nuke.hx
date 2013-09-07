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
import flash.geom.Rectangle;
import flash.display.BitmapData;
import flash.media.Sound;

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

import hacksaw.GameObject;
import hacksaw.Time;
import hacksaw.Useful;
import hacksaw.SoundManager;
import hacksaw.SpecialEffect;


class NukeExplosion extends GameObject
{
	public function new(_x : Float, _y : Float)
	{
		super(_x, _y, 48);
	}

	public var timer : Float = 0.75;

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		timer -= dt;
		if(timer < 0)
			purge = true;
	}

	public override function onCollisionWith(other : GameObject) : Void
	{
		if(Std.is(other, Unit))
		{
			var unit : Unit = cast(other, Unit);
			unit.hitpoints -= Math.floor(radius*100*Time.getDelta()/Useful.distance(x, y, other.x, other.y));
		}
	}

}

class Nuke extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var sheet : Spritesheet;
	private static var sheetExplode : Spritesheet;
	private static var sheetTeleport : Spritesheet;

	private static function init() : Void
	{
		// ---------------------------------------------------------------------------
		// ASSETS

		// MAIN SPRITESHEET

		sheet = BitmapImporter.create(Assets.getBitmapData("assets/nuke.png"), 7, 1, 48, 48);
		sheet.addBehavior(new BehaviorData("idle", [0, 1, 2, 3, 4, 5, 6], true, 10));

		sheetExplode = BitmapImporter.create(Assets.getBitmapData("assets/nukeExplosion.png"), 7, 1, 270, 700);
		sheetExplode.addBehavior(new BehaviorData("explode", [0, 1, 2, 3, 4, 5, 6], true, 12));


		// TELEPORT SPRITES

		sheetTeleport = BitmapImporter.create(
			Assets.getBitmapData("assets/nuke_spawn.png"), 5, 1, 100, 700);
		sheetTeleport.addBehavior(new BehaviorData("in", [0, 1, 2, 3, 4], false, 10));
		sheetTeleport.addBehavior(new BehaviorData("out", [4, 3, 2, 1, 0], false, 10));


		// SOUND

		SoundManager.loadSound("nuke");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;
	private var shadow : Bitmap;

	private static inline var HITPOINTS : Int = 40;
	private static inline var RADIUS : Int = 16;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_INVULNERABLE;

		shadow = new Bitmap(Unit.shadow_data);
		shadow.x = -shadow.width/2;
		addChild(shadow);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("idle");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;

		addChild(animated);

		// teleport in like a sir !
		visible = false;
		new SpecialEffect(x, y, sheetTeleport, "in", 0, -320).onPurge = function()
			visible = true;
		SoundManager.playSound("teleport_in");
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public var timer : Float = 2;

	public var exploded : Bool = false;

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		animated.update(Math.floor(1000 * dt));

		timer -= dt;
		if(timer < 0 && !purge)
		{
			new NukeExplosion(x, y);
			new SpecialEffect(x, y, sheetExplode, "explode", 0, -300);
			SoundManager.playSound("nuke");

			purge = true;
			exploded = true;
		}
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public override function onCollisionWith(other : GameObject) : Void
	{
		super.onCollisionWith(other);
	}
}
