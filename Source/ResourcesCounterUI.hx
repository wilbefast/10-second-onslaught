import flash.net.drm.DRMManagerSession;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;


class ResourcesCounterUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;
	
	private var session_attribut : Session;

	private var money : Int;
	
	private var textField : TextField;
	
	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/GUI2_bloc_money.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------


	public function new( session : Session)
	{
		if(!initialised)
			init();

		super();

		addChild(new Bitmap(bitmapData));
		
		session_attribut = session;
		money = session_attribut.getMoney();
		textField = new DefaultTextField("" + money);
		textField.defaultTextFormat = DefaultFont.formatWhite ;
		addChild(textField);
	}
	
	public function update()
	{
		money = session_attribut.getMoney();
		textField.text = "" + money ;
	}
}