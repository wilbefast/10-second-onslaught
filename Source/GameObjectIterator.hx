class GameObjectIterator
{
  private var iterator: Iterator<Dynamic>;
  private var nextMatching : GameObject = null;

  public function new(_iterator : Iterator<Dynamic>)
  {
    iterator = _iterator;
    flushNextMatching();
  }

  private function flushNextMatching() : Void
  {
    do 
    {
      nextMatching = (iterator.hasNext() ? iterator.next() : null);
    }
    while(nextMatching != null && !Std.is(nextMatching, GameObject));
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