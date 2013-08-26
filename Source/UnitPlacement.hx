import flash.display.Sprite;

class UnitPlacement extends GameObject
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	public var unitType : UnitType ;
	
	public function new(punitType : UnitType, px : Float, py : Float) 
	{
		super(px, py);

		unitType = punitType ;
		
		if(unitType == UnitType.marine)
			graphics.beginFill(0x00FF00);
		else
			graphics.beginFill(0x0000FF);
		graphics.drawCircle(0, 0, 32);
	}
	
	// ---------------------------------------------------------------------------
	// INSTANTIATE
	// ---------------------------------------------------------------------------
		
	public function instantiate() : Unit
	{
		return (unitType.instantiate(x, y));
	}
}