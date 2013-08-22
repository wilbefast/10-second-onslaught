import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

@:font("KatamotzIkasi.ttf") class DefaultFont extends Font {}

class DefaultTextField extends TextField
{
	public function new (_text : String, _x : Float, _y : Float) 
	{
		super();

		Font.registerFont (DefaultFont);

		var format = new TextFormat ("Katamotz Ikasi", 32, 0x7A0026);

		defaultTextFormat = format;
		embedFonts = true;
		selectable = false;

		x = _x;
		y = _y;
		width = 200;

		text = _text;
	}
}