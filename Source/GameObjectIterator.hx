class GameObjectIterator
{
	private var iterator: Iterator<GameObject>;
	private var condition : GameObject->Bool;
	private var nextMatching : GameObject = null;

	public function new(iterable : Iterable<GameObject>, _condition : GameObject->Bool)
	{
		iterator = iterable.iterator();
		condition = _condition;
		
		flushNextMatching();
	}

	private function flushNextMatching() : Void
	{
		do 
		{
			nextMatching = (iterator.hasNext() ? iterator.next() : null);
		}
		while(nextMatching != null && !condition(nextMatching));
	}

	public function hasNext() 
	{
    return(nextMatching != null);
  }

  public function next() 	
  {
    var result = nextMatching;
    flushNextMatching();
    return result;
  }
}