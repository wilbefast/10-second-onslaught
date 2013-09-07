package units;

import hacksaw.V2;

class Facing
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	private var directions : Array<{ name : String, vector : V2 }>;

	// protected constructor

	private function new()
	{
		directions = new Array<{ name : String, vector : V2 }>();
		directions[0] = { name :  "N", vector : V2.N };
		directions[1] = { name :  "S", vector : V2.S };
		directions[2] = { name :  "E", vector : V2.E };
		directions[3] = { name :  "W", vector : V2.W };
		directions[4] = { name :  "SW", vector : V2.SW };
		directions[5] = { name :  "SE", vector : V2.SE };
		directions[6] = { name :  "NW", vector : V2.NW };
		directions[7] = { name :  "NE", vector : V2.NE };
	}

	private static var instance : Facing;

	private static function get()
	{
		if(instance == null)
			instance = new Facing();
		return instance;
	}

	// shortcut static functions

	public static function which(vector : V2) : String
	{
		return get().__which(vector);
	}

	// ---------------------------------------------------------------------------
	// NAME FROM VECTOR DIRECTION
	// ---------------------------------------------------------------------------

	private function __which(vector : V2) : String
	{
		var best_value = Math.NEGATIVE_INFINITY;
		var best_name = null;

		for (direction in directions)
		{
			var value = V2.dot(vector, direction.vector);
			if(value > best_value)
			{
				best_value = value;
				best_name = direction.name;
			}

		}

		return best_name;
	}
}