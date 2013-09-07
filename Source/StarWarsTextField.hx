import flash.text.TextField;

import hacksaw.DefaultTextField;
import hacksaw.DefaultFont;

class StarWarsTextField extends TextField
{

	private static inline var FIELD_WIDTH = 256;

	public function new (_text : String) 
	{
		super();

		defaultTextFormat = DefaultFont.bigWhite;

		embedFonts = true;
		selectable = false;
		wordWrap = true;

		text = _text;
	}
}