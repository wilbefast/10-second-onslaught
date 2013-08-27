import flash.Lib;
import flash.display.Sprite;
import flash.system.System;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.media.Sound;
import flash.media.SoundChannel;

import openfl.Assets;



class Main extends Sprite
{
	private static inline var TIMER : Int = 10 ;
	private static inline var MONEY : Int = 15000 ;

	private var snd_music : Sound;
	private var channel : SoundChannel;

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super();

		DefaultFont.load();

		UnitType.init();

		SceneManager.add("Title", new TitleScene());
		SceneManager.add("Game", new GameScene(TIMER, MONEY));
		SceneManager.add("Victory", new VictoryScene());

		snd_music = Assets.getSound("assets/music.mp3"); // flash doesn't like OOG :'(

		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyboard);

		// start music
		//channel = snd_music.play();
		//channel.addEventListener(Event.SOUND_COMPLETE, onMusicEnd);
	}

	private function onMusicEnd(event : Event) : Void
	{
		channel = snd_music.play();
		channel.addEventListener(Event.SOUND_COMPLETE, onMusicEnd);
	}

	private function onKeyboard(event : KeyboardEvent) : Void
	{
		if(event.keyCode == 27) // exit
			System.exit(0);
	}
}