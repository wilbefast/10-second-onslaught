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

		// DEBUG draw collider
		graphics.beginFill(0x000000);
		graphics.drawCircle(0, 0, radius);
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
		return 
			(Useful.distance2(x, y, other.x, other.y) < Useful.sqr(radius + other.radius));
	}

	public function onCollisionWith(other : GameObject) : Void
	{
		trace("GameObject::onCollisionWith");
		// override me !
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public function onPurge() : Void
	{
		// override me !
	}
}
