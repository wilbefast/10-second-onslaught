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

class Scene extends Sprite 
{
	// ---------------------------------------------------------------------------
	// CONSTRUCTOR
	// ---------------------------------------------------------------------------

	public function new () 
	{
		super ();
	}

	// ---------------------------------------------------------------------------
	// SCENE CALLBACKS
	// ---------------------------------------------------------------------------

	public function onEnter(previous : Scene) : Void 
	{
		// override me !
	}

	public function onExit(next : Scene) : Void 
	{
		// override me !
	}

	// ---------------------------------------------------------------------------
	// OPENFL CALLBACKS
	// ---------------------------------------------------------------------------

	public function onResize(event : Event) : Void
	{
		// override me !
	}

	public function onFrameEnter(event : Event) : Void
	{
		// override me !
	}

	public function onMouseOver(event : MouseEvent) : Void
	{
		// override me !
	}

	public function onMouseDown(event : MouseEvent) : Void
	{
		// override me !
	}

	public function onMouseUp(event : MouseEvent) : Void
	{
		// override me !
	}
	
	public function onMouseClick(event : MouseEvent) : Void
	{
		// override me !
	}
}