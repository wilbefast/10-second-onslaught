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

	public static inline function distance2(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Float
	{
		return (Useful.sqr(x1 - x2) + Useful.sqr(y1 - y2));
	}

	public static inline function distance(x1 : Float, y1 : Float, x2 : Float, y2 : Float) : Float
	{
		return (Math.sqrt(distance2(x1, x2, y1, y2)));
	}
}