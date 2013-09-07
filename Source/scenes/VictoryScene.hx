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

package scenes;

import openfl.Assets;

import flash.events.MouseEvent;
import flash.display.BitmapData;
import flash.display.Bitmap;

import hacksaw.Scene;
import hacksaw.SceneManager;

class VictoryScene extends Scene
{

	private static var bitmapData : BitmapData; 
	private static var initialised = false;
	
	public function new() 
	{
		super();

		if(!initialised)
		{
			bitmapData = Assets.getBitmapData("assets/vicoty_screen.jpg");
			initialised = true;
		}
		
		var bitmap = new Bitmap(bitmapData) ;
		addChild(bitmap);
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Title");
	}

	public override function onEnter(previous : Scene)
	{
		width = stage.stageWidth ;
		height = stage.stageHeight ;
	}
}