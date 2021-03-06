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

import haxe.ds.StringMap;

class BuyUI extends Sprite
{
	
private var unit : UnitType;
private var unitCount : Int;
private var unitCost : Int;
private var money : Int;
private var session_attribut : Session;
	
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	private static var up_data : BitmapData;
	private static var down_data : BitmapData;
	private var marine_data : DefaultTextField ;
	private var nuke_data : DefaultTextField ; 
	
	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GUI_fond_achat_01.png");

		up_data = Assets.getBitmapData("assets/GUI_button_up_01.png");
		down_data = Assets.getBitmapData("assets/GUI_button_down_01.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var icon : Sprite;
	private var up : Sprite;
	private var down : Sprite;

	public function new(unitType : UnitType, session : Session)
	{
		super();

		if(!initialised)
			init();
		unitCost = unitType.getPrice();
		session_attribut = session;

		// Build hierarchy
		addChild(new Bitmap(background_data));

		icon = new Sprite();
		icon.addChild(new Bitmap(unitType.getIcon()));
		addChild(icon);
		icon.width = width/4;

		up = new Sprite();
		up.addEventListener(MouseEvent.CLICK, onMouseClickUp);
		up.addChild(new Bitmap(up_data));
		up.x = icon.x + icon.width;
		up.y = icon.y;
		addChild(up);
		up.width = width/6;

		down = new Sprite();
		down.addEventListener(MouseEvent.CLICK, onMouseClickDown);
		down.addChild(new Bitmap(down_data));
		down.x = icon.x + icon.width;
		down.y = icon.y + icon.height - down.height;
		addChild(down);
		down.width = width/6;
	}
	
	private function onMouseClickUp (event : MouseEvent) : Void
	{
		if (money>unitCost)
			unitCount = unitCount + 1;
	}
	
	private function onMouseClickDown (event : MouseEvent) : Void
	{
		if (unitCount > 0) 
			unitCount = unitCount - 1;
	}
	
	public function update() : Void
	{
		money = session_attribut.getMoney();
		unitCount = unit.getCount();
	}
}