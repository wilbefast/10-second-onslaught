import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

@:font("KatamotzIkasi.ttf") class DefaultFont extends Font {}

class DefaultTextField extends TextField
{
	public function new () 
	{
		super();

		Font.registerFont (DefaultFont);

		var format = new TextFormat ("Katamotz Ikasi", 30, 0x7A0026);

		defaultTextFormat = format;
		embedFonts = true;
		selectable = false;

		x = 50;
		y = 50;
		width = 200;

		text = "Hello World";
	}
}