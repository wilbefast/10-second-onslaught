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

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;

import scenes.GameScene;

class DeployUI extends Sprite 
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var session_attribut : Session;

	private static function init() : Void
	{
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	//private var replaysCounter : ReplaysCounterUI;
	private var resourcesCounter : ResourcesCounterUI;
	public var startButton : StartButtonUI;

	public function new(pgameScene : GameScene)
	{
		super();
		session_attribut = pgameScene.getSession();

		if(!initialised)
			init();

		//replaysCounter = new ReplaysCounterUI(session_attribut);
		//addChild(replaysCounter);

		resourcesCounter = new ResourcesCounterUI(session_attribut);
		addChild(resourcesCounter);

		startButton = new StartButtonUI(pgameScene);
		addChild(startButton);

		//recalculateLayout();
	}

	public function update()
	{
		//replaysCounter.update();
		resourcesCounter.update();
	}
	
	public function recalculateLayout() : Void
	{
		// size
		if(stage != null)
		{
			startButton.width = stage.stageWidth * 0.1 ;
			startButton.height = startButton.width / 3 ;
			startButton.x = stage.stageWidth - startButton.width;
			startButton.y = 0 ;
			
			//replaysCounter.height = available_height*0.33;
			
			resourcesCounter.width = stage.stageWidth * 0.17 ;
			resourcesCounter.height = resourcesCounter.width / 2;
			resourcesCounter.x = 0 ;
			resourcesCounter.y = 0 ;
		}

		// position
	}
}