class GameObjectIterator
{
	private var iterator: Iterator<GameObject>;
	private var condition : GameObject->Bool;
	private var nextMatching : GameObject = null;

	public function new(_iterator : Iterator<GameObject>, _condition : GameObject->Bool)
	{
		trace("Created GameObjectIterator");
		iterator = _iterator;
		condition = _condition;
		
		flushNextMatching();
	}

	private function flushNextMatching() : Void
	{
		trace(iterator.hasNext());

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