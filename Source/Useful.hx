class Useful
{
	public static function sign(x : Float) : Int
	{
		if(x > 0)
			return 1;
		else if (x < 0)
			return -1;
		else
			return 0;
	}

	public static inline function sqr(x : Float) : Float
	{
		return (x*x);
	}

	public static function distance2(a : { x : Float, y : Float}, b : { x : Float, y : Float})
	{
		return (Useful.sqr(a.x - b.x) + Useful.sqr(a.y - b.y));
	}

	public static function distance(a : { x : Float, y : Float}, b : { x : Float, y : Float})
	{
		return (Math.sqrt(distance2(a, b)));
	}
}