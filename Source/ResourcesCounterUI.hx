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
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import hacksaw.DefaultTextField;
import hacksaw.DefaultFont;


class ResourcesCounterUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;
	
	private var session_attribut : Session;

	private var money : Int;
	
	private var textField : TextField;
	
	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/GUI2_bloc_money.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------


	public function new( session : Session)
	{
		if(!initialised)
			init();

		super();
		
		var bitmap = new Bitmap(bitmapData) ;
		addChild(bitmap);
		
		session_attribut = session;
		money = session_attribut.getMoney();
		textField = new DefaultTextField("Cash : " + money);
		textField.defaultTextFormat = DefaultFont.smallWhite;
		textField.x = bitmap.width * 0.1 ;
		textField.y = bitmap.height / 6 ;
		addChild(textField);
	}
	
	public function update()
	{
		money = session_attribut.getMoney();
		textField.text = "Cash : " + money ;
	}
}