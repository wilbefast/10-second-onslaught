import flash.text.TextField;

class DefaultTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String, _x : Float, _y : Float) 
	{
		super();

		defaultTextFormat = DefaultFont.format;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		x = _x;
		y = _y;
		width = FIELD_WIDTH;

		text = _text;
	}
}