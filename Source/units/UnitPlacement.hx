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

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.events.MouseEvent;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

import hacksaw.GameObject;
import hacksaw.DefaultTextField;

class UnitPlacement extends GameObject
{

	// ---------------------------------------------------------------------------
	// CALLBACKS
	// ---------------------------------------------------------------------------

	public static var onMouseDown : MouseEvent->Void;
	public static var onMouseUp : MouseEvent->Void;

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	public var unitType : UnitType;
	public var timeToAppear : Int;
	
	public function new(_unitType : UnitType, px : Float, py : Float, _timeToAppear : Int) 
	{
		super(px, py);

		// initialise attributes
		unitType = _unitType;
		timeToAppear = _timeToAppear;

		// register events
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		// bitmap image
		var placeholder_bitmap = new Bitmap(unitType.placeholder);
		placeholder_bitmap.x = -placeholder_bitmap.width / 2;
		placeholder_bitmap.y = -placeholder_bitmap.height / 2;
		addChild(placeholder_bitmap);
		
		// timestamp text/icon
		graphics.beginFill(0xFFFFFF);
		graphics.drawCircle(20, 20, 14);
		var textTimeToAppear = new DefaultTextField("" + timeToAppear, 10, 10);
		textTimeToAppear.mouseEnabled = false;
		addChild(textTimeToAppear);	
		
		// hitbox
		graphics.beginFill(0xFFFFFF, 0);
		graphics.drawCircle(0, 0, 32);
	}
	// ---------------------------------------------------------------------------
	// INSTANTIATE
	// ---------------------------------------------------------------------------
		
	public function instantiate() : Unit
	{
		return (unitType.instantiate(x, y));
	}
}