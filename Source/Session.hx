import flash.display.Sprite;

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

	public function placeUnit(_x : Float, _y : Float, t : UnitType) : Void
	{
		var world_position = GameObjectManager.getWorldPosition(_x, _y);
		
		var placement = new UnitPlacement(t, world_position.x, world_position.y, timelineSelection);
		unitsToDeploy[timelineSelection].add(placement);
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
	
	public function withdrawMoney(cost : Int)
	{
		money -= cost ;
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