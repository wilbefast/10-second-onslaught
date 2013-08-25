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
	
	private static var session_attribut : Session;

	private static var money : Int;
	
	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/GUI_fond_bank_01.png");
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
		
		Font.registerFont(DefaultFont);
		
		var format = new TextFormat("Katamotz Ikasi", 30, 0x7A0026);
		var textField = new TextField();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.x = 50;
		textField.y = 50;
		textField.width = 200;
		
		textField.text = "Money : " + money ;
		
		addChild (textField);
	}
}