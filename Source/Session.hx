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
import units.Colony;
import units.UnitPlacement;

import hacksaw.GameObject;
import hacksaw.GameObjectManager;
import hacksaw.SceneManager;

class Session
{
	// ---------------------------------------------------------------------------
	// CONSTANTS
	// ---------------------------------------------------------------------------

	public static inline var START_MONEY = 3000;
	public static inline var COLONY_BONUS = 1000;
	public static inline var DURATION = 10;

	// ---------------------------------------------------------------------------
	// ATTRIBUTES
	// ---------------------------------------------------------------------------

	private var money : Int;
	private var replayNumber : Int;

	public var timelineSelection : Int = 0 ;
	
	public function new() 
	{
		money = START_MONEY;
		replayNumber = -1;

		// init array for storing units to deploy
		unitsToDeploy = new Array<List<UnitPlacement>>();
		for(i in 0 ... 10)
			unitsToDeploy[i] = new List<UnitPlacement>();

		// init array of previously instatiated units, to be regenerated as placements
		instantiatedUnits = new List<{x : Float, y : Float, time : Int, type : UnitType }>();
	}

	// ---------------------------------------------------------------------------
	// UNIT PLACEMENT
	// ---------------------------------------------------------------------------

	private var unitsToDeploy : Array<List<UnitPlacement>>;

	public function tryPlaceUnit(_viewX : Float, _viewY : Float, type : UnitType) : UnitPlacement
	{
		if(money >= type.price)
		{
			var world_position = GameObjectManager.getWorldPosition(_viewX, _viewY);
			return __placeUnit(world_position.x, world_position.y, type, timelineSelection);
		}
		else
			return null;
	}

	private function __placeUnit(_x : Float, _y : Float, type : UnitType, time : Int) : UnitPlacement
	{
		// withdraw cost
		money -= type.price;

		// place unit
		var placement = new UnitPlacement(type, _x, _y, time);
		unitsToDeploy[time].add(placement);

		// return unit
		return placement;
	}

	private function __clearPlacements() : Void
	{
		for(slot in unitsToDeploy)
			slot.clear();
	}

	// ---------------------------------------------------------------------------
	// UNIT INSTATIATION
	// ---------------------------------------------------------------------------

	private var instantiatedUnits : List<{x : Float, y : Float, time : Int, type : UnitType }>;

	private function __instantiateUnits(placements : List<UnitPlacement>) : Void
	{
			for (place in placements) if (!place.purge)
			{
				place.instantiate();
				instantiatedUnits.push({x : place.x, y : place.y, time : place.timeToAppear, type : place.unitType});
				place.purge = true;
			}
			placements.clear();
	}
	
	public function instantiateUnits(slot : Int = -1) : Void
	{
		// all units ?
		if (slot >= 0) 
			for (i in 0 ... slot+1)
				__instantiateUnits(unitsToDeploy[i]);
		// units in specific time slot ?
		else 
			for (timeSlot in unitsToDeploy)
				__instantiateUnits(timeSlot);
	}

	private function __revertInstantiations()
	{
		__clearPlacements();
		for(inst in instantiatedUnits)
			__placeUnit(inst.x, inst.y, inst.type, inst.time);
	 	instantiatedUnits.clear();
	}

	// ---------------------------------------------------------------------------
	// MONEY
	// ---------------------------------------------------------------------------

	public function getMoney()
	{
		return money ;
	}

	public function withdrawMoney(withdrawal : Int) : Int
	{
		withdrawal = Math.floor(Math.min(withdrawal, money));
		money -= withdrawal;
		return withdrawal;
	} 

	public function depositMoney(deposit : Int) : Int
	{
		deposit = Math.floor(Math.min(deposit, START_MONEY-money));
		money += deposit;
		return deposit;
	}

	// ---------------------------------------------------------------------------
	// PHASES
	// ---------------------------------------------------------------------------

	public function newDeployPhase(nbSavedColonies : Int = 0)
	{
		// increment replays 
		replayNumber++;

		// victory ?
		if (nbSavedColonies >= 5) 
			SceneManager.setScene("Victory");
		// keep trying ?
		else
		{
			// reset timeline selection
			timelineSelection = 0;

			// reset money
			money = START_MONEY + COLONY_BONUS*nbSavedColonies;

			// regenerate deployments
			__revertInstantiations();
		}
	}
	

	// ---------------------------------------------------------------------------
	// ACCESSORS
	// ---------------------------------------------------------------------------

	public function getNbReplay()
	{
		return replayNumber;
	}
}