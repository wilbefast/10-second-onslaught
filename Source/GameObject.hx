import flash.display.Sprite;

class GameObject extends Sprite 
{
	public var radius : Float;
	public var purge : Bool = false;

	public var speed : V2;

	public function new(_x : Float, _y : Float, _radius : Float = 0) : Void
	{
		super();

		// initialise variables
		this.x = _x;
		this.y = _y;
		this.radius = _radius;

		speed = new V2(0, 0);

		// register object
		GameObjectManager.add(this);
	}

	// ---------------------------------------------------------------------------
	// POSITION
	// ---------------------------------------------------------------------------

	public function setPosition(newPosition : { x : Float, y : Float}) : Void
	{
		x = newPosition.x;
		y = newPosition.y;
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public function update(dt : Float) : Void
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// RENDER
	// ---------------------------------------------------------------------------

	public function render() : Void
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public function isCollidingWith(other : GameObject) : Bool
	{
		if(other.radius <= 0 || this.radius <= 0)
			return false;
		else
			return 
			(Useful.distance2(x, y, other.x, other.y) < Useful.sqr(radius + other.radius));
	}

	public function onCollisionWith(other : GameObject) : Void
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// ON DESTRUCTION
	// ---------------------------------------------------------------------------

	public var onPurge : Void->Void;
}
