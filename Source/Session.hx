import flash.display.Sprite;

class Session extends Sprite
{
	private var money : Int;
	private var nbReplay : Int;
	private var timer : Int ; //delay between two waves in seconds
	private var timelineSelection : Int = 0 ;

	
	public function new(ptimer : Int) 
	{
		super();
		money = 1500 ;
		nbReplay = 0 ;
		timer = ptimer ;

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
		var placement = new UnitPlacement(t, _x, _y);
		addChild(placement);
		unitsToDeploy[timelineSelection].add(placement);
	}

	// ---------------------------------------------------------------------------
	// ACCESSORS
	// ---------------------------------------------------------------------------
	
	
	public function getTimer()
	{
		return timer ;
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
	
	public function getTimelineSelection()
	{
		return timelineSelection ;
	}
	
	public function setTimelineSelection(newSelection : Int)
	{
		timelineSelection = newSelection ;
	}
}