import flash.display.Sprite;
import flash.display.Bitmap;

class UnitPlacement extends GameObject
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	public var unitType : UnitType ;
	public var timeToAppear : Int ;
	
	public function new(punitType : UnitType, px : Float, py : Float, ptime : Int) 
	{
		super(px, py);

		unitType = punitType ;
		timeToAppear = ptime ;
		
		// bitmap image
		var placeholder_bitmap = new Bitmap(unitType.placeholder);
		placeholder_bitmap.x = -placeholder_bitmap.width / 2;
		placeholder_bitmap.y = -placeholder_bitmap.height / 2;
		addChild(placeholder_bitmap);
		
		// timestamp text
		var textTimeToAppear = new DefaultTextField("" + timeToAppear);
		textTimeToAppear.mouseEnabled = false;
		addChild(textTimeToAppear);	

		// hitbox
		graphics.beginFill(0xFFFFFF, 0);
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