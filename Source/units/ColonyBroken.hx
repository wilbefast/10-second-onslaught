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

import spritesheet.AnimatedSprite;
import spritesheet.data.BehaviorData;
import spritesheet.importers.BitmapImporter;
import spritesheet.Spritesheet;

class ColonyBroken extends Unit 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var sheet : Spritesheet;

	private static function init() : Void
	{
		sheet = BitmapImporter.create(Assets.getBitmapData("assets/building_broken.png"), 4, 1, 80, 120);
		sheet.addBehavior(new BehaviorData("smoke", [0, 1, 2, 3], true, 10));
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var animated : AnimatedSprite;

	private static inline var HITPOINTS : Int = 300;
	private static inline var RADIUS : Int = 0;

	public function new(_x : Float, _y : Float) : Void
	{
		super(_x, _y, HITPOINTS, RADIUS);

		if(!initialised)
			init();

		team = Unit.TEAM_INVULNERABLE;
		immobile = true;

		animated = new AnimatedSprite(sheet, true);
		animated.showBehavior("smoke");
		animated.x = -animated.width/2;
		animated.y = -animated.height*0.7;
		animated.currentFrameIndex = Math.floor(Math.random()*6); // DOES NOTHING :'(
		addChild(animated);
	}

	public override function update(dt : Float)
	{
		super.update(dt);

		animated.update(cast(dt*1000, Int));
	}
}
