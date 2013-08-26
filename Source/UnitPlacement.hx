import flash.display.Sprite;

class UnitPlacement extends GameObject
{
	public var unitType : UnitType ;
	
	public function new(punitType : UnitType, px : Float, py : Float) 
	{
		super(px, py);

		unitType = punitType ;
		
		trace("hello UNITPLACEMENT");

		graphics.beginFill(0x00FF00);
		graphics.drawCircle(0, 0, 32);
	}
	
}