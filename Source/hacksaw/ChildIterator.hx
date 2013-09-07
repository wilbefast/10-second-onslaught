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

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;

class ChildIterator
{
	private var container : DisplayObjectContainer;
	private var condition : DisplayObject->Bool;
	private var nextIndex : Int = 0;

	public function new(_container : DisplayObjectContainer, ?_condition : DisplayObject->Bool)
	{
		container = _container;
		condition = _condition;
		flushNextMatching();
	}

	private function flushNextMatching() : Void
	{
		while(nextIndex < container.numChildren 
		&& (condition != null) && !condition(container.getChildAt(nextIndex)))
			nextIndex++;
	}

	public function hasNext() : Bool
	{
    return (nextIndex < container.numChildren);
  }

  public function next() : DisplayObject
  {
  	var result = container.getChildAt(nextIndex++);
    flushNextMatching();
    return result;
  }
}