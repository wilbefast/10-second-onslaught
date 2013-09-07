/* 
'10 Second Onslaught' OpenFL game
(C) Copyright 2013 William Dyce, Antoine Seilles

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 3 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
*/

import openfl.Assets;

import flash.Lib;
import flash.display.Sprite;
import flash.system.System;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.media.Sound;
import flash.media.SoundChannel;

import units.UnitType;

import scenes.TitleScene;
import scenes.GameScene;
import scenes.VictoryScene;

import hacksaw.Scene;
import hacksaw.SceneManager;
import hacksaw.SoundManager;
import hacksaw.DefaultFont;


class Main extends Sprite
{
	private static inline var TIMER : Int = 10 ;
	private static inline var MONEY : Int = 3000 ;

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

		SoundManager.loadSound("teleport_in");
		SoundManager.setMuted();

		// start music
		// snd_music = Assets.getSound("assets/music.mp3"); // flash doesn't like OOG :'(
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