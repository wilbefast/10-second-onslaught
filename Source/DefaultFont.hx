import flash.text.Font;
import flash.text.TextFormat;

@:font("arial.ttf") class DefaultFont extends Font 
{
	private static inline var TEXT_COLOUR = 0x7A0026;
	private static inline var TEXT_SIZE = 32;

	public static var format;

	public static function load()
	{
		Font.registerFont (DefaultFont);
		format = new TextFormat("Arial", TEXT_SIZE, TEXT_COLOUR);
	}
}