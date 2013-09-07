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

import flash.text.Font;
import flash.text.TextFormat;

@:font("arial.ttf") class DefaultFont extends Font 
{
	public static var smallWhite : TextFormat;
	public static var bigWhite : TextFormat;
	public static var smallBlack : TextFormat;
	public static var bigBlack : TextFormat;

	public static function load()
	{
		Font.registerFont (DefaultFont);

		smallWhite = new TextFormat("Arial", 16, 0xFFFFFF);
		bigWhite = new TextFormat("Arial", 32, 0xFFFFFF);
		smallBlack = new TextFormat("Arial", 16, 0x000000);
		bigBlack = new TextFormat("Arial", 32, 0x000000);
	}
}