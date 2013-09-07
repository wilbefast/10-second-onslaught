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

import flash.text.TextField;

import hacksaw.DefaultTextField;
import hacksaw.DefaultFont;

class StarWarsTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String) 
	{
		super();

		defaultTextFormat = DefaultFont.bigWhite;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		text = _text;
	}
}