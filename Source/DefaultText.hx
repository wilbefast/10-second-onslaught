import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

@:font("KatamotzIkasi.ttf") class DefaultFont extends Font 
{
	private static inline var TEXT_COLOUR = 0x7A0026;
	private static inline var TEXT_SIZE = 32;

	public static var format = new TextFormat("Katamotz Ikasi", TEXT_SIZE, TEXT_COLOUR);

	public static function __init__()
	{
		Font.registerFont (DefaultFont);
	}
}

class DefaultTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String, _x : Float, _y : Float) 
	{
		super();

		defaultTextFormat = DefaultFont.format;

		embedFonts = true;
		selectable = false;

		x = _x;
		y = _y;
		width = FIELD_WIDTH;

		text = _text;
	}
}