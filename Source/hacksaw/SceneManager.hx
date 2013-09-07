/* 
'Hacksaw' game library for Haxe / OpenFL
(C) Copyright 2013 William Dyce

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 3 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
*/

package hacksaw;

import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import haxe.ds.GenericStack;
import haxe.ds.StringMap;

class SceneManager extends Sprite 
{
	// ---------------------------------------------------------------------------
	// SINGLETON
	// ---------------------------------------------------------------------------

	// protected constructor

	private function new()
	{
		super();

		byName = new StringMap<Scene>();
		// add to draw list
		Lib.current.stage.addChild(this);
		// events
		Lib.current.stage.addEventListener(Event.RESIZE, function(event) { current.onResize(event); } );
		Lib.current.stage.addEventListener(Event.ENTER_FRAME, function(event) { current.onFrameEnter(event); } );
		// mouse events
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_OVER, function(event) { current.onMouseOver(event); } );
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, function(event) { current.onMouseDown(event); } );
		Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, function(event) { current.onMouseUp(event); } );
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(event) { current.onMouseClick(event); } );

	}

	private static var instance : SceneManager;

	private static function get()
	{
		if(instance == null)
			instance = new SceneManager();
		return instance;
	}

	// shortcut static functions

	public static function setScene(newSceneName : String) : Void
	{
		get().__setScene(newSceneName);
	}

	public static function add(newSceneName : String, newScene : Scene)
	{
		return get().__add(newSceneName, newScene);
	}

	public static function push(newSceneName : String)
	{
		return get().__push(newSceneName);
	}

	public static function pop()
	{
		return get().__pop();
	}


	// ---------------------------------------------------------------------------
	// SCENE SWITCHING
	// ---------------------------------------------------------------------------

	private var current : Scene;

	private function __setSceneObject(newScene : Scene) : Void
	{
		current.onExit(newScene);
		removeChild(current);

		addChild(newScene);
		newScene.onEnter(current);

		current = newScene;
	}

	private function __setScene(newSceneName : String) : Void
	{
		if(byName.exists(newSceneName))
			__setSceneObject(byName.get(newSceneName));
		else
			trace("Invalid scene name '" + newSceneName + "' passed to SceneManager::setScene");
	}

	// ---------------------------------------------------------------------------
	// SCENES BY NAME
	// ---------------------------------------------------------------------------

	private var byName : StringMap<Scene> ;

	private function __add(newSceneName : String, newScene : Scene)
	{
		byName.set(newSceneName, newScene);
		if(current == null)
		{
			addChild(newScene);
			newScene.onEnter(current);
			current = newScene;
		}
	}

	// ---------------------------------------------------------------------------
	// SCENES BY STACK OF NAMES
	// ---------------------------------------------------------------------------

	private var stack : GenericStack<Scene>;

	private function __push(sceneName : String)
	{
		if(byName.exists(sceneName))
			stack.add(byName.get(sceneName));
		else
			trace("Invalid scene name '" + sceneName + "' passed to SceneManager::push");
	}

	private function __pop()
	{
		if(stack.isEmpty())
			trace("Nothing to pop from stack in SceneManager::pop");
		else
			__setSceneObject(stack.pop());
	}
}