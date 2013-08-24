import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;

import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;

class TitleScene extends Scene 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();

		// draw a shape
		graphics.beginFill(0xFF0000);
		graphics.drawRect(100, 50, 200, 200);

		var title = new Bitmap(Assets.getBitmapData("assets/title.jpg"));
		title.x = 100;
		title.y = 300;
		addChild(title);

		addChild (new DefaultTextField("I am a title: Click to start game", 200, 200));
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onEnter(previous : Scene) : Void 
	{
	}

	public override function onExit(next : Scene) : Void 
	{
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onResize(event : Event) : Void
	{
	}

	public override function onFrameEnter(event : Event) : Void
	{
	}
	
	public override function onMouseClick(event : MouseEvent) : Void
	{
		SceneManager.setScene("Game");
	}
}