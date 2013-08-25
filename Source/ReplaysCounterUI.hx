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
	
	private var session_attribut : Session;
	
	private var nbReplay : Int;
	
	private var textField : TextField;

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
		
		var background = new Bitmap(bitmapData);
		addChild(background);
		
		session_attribut = session;
		nbReplay = session_attribut.getNbReplay();
		textField = new DefaultTextField("Attempt #" + nbReplay);
		textField.height = background.height;
		addChild(textField);
	}
	
	public function update()
	{
		nbReplay = session_attribut.getNbReplay();
		textField.text = "Attempt #" + nbReplay ;
	}
}