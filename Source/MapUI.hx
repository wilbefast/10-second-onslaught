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
import flash.events.MouseEvent;

import hacksaw.GameObjectManager;

import scenes.GameScene;

class MapUI extends Sprite 
{
	private static var bitmapData : BitmapData;

	private static var initialised = false;
	
	private var session : Session ;
	private var bitmap : Bitmap;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/GabariPlateau_01.png");
			initialised = true;
		}
		
		addChild(bitmap = new Bitmap(bitmapData));
		
		session = scene.getSession();
		// register callbacks
        this.addEventListener(MouseEvent.CLICK, onMouseClick);
	}

	public function recalculateLayout()
	{
		bitmap.width = stage.stageWidth;
		bitmap.height = stage.stageHeight;
		
		// game objects
		GameObjectManager.setCameraPosition(stage.stageWidth/2, stage.stageHeight/2);
		GameObjectManager.setCameraZoom(stage.stageWidth / 1600, 
																		stage.stageHeight / 920);
		
	}
	
	public function update()
	{
		
	}
	
	private function onMouseClick(event : MouseEvent) : Void
  {
	}
}