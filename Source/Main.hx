import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

import flash.media.Sound;
import flash.media.SoundChannel;

import openfl.Assets;

class Main extends Sprite
{
	private static inline var TIMER : Int = 10 ;

	private var snd_music : Sound;
	private var channel : SoundChannel;

	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super();

		DefaultFont.load();

		SceneManager.add("Title", new TitleScene());
		SceneManager.add("Game", new GameScene(TIMER));

		snd_music = Assets.getSound("assets/music.mp3"); // flash doesn't like OOG :'(

		// start music
		//channel = snd_music.play();
		//channel.addEventListener(Event.SOUND_COMPLETE, onMusicEnd);
	}

	private function onMusicEnd(event : Event) : Void
	{
		channel = snd_music.play();
		channel.addEventListener(Event.SOUND_COMPLETE, onMusicEnd);
	}
}