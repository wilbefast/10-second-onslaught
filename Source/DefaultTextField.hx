import flash.text.TextField;

class DefaultTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String, _x : Float = 0, _y : Float = 0) 
	{
		super();

		defaultTextFormat = DefaultFont.formatRed;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		x = _x;
		y = _y;
		width = FIELD_WIDTH;

		text = _text;
	}
}