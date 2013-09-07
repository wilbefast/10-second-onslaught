package hacksaw;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

class ChildIterator
{
	private var container : DisplayObjectContainer;
	private var condition : DisplayObject->Bool;
	private var nextIndex : Int = 0;

	public function new(_container : DisplayObjectContainer, ?_condition : DisplayObject->Bool)
	{
		container = _container;
		condition = _condition;
		flushNextMatching();
	}

	private function flushNextMatching() : Void
	{
		while(nextIndex < container.numChildren 
		&& (condition != null) && !condition(container.getChildAt(nextIndex)))
			nextIndex++;
	}

	public function hasNext() : Bool
	{
    return (nextIndex < container.numChildren);
  }

  public function next() : DisplayObject
  {
  	var result = container.getChildAt(nextIndex++);
    flushNextMatching();
    return result;
  }
}