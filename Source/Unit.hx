class Unit extends GameObject 
{
	public var hitpoints : Int;

	public function new(_x : Float, _y : Float, _radius : Float = 0, _hitpoints : Int = 100) : Void
	{
		super(_x, _y, _radius);

		hitpoints = _hitpoints;
	}

	// ---------------------------------------------------------------------------
	// UPDATE
	// ---------------------------------------------------------------------------

	public override function update(dt : Float) : Void
	{

		// check for death
		if(hitpoints <= 0)
			purge = true;
	}

	// ---------------------------------------------------------------------------
	// COLLISIONS
	// ---------------------------------------------------------------------------

	public override function onCollisionWith(other : GameObject) : Void
	{
		// repulse
		if(Std.is(other, Unit))
		{
			// repulsion vector
			var repulse = new V2(x - other.x, y - other.y);
			x += repulse.x * Time.getDelta();
			y += repulse.y * Time.getDelta();
		}
	}
}
