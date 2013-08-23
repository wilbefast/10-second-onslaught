import flash.display.Sprite;

@:generic class SpriteChildIterator<T : Sprite> 
{
	private var sprite : Sprite;
	private var condition : T->Bool;
	private var nextIndex : Int = 0;

	private static function acceptAll(x : T)
	{
		return true;
	}

	public function new(_sprite : Sprite, _condition : T->Bool = acceptAll)
	{
		sprite = _sprite;
		flushNextMatching();
	}

	private function flushNextMatching() : Void
	{
		while(nextIndex < sprite.numChildren)
		{
			var s : Sprite = sprite.getChildAt(nextIndex);
			if(Std.is(s, T) && condition(cast(s, T)))
				break;
			else
				nextIndex++;
		}
	}


	public function hasNext() : Bool
	{
    return (nextIndex < sprite.numChildren);
  }

  public function next() : T
  {
  	var result = cast(sprite.getChildAt(nextIndex), T);
    flushNextMatching();
    return result;
  }
}

// class GameObjectIterator
// {
// 	private var iterator: Iterator<GameObject>;
// 	private var condition : GameObject->Bool;
// 	private var nextMatching : GameObject = null;

// 	public function new(_iterator : Iterator<GameObject>, )
// 	{
// 		trace("Created GameObjectIterator");
// 		iterator = _iterator;
// 		condition = _condition;
		
// 		flushNextMatching();
// 	}

// 	private function flushNextMatching() : Void
// 	{
// 		trace(iterator.hasNext());

// 		do 
// 		{
// 			nextMatching = (iterator.hasNext() ? iterator.next() : null);
// 		}
// 		while(nextMatching != null && !condition(nextMatching));
// 	}

// 	public function hasNext() 
// 	{
//     return(nextMatching != null);
//   }

//   public function next() 	
//   {
//     var result = nextMatching;
//     flushNextMatching();
//     return result;
//   }
// }