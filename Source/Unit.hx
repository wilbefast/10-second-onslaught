class Unit extends GameObject 
{
	public var hitpoints : Int;

	public var target : Unit = null;

	public static inline var TEAM_CIVILLIANS : Int = 0;
	public static inline var TEAM_MARINES : Int = 1;
	public static inline var TEAM_ALIENS : Int = 2;
	public var team : Int;

	public function new(_x : Float, _y : Float, _radius : Float = 0) : Void
	{
		super(_x, _y, _radius);
	}

	// ---------------------------------------------------------------------------
	// TEAMS
	// ---------------------------------------------------------------------------

	public function isEnemy(other : Unit) : Bool
	{
		// override me ! 
		return true;
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
