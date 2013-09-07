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

import flash.display.Sprite;

import units.UnitType;
import units.UnitPlacement;

import hacksaw.GameObjectManager;

class Session extends Sprite
{
	private var money : Int;
	private var startingMoney : Int ;
	private var nbReplay : Int;
	private var duration : Int ; //delay between two waves in seconds
	private var timelineSelection : Int = 0 ;
	private var baseEarned : Int = 0 ;
	
	public function new(pduration : Int, pmoney : Int) 
	{
		super();
		money = pmoney ;
		startingMoney = pmoney ;
		nbReplay = 0 ;
		duration = pduration ;

		//init array for storing units to deploy
		unitsToDeploy = new Array<List<UnitPlacement>>();
		for(i in 0 ... 10)
			unitsToDeploy[i] = new List<UnitPlacement>();
	}

	// ---------------------------------------------------------------------------
	// UNIT PLACEMENT
	// ---------------------------------------------------------------------------

	private var unitsToDeploy : Array<List<UnitPlacement>>;

	public function tryPlaceUnit(_viewX : Float, _viewY : Float, t : UnitType) : UnitPlacement
	{
		if(money >= t.price)
			return __placeUnit(_viewX, _viewY, t);
		else
			return null;
	}

	private function __placeUnit(_viewX : Float, _viewY : Float, t : UnitType) : UnitPlacement
	{
		// withdraw cost
		withdrawMoney(t.price);

		// place unit
		var world_position = GameObjectManager.getWorldPosition(_viewX, _viewY);
		var placement = new UnitPlacement(t, world_position.x, world_position.y, timelineSelection);
		unitsToDeploy[timelineSelection].add(placement);

		// return unit
		return placement;
	}

	private function __instantiateUnits(placements : List<UnitPlacement>) : Void
	{
			for (place in placements)
			{
				place.instantiate();
				place.purge = true;
			}
			placements.clear();
	}
	
	public function instantiateUnits(slot : Int = -1) : Void
	{
		if (slot >= 0) // all units
			for (i in 0 ... slot+1)
				__instantiateUnits(unitsToDeploy[i]);
		else // units in specific time slot
			for (timeSlot in unitsToDeploy)
				__instantiateUnits(timeSlot);
	}

	// ---------------------------------------------------------------------------
	// ACCESSORS
	// ---------------------------------------------------------------------------
	
	public function getDuration()
	{
		return duration;
	}
	
	public function getNbReplay()
	{
		return nbReplay;
	}
	
	public function incrementNbReplay()
	{
		nbReplay ++ ;
	}
	
	public function getMoney()
	{
		return money ;
	}
	
	public function resetMoney()
	{
		money = startingMoney ;
		money += baseEarned ;
	}
	
	public function baseSaved(nbBase : Int )
	{
		baseEarned = nbBase * 1000 ;
	}
	
	public function withdrawMoney(withdrawal : Int) : Int
	{
		withdrawal = Math.floor(Math.min(withdrawal, money));
		money -= withdrawal;
		return withdrawal;
	} 

	public function depositMoney(deposit : Int) : Int
	{
		deposit = Math.floor(Math.min(deposit, startingMoney-money));
		money += deposit;
		return deposit;
	}
	
	public function getTimelineSelection()
	{
		return timelineSelection ;
	}
	
	public function setTimelineSelection(newSelection : Int)
	{
		timelineSelection = newSelection ;
	}
}