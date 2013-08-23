import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.events.Event;
import flash.events.MouseEvent;


class EvacuateScene extends Scene 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();

		// draw a shape
		graphics.beginFill(0x00FF00);
		graphics.drawRect(100, 50, 200, 200);

		addChild (new DefaultTextField("Save the colonies!", 200, 200));

	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public override function onEnter(previous : Scene) : Void 
	{
		GameObjectManager.purgeAll();


		var spawn_width = 400; // TODO - get from stage.stageWidth
		var spawn_height = 300; // TODO - get from stage.stageWidth

		// create zerglings
		for(i in 0 ... 30)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Zergling((1 + Math.cos(spawn_angle))*spawn_width, 
										(1 + Math.sin(spawn_angle))*spawn_height);
		}

		// create marines
		for(i in 0 ... 10)
		{
			var spawn_angle = Math.random()*Math.PI*2;
			new Marine((3 + Math.cos(spawn_angle))*spawn_width/3, 
										(3 + Math.sin(spawn_angle))*spawn_height/3);
		}
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
		// SceneManager.setScene("Deploy");
	}
}