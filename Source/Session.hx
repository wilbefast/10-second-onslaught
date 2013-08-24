import flash.display.Sprite;

class Session extends Sprite
{
	private var money : Int;
	private var nbReplay : Int;
	private var timer : Int ; //delay between two waves in seconds
	private var timelineSelection : Int = 0 ;
	private var unitsToDeploy : Array < List<UnitPlacement> > ;
	
	//units
	private var marines : Int ;
	
	public function new(ptimer : Int) 
	{
		super();
		money = 1500 ;
		nbReplay = 0 ;
		timer = ptimer ;
		//init array for storing units to deploy
		unitsToDeploy = new Array< List<UnitPlacement> >() ;
		var i : Int = 0 ;
		while (i < 10) 
		{
			unitsToDeploy.push(new List<UnitPlacement>());
			i ++ ;
		}
	}
	
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