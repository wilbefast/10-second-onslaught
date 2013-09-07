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

import flash.display.BitmapData;
import flash.display.Bitmap;
import openfl.Assets;
import flash.display.Sprite;
import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

class RadialMenu extends Sprite
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var icons : Array<Sprite>;
	private var radius : Float;

	public function new(_radius : Float = 48)
	{
		super();
		
		icons = new Array<Sprite>();
		radius = _radius;

		alpha = 0;
	}


	// ---------------------------------------------------------------------------
	// OPTIONS
	// ---------------------------------------------------------------------------

	private function setIconsMouseEnabled(value : Bool) : Void
	{
		for (icon in icons)
			icon.mouseEnabled = value;
	}

	public function addOption(onSelected : Void->Void, icon_bitmapdata : BitmapData)
	{
		var icon = new Sprite();
		var icon_bitmap = new Bitmap(icon_bitmapdata);
		//icon_bitmap.scaleX = icon_bitmap.scaleY = 1.5;
		icon_bitmap.x = -icon_bitmap.width / 2;
		icon_bitmap.y = -icon_bitmap.height / 2;
		icon.addChild(icon_bitmap);

		icon.addEventListener(MouseEvent.CLICK, function(event) 
		{
			if(opened)
			{
				onSelected();
				close();
				event.stopPropagation();
			}
			else
				open();
	 	});

		icons.push(icon);
		addChild(icon);
	}


	// ---------------------------------------------------------------------------
	// OPEN AND CLOSE
	// ---------------------------------------------------------------------------
	
	private var opened : Bool = false;

	public function isOpened() : Bool return opened;

	public function open() : Void 
	{
		if (opened)
			return;

		Actuate.tween(this, 0.3, { alpha : 1.0 }, true)
					.ease (Quad.easeOut);

		var radians_per_options = Math.PI*2/icons.length;
		for (i in 0 ... icons.length)
		{
			var radians = radians_per_options*(i /*+ 0.5*/);
			var ox = Math.cos(radians)*radius;
			var oy = Math.sin(radians)*radius;
			Actuate.tween(icons[i], 0.3, { x : ox, y : oy }, true)
					.ease (Quad.easeOut).onComplete(function() setIconsMouseEnabled(true) );	
		}
		
		opened = true;
	}
	
	public function close() : Void
	{
		if (!opened)
			return;
		
		Actuate.tween(this, 0.3, { alpha : 0.0 }, true)
					.ease (Quad.easeOut);

		for (i in 0 ... icons.length)
			Actuate.tween(icons[i], 0.3, { x : 0, y : 0 }, true)
					.ease (Quad.easeOut);
				
		opened = false;
		setIconsMouseEnabled(false);
	}
	
	public function toggle()
	{
		if(opened)
			close();
		else
			open();
	}
}