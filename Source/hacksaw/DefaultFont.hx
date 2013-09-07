package hacksaw;

import flash.text.Font;
import flash.text.TextFormat;

@:font("arial.ttf") class DefaultFont extends Font 
{
	public static var smallWhite : TextFormat;
	public static var bigWhite : TextFormat;
	public static var smallBlack : TextFormat;
	public static var bigBlack : TextFormat;

	public static function load()
	{
		Font.registerFont (DefaultFont);

		smallWhite = new TextFormat("Arial", 16, 0xFFFFFF);
		bigWhite = new TextFormat("Arial", 32, 0xFFFFFF);
		smallBlack = new TextFormat("Arial", 16, 0x000000);
		bigBlack = new TextFormat("Arial", 32, 0x000000);
	}
}