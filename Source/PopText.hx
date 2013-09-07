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

import hacksaw.GameObject;
import hacksaw.DefaultFont;
import hacksaw.DefaultTextField;

import motion.Actuate;
import motion.easing.Quad;

class PopText extends GameObject
{

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new(_x : Float, _y : Float, text : String) : Void
	{
		super(_x, _y);

		// text
		var text = new DefaultTextField(text);
		text.setTextFormat(DefaultFont.smallWhite);
		addChild(text);	

		// no touch-y !
		text.mouseEnabled = false;
		this.mouseEnabled = false;

		// float up and fade out
		Actuate.tween(this, 1.5, { y : y-64 }, true)
			.ease(Quad.easeOut);
		Actuate.tween(this, 1.5, { alpha : 0 }, true)
			.ease(Quad.easeOut)
			.onComplete(function() purge = true);
	}
}