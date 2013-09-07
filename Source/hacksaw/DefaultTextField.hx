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

import flash.text.TextField;

class DefaultTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String, _x : Float = 0, _y : Float = 0) 
	{
		super();

		defaultTextFormat = DefaultFont.smallBlack;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		x = _x;
		y = _y;
		width = FIELD_WIDTH;

		text = _text;
	}
}