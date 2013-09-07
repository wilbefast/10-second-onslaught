import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.events.MouseEvent;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

class UnitPlacement extends GameObject
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	public var unitType : UnitType;
	public var timeToAppear : Int;

	private var cancel : Bitmap;
	
	public function new(_unitType : UnitType, px : Float, py : Float, _timeToAppear : Int) 
	{
		super(px, py);

		// initialise attributes
		unitType = _unitType;
		timeToAppear = _timeToAppear;
		
		// bitmap image
		var placeholder_bitmap = new Bitmap(unitType.placeholder);
		placeholder_bitmap.x = -placeholder_bitmap.width / 2;
		placeholder_bitmap.y = -placeholder_bitmap.height / 2;
		addChild(placeholder_bitmap);
		
		// timestamp text
		var textTimeToAppear = new DefaultTextField("" + timeToAppear);
		textTimeToAppear.mouseEnabled = false;
		addChild(textTimeToAppear);	

		// cancel button
		cancel = new Bitmap(unitType.icon_cancel);
		cancel.x = -cancel.width/2;
		cancel.y = -cancel.height/2;
		cancel.alpha = 0;
		addChild(cancel);
		
		// hitbox
		graphics.beginFill(0xFFFFFF, 0);
		graphics.drawCircle(0, 0, 32);
	}

	// ---------------------------------------------------------------------------
	// CANCEL
	// ---------------------------------------------------------------------------

	private var previousDestroyRequest : Bool = false;

	public function requestDestroy()
	{
		if(previousDestroyRequest)
			Actuate.tween(this, 0.3, { alpha : 0 }, true)
					.ease (Quad.easeOut)
					.onComplete(function() purge = true);
		else
		{		
			previousDestroyRequest = true;
			Actuate.tween(cancel, 0.3, { alpha : 1 }, true)
						.ease (Quad.easeOut);
		}
	}

	public function cancelDestroy()
	{
		previousDestroyRequest = false;
		Actuate.tween(cancel, 0.3, { alpha : 0 }, true)
					.ease (Quad.easeOut);
	}
	
	// ---------------------------------------------------------------------------
	// INSTANTIATE
	// ---------------------------------------------------------------------------
		
	public function instantiate() : Unit
	{
		return (unitType.instantiate(x, y));
	}
}