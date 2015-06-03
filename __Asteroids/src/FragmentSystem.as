package  
{
	import flash.display.Sprite;
	import flash.events.Event
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class FragmentSystem extends Sprite
	{
		private var _game:Game;
		private var _fragmentsToSpawn:Number;
		private var _stageHeight:int;
		private var _stageWidth:int;
		private var _spawned:Boolean = false;
		private var _positions:Array = [];
		
		public function FragmentSystem(game:Game, spawnThisManyFragments:Number = 3) {
			if (spawnThisManyFragments <= 0) {
				trace("You're spawning " + spawnThisManyFragments + " fragments! Feeding a value equal to 0 or lower can cause errors.");
				//Just to be safe.
			}
			if (spawnThisManyFragments >= 20 ) {
				trace("You are spawning a lot of fragments! This could cause an infinite loop you know.");
			}
			_game = game;
			_fragmentsToSpawn = spawnThisManyFragments;
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function generatePoint():Point {
			var i:Point = new Point(Math.random() * _stageWidth, Math.random() * _stageHeight);
			
			if (i.x < 10) {
				i.x = 20;
			} else if (i.x > _stageWidth - 10) {
				i.x = _stageWidth - 20;
			}
			
			if (i.y < 5) {
				i.y = 10;
			} else if ( i.y > _stageHeight - 5) {
				i.y = _stageHeight - 10;
			}
			return i;
		}
		
		private function clone(i:Fragment):Fragment {
			var newI:Fragment = new Fragment(i.ID, new Point(i.x, i.y));
			return newI;
		}
		
		private function _init(e:Event):void {
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if(!_spawned) {
				for (var i:int = 0; i < _fragmentsToSpawn; i++) {
					var p:Point = generatePoint();
					
					_spawnFragment(new Point(x, y), i);
				}
			}
			_spawned = true;
		}
		
		public function resetFragments():void {
			_game.collectedFragments = 0;
			for (var i:int = _game.spawnThisManyFragments - 1; i > 0; i--) {
				var fragment:Fragment = _game.fragments.fragmentsBackup[i];
				removeChild(fragment);
				_game.fragments.splice(fragment);
			}
			
			_game.fragments = _game.fragmentsBackup;
			
			for (var i2:int = _game.spawnThisManyFragments - 1; i2 > 0; i2--) {
				var fragment2:Fragment = _game.fragments.fragmentsBackup[i2];
				addChild(fragment2);
			}
		}
		
		private function _spawnFragment(pos:Point, id:int):void {
			var newP:Point;
			
			for (var i:int = 0; i < _positions.length; i++) {
				var errori:int = 10;
				if (!Point.distance(pos, _positions[i]) > 100) {
					while (errori > 0) {
						newP = generatePoint();
						trace(Point.distance(newP, _positions[i]) + " --- " + i + " --- " + id);
						if (Point.distance(newP, _positions[i]) > 100) {
							break;
						}
						errori--;
					}
					pos = newP;
				}
			}
			
			var fragment:Fragment = new Fragment(id, pos);
			var fragmentClone:Fragment = clone(fragment);
			_positions.push(pos);
			
			_game.fragments.push(fragment);
			_game.fragmentsBackup.push(fragmentClone);
			addChild(fragment);
		}
	}

}