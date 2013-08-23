import flash.display.Sprite;

class GameObject extends Sprite 
{
	public var radius : Float;
	public var purge : Bool = false;

	public function new(_x : Float, _y : Float, _radius : Float = 0) : Void
	{
		super();

		// initialise variables
		this.x = _x;
		this.y = _y;
		this.radius = _radius;

		// register object
		GameObjectManager.add(this);

		// draw a shape
		graphics.beginFill(0x000000);
		graphics.drawRect(0, 0, 20, 20);
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public function update(dt : Float) : Void
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public function isCollidingWith(other : GameObject) : Bool
	{
		if(Useful.distance2({x : x, y : y}, {x : other.x, y : other.y}) < Useful.sqr(radius))
			return true;
		else 
			return false;
	}

	public function onCollisionWith(other : GameObject) : Void
	{
		// override me !
	}
}
