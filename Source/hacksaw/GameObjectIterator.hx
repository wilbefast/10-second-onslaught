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

class GameObjectIterator
{
  private var iterator: Iterator<Dynamic>;
  private var nextMatching : GameObject = null;

  public function new(_iterator : Iterator<Dynamic>)
  {
    iterator = _iterator;
    flushNextMatching();
  }

  private function flushNextMatching() : Void
  {
    do 
    {
      nextMatching = (iterator.hasNext() ? iterator.next() : null);
    }
    while(nextMatching != null && !Std.is(nextMatching, GameObject));
  }

  public function hasNext() 
  {
    return(nextMatching != null);
  }

  public function next()   
  {
    var result = nextMatching;
    flushNextMatching();
    return result;
  }
}