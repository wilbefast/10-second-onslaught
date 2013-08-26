import flash.text.Font;
import flash.text.TextFormat;

@:font("arial.ttf") class DefaultFont extends Font 
{
	private static inline var TEXT_COLOUR = 0x7A0026;
	private static inline var TEXT_COLOUR2 = 0xFFFFFF;
	private static inline var TEXT_SIZE = 32;

	public static var formatRed;
	public static var formatWhite;

	public static function load()
	{
		Font.registerFont (DefaultFont);
		formatRed = new TextFormat("Arial", TEXT_SIZE, TEXT_COLOUR);
		formatWhite = new TextFormat("Arial", TEXT_SIZE, TEXT_COLOUR2);
	}
}