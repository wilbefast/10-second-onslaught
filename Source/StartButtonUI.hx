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

import openfl.Assets;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import scenes.GameScene;

class StartButtonUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var start_bm : BitmapData;
	private static var stop_bm : BitmapData;
	
	private var bitmap : Bitmap;
	
	private var gameScene : GameScene ;
	
	private static inline var PHASE_DEPLOY : Int = 0;
	private static inline var PHASE_ATTACK : Int = 1;
	private var phase : Int = PHASE_DEPLOY;

	private static function init() : Void
	{
		start_bm = Assets.getBitmapData("assets/GUI2_button_start.png");
		stop_bm = Assets.getBitmapData("assets/GUI2_button_stop.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new(pgameScene : GameScene)
	{
		super();

		gameScene = pgameScene ;
		
		// load resources
		if(!initialised)
			init();

		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);	
		bitmap = new Bitmap(start_bm) ;
		addChild(bitmap);
	}
	
	public function changeButton()
	{
		if (phase == PHASE_DEPLOY)
		{
			phase = PHASE_ATTACK ;
			removeChild(bitmap);
			bitmap = new Bitmap(stop_bm) ;
			addChild(bitmap);
		}
		else 
		{
			phase = PHASE_DEPLOY;
			removeChild(bitmap);
			bitmap = new Bitmap(start_bm) ;
			addChild(bitmap);
		}
	}
	
	private function onMouseClick(event : MouseEvent) : Void
    {
		gameScene.switchPhase();
    }
}