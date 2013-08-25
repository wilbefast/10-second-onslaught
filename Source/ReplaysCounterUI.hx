import flash.net.drm.DRMManagerSession;
import flash.text.TextField;
import flash.text.TextFormat;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

class ReplaysCounterUI extends Sprite
{
	// ---------------------------------------------------------------------------
	// LOAD ASSETS
	// ---------------------------------------------------------------------------

	private static var initialised : Bool = false;

	private static var bitmapData : BitmapData;
	
	private static var session_attribut : Session;
	
	private static var nbReplay : Int;

	private static function init() : Void
	{
		bitmapData = Assets.getBitmapData("assets/GUI_fond_replay_01.png");
		initialised = true;
	}

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------


	public function new(session : Session)
	{
		if(!initialised)
			init();

		super();
		
		addChild(new Bitmap(bitmapData));
		
		session_attribut = session;
		nbReplay = session_attribut.getNbReplay();
		
		Font.registerFont(DefaultFont);
		
		var format = new TextFormat("Katamotz Ikasi", 30, 0x7A0026);
		var textField = new TextField();
		
		textField.defaultTextFormat = format;
		textField.embedFonts = true;
		textField.selectable = false;
		
		textField.x = 200;
		textField.y = 5;
		textField.width = 50;
		textField.height = 30;
		
		textField.text = "7";

		addChild(textField);
	}
}