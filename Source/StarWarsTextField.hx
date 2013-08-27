import flash.text.TextField;

class StarWarsTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String) 
	{
		super();

		defaultTextFormat = DefaultFont.formatBigWhite;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		text = _text;
	}
}