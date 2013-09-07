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

class V2
{
	public static var N;
	public static var S;
	public static var E;
	public static var W;
	public static var NE;
	public static var SE;
	public static var NW;
	public static var SW;

	public static function __init__() : Void
	{
		N = new V2(0, -1);
		S = new V2(0, 1);
		E = new V2(1, 0);
		W = new V2(-1, 0);
		NE = new V2(1, -1).normalised();
		SE = new V2(1, 1).normalised();
		NW = new V2(-1, -1).normalised();
		SW = new V2(-1, 1).normalised();
	}

	public static inline function dot(a : V2, b : V2) : Float
	{
		return (a.x*b.x + a.y*b.y);
	}


	public var x : Float;
	public var y : Float;

	public function new(_x : Float, _y : Float)
	{
		x = _x;
		y = _y;
	}

	public inline function normalised() : V2
	{
		var norm = getNorm();
		return new V2(x / norm, y / norm);
	}

	public inline function normalise() : V2
	{
		var norm = getNorm();
		x /= norm;
		y /= norm;
		return this;
	}

	public inline function getNorm() : Float
	{
		return (Math.sqrt(getNorm2()));
	}

	public inline function getNorm2() : Float
	{
		return (Useful.sqr(x) + Useful.sqr(y));
	}
}