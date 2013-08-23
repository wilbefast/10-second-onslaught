class V2
{
	public var x : Float;
	public var y : Float;

	public function new(_x : Float, _y : Float)
	{
		x = _x;
		y = _y;
	}

	public inline function normalised() : V2
	{
		var norm = getNorm();
		return new V2(x / norm, y / norm);
	}

	public inline function normalise() : V2
	{
		var norm = getNorm();
		x /= norm;
		y /= norm;
		return this;
	}

	public inline function getNorm() : Float
	{
		return (Math.sqrt(getNorm2()));
	}

	public inline function getNorm2() : Float
	{
		return (Useful.sqr(x) + Useful.sqr(y));
	}
}