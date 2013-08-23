class V2
{
	public var x : Float;
	public var y : Float;

	public function new(_x : Float, _y : Float)
	{
		x = _x;
		y = _y;
	}

	public inline function normalised() : Void
	{
		var norm = getNorm();
		var result = new V2(x / norm, y / norm);
	}

	public inline function normalise() : Void
	{
		var norm = getNorm();
		x /= norm;
		y /= norm;
	}

	public inline function getNorm()
	{
		return (Math.sqrt(getNorm2()));
	}

	public inline function getNorm2()
	{
		return (Useful.sqr(x) + Useful.sqr(y));
	}
}