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

import hacksaw.Time;

class UnitWeapon
{
	public var range : Float;
	public var reloadDuration : Float;
	public var timeTillReloaded : Float = 0;
	public var onFire : Unit->Void;

	public function new(_range : Float, _reloadDuration : Float, _onFire : Unit->Void)
	{
		range = _range;
		reloadDuration = _reloadDuration;
		onFire = _onFire;
	}

	public function reload() : Void
	{
		timeTillReloaded = Math.max(0, timeTillReloaded - Time.getDelta());
	}

	public function fireAt(target : Unit) : Void
	{
		timeTillReloaded = reloadDuration;
		onFire(target);
	}
}