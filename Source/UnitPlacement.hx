import flash.display.Sprite;

class UnitPlacement extends Sprite
{
	public var unitType : UnitType ;
	
	public function new(punitType : UnitType, px : Float, py : Float) 
	{
		super();

		unitType = punitType ;
		x = px ;
		y = py ;

		graphics.beginFill(0x00FF00);
		graphics.drawCircle(0, 0, 32);
	}
	
}