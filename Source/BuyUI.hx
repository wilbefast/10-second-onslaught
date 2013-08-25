import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.MouseEvent;

import haxe.ds.StringMap;

class BuyUI extends Sprite
{
	
private var unit : UnitType;
private var unitCount : Int;
private var unitCost : Int;
private var money : Int;
private var session_attribut : Session;
	
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var background_data : BitmapData;
	private static var up_data : BitmapData;
	private static var down_data : BitmapData;
	private var marine_data : DefaultTextField ;
	private var nuke_data : DefaultTextField ; 
	
	private static function init() : Void
	{
		background_data = Assets.getBitmapData("assets/GUI_fond_achat_01.png");

		up_data = Assets.getBitmapData("assets/GUI_button_up_01.png");
		down_data = Assets.getBitmapData("assets/GUI_button_down_01.png");

		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	private var icon : Sprite;
	private var up : Sprite;
	private var down : Sprite;

	public function new(unitType : UnitType, session : Session)
	{
		super();

		if(!initialised)
			init();
		unitCost = unitType.price;
		session_attribut = session;

		// Build hierarchy
		addChild(new Bitmap(background_data));

		icon = new Sprite();
		icon.addChild(new Bitmap(unitType.icon));
		addChild(icon);

		up = new Sprite();
		up.addEventListener(MouseEvent.CLICK, onMouseClickUp);
		up.addChild(new Bitmap(up_data));
		up.x = icon.x + icon.width;
		up.y = icon.y;
		addChild(up);

		down = new Sprite();
		down.addEventListener(MouseEvent.CLICK, onMouseClickDown);
		down.addChild(new Bitmap(down_data));
		down.x = icon.x + icon.width;
		down.y = icon.y + icon.height - down.height;
		addChild(down);
	}
	
	private function onMouseClickUp (event : MouseEvent) : Void
	{
		if (money>unitCost)
			unitCount = unitCount + 1;
	}
	
	private function onMouseClickDown (event : MouseEvent) : Void
	{
		if (unitCount > 0) 
			unitCount = unitCount - 1;
	}
	
	public function update() : Void
	{
		money = session_attribut.getMoney();
		unitCount = unit.getCount();
	}
}