package units;

import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import openfl.Assets;
import flash.events.MouseEvent;
import flash.events.Event;

import motion.Actuate;
import motion.easing.Quad;

import hacksaw.GameObject;
import hacksaw.DefaultTextField;

class UnitPlacement extends GameObject
{

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------
	
	public var unitType : UnitType;
	public var timeToAppear : Int;
	
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