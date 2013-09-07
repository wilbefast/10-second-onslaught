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

class Useful
{
	public static function sign(x : Float) : Int
	{
		if(x > 0)
			return 1;
		else if (x < 0)
			return -1;
		else
			return 0;
	}

	public static inline function sqr(x : Float) : Float
	{
		return (x*x);
	}

	public static inline function distance2(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Float
	{
		return (Useful.sqr(x1 - x2) + Useful.sqr(y1 - y2));
	}

	public static inline function distance(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Float
	{
		return (Math.sqrt(distance2(x1, y1, x2, y2)));
	}
}