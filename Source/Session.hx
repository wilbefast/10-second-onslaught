import flash.display.Sprite;

class Session extends Sprite
{
	private var money : Int;
	private var nbReplay : Int;
	private var timer : Int ;
	
	public function new(ptimer : Int) 
	{
		super();
		money = 1500 ;
		nbReplay = 0 ;
		timer = ptimer ;
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
}