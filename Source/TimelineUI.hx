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

import motion.Actuate;
import motion.easing.Quad;

import hacksaw.DefaultTextField;

import scenes.GameScene;

class TimelineUI extends Sprite 
{
	private static var background_bd : BitmapData;
	private static var selectionContainer_bd : BitmapData;
	private static var bar_bd : BitmapData;
	private static var initialised = false;
	
	private var session : Session;
	private var selection : Sprite;
	private var bar : Sprite;
	private var background : Sprite;

	private var text : DefaultTextField;

	public function new(scene : GameScene)
	{
		super();

		if(!initialised)
		{
			background_bd = Assets.getBitmapData("assets/TimelineBG_01.png");
			selectionContainer_bd = Assets.getBitmapData("assets/TimelineSelect_01.png");
			bar_bd = Assets.getBitmapData("assets/GabariTimeline_01.png");
			
			initialised = true;
		}

		// initialise variables
		session = scene.getSession();
		
		// build draw list

		// ... background
		background = new Sprite();
		background.addChild(new Bitmap(background_bd));
		addChild(background);
		
		// ... bar
		bar = new Sprite();
		bar.addChild(new Bitmap(bar_bd));
		bar.alpha = 0.7;
		bar.width = 0;
		addChild(bar);

		// ... selection
		var selection_bitmap = new Bitmap(selectionContainer_bd);

		selection_bitmap.x = -selection_bitmap.width/2;
		selection = new Sprite();
		selection.addChild(selection_bitmap);
		addChild(selection);
	}

	private var slotWidth : Float = 0;

	public function recalculateLayout()
	{
		background.width = stage.stageWidth;
		bar.x = (background.width / stage.stageWidth)*3;
	}
	
	public function update(time : Float)
	{
		var slotWidth = background.width * 0.1;
		bar.width = selection.x = time * slotWidth;
	}
	
	public function onMouseClick(event : MouseEvent) : Void
  {
		var slotWidth = (background.width-bar.x*2) * 0.1;
		session.setTimelineSelection(Math.round(event.stageX / slotWidth));

		var select_x = session.getTimelineSelection() * slotWidth;

		Actuate.tween(selection, 0.3, { x : select_x }, true).ease (Quad.easeOut);
		Actuate.tween(bar, 0.3, { width : select_x }, true).ease (Quad.easeOut);
  }
}