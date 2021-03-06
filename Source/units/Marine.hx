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
import hacksaw.V2;
import hacksaw.Useful;
import hacksaw.SoundManager;
import hacksaw.SpecialEffect;

class PlasmaGun extends UnitWeapon
{
	public function new()
	{
		super(128, 1, function(u) u.hitpoints -= 10);
	}
}

class Marine extends Unit 
{

	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var sheet : Spritesheet;
	private static var sheetTeleport : Spritesheet;

	private static function init() : Void
	{
		// ---------------------------------------------------------------------------
		// ASSETS

		// MAIN SPRITESHEET

		sheet = BitmapImporter.create(Assets.getBitmapData("assets/marine.png"), 10, 6, 48, 48);

		sheet.addBehavior(new BehaviorData("NW_idle", [0], true, 10));
		sheet.addBehavior(new BehaviorData("NW_shoot", [1, 2, 3, 4], true, 10));

		sheet.addBehavior(new BehaviorData("NE_idle", [5], true, 10));
		sheet.addBehavior(new BehaviorData("NE_shoot", [6, 7, 8, 9], true, 10));

		sheet.addBehavior(new BehaviorData("N_idle", [10], true, 10));
		sheet.addBehavior(new BehaviorData("N_shoot", [11, 12, 13, 14], true, 10));

		//! flipped north is not used

		sheet.addBehavior(new BehaviorData("SW_idle", [20], true, 10));
		sheet.addBehavior(new BehaviorData("SW_shoot", [21, 22, 23, 24], true, 10));

		sheet.addBehavior(new BehaviorData("SE_idle", [25], true, 10));
		sheet.addBehavior(new BehaviorData("SE_shoot", [26, 27, 28, 29], true, 10));

		sheet.addBehavior(new BehaviorData("S_idle", [30], true, 10));
		sheet.addBehavior(new BehaviorData("S_shoot", [31, 32, 33, 34], true, 10));

		//! flipped south is not used

		sheet.addBehavior(new BehaviorData("W_idle", [40], true, 10));
		sheet.addBehavior(new BehaviorData("W_shoot", [41, 42, 43, 44], true, 10));

		sheet.addBehavior(new BehaviorData("E_idle", [45], true, 10));
		sheet.addBehavior(new BehaviorData("E_shoot", [46, 47, 48, 49], true, 10));

		sheet.addBehavior(new BehaviorData("die", [50, 51, 52, 53, 54], false, 10));

		//! flipped die is not used


		// TELEPORT SPRITES

		sheetTeleport = BitmapImporter.create(
			Assets.getBitmapData("assets/marine_spawn.png"), 5, 1, 100, 700);
		sheetTeleport.addBehavior(new BehaviorData("in", [0, 1, 2, 3, 4], false, 10));
		sheetTeleport.addBehavior(new BehaviorData("out", [4, 3, 2, 1, 0], false, 10));


		// SOUND

		SoundManager.loadSound("marine_die");
		SoundManager.loadSound("marine_shoot");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;
	private var shadow : Bitmap;

	private static inline var HITPOINTS : Int = 100;
	private static inline var RADIUS : Int = 16;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_MARINES;
		weapon = new PlasmaGun();

		shadow = new Bitmap(Unit.shadow_data);
		shadow.x = -shadow.width/2;
		addChild(shadow);

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("S_idle");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;
		addChild(animated);

		onPurge = this.__onPurge;

		// teleport in like a sir !
		visible = false;
		new SpecialEffect(x, y, sheetTeleport, "in", 0, -310).onPurge = function()
			visible = true;
		SoundManager.playSound("teleport_in");
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{
		super.update(dt);

		// update animation
		animated.update(cast(dt*1000, Int));

		// get new target
		if(target == null || target.purge)
			refreshTarget();

		// has target
		if(target != null)
		{
			var toTarget = new V2(target.x - x, target.y - y);
			var toTargetNormalised = toTarget.normalised();
			var targetDistance = toTarget.getNorm() - radius - target.radius;
			
			// face target ...
			var facing = Facing.which(toTargetNormalised);

			// attack target
			if(weapon.timeTillReloaded == 0)
			{
				if(targetDistance <= weapon.range)
				{
					animated.showBehavior(facing + "_shoot");
					weapon.fireAt(target);
					SoundManager.playSound("marine_shoot");
					shadow.alpha = 0.8;
				}
				else
				{
					animated.showBehavior(facing + "_idle");
					shadow.alpha = 1.0;
					refreshTarget();
				}

				// move shadows
				shadow.x = -shadow.width/2 -6*Useful.sign(toTargetNormalised.x);
				shadow.y = -4*Useful.sign(toTargetNormalised.y);
			}
		}
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public override function onCollisionWith(other : GameObject) : Void
	{
		super.onCollisionWith(other);
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public function __onPurge() : Void
	{
		// create gibs
		new SpecialEffect(x, y, sheet, "die");

		// play sound
		SoundManager.playSound("marine_die");
	}

	// ---------------------------------------------------------------------------
	// COMBAT
	// ---------------------------------------------------------------------------

	public override function isEnemy(other : Unit) : Bool
	{
		return (other.team == Unit.TEAM_ALIENS);
	}
}
