package spawnmanagers {
	import screens.Game;
	import flash.display.Sprite;
	import flash.events.Event
	import flash.geom.Point;
	import items.Fragment;
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
		private var _spawnedFragments:int = 0;
		private var _spawningMethod:int;
		private var _positions:Array = [];
		private var _cleansed:Boolean = false;
		
		public function FragmentSystem(game:Game, spawnThisManyFragments:Number = 3, spawningMethod:int = 0) {
			if (spawnThisManyFragments <= 0) {
				trace("You're spawning " + spawnThisManyFragments + " fragments! Feeding a value equal to 0 or lower can cause errors.");
				//Just to be safe.
			}
			if (spawnThisManyFragments >= 20 ) {
				trace("You are spawning a lot of fragments! This could cause an infinite loop you know.");
			}
			_game = game;
			_fragmentsToSpawn = spawnThisManyFragments;
			_spawningMethod = spawningMethod;
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function generatePoint():Point {
			var i:Point = new Point(Math.random() * _stageWidth, Math.random() * _stageHeight);
			return i;
		}
		
		private function getDist(i:Point, j:Point):Number {
			return Point.distance(i, j);
		}
		
		private function insideStage(i:Point):Point {
			if (i.x <= 10) {
				i.x = 20;
			} else if (i.x > _stageWidth - 10) {
				i.x = _stageWidth - 20;
			}
			
			if (i.y <= 5) {
				i.y = 10;
			} else if ( i.y > _stageHeight - 5) {
				i.y = _stageHeight - 10;
			}
			return i;
		}
		
		public function cleanUp():void {
			if (!_cleansed) {
				_cleansed = true;
				trace("cleanup requested@fragmentsystem");
				for (var i:int = 0; i < _game.fragments.length; i++) {
					var fragment:Fragment = _game.fragments[i] as Fragment;
					_game.removeChild(fragment);
					_game.fragments.splice(i, 1);
				}
				trace("cleanup done@fragmentsystem");
			}
		}
		
		private function clone(i:Fragment):Fragment {
			var newI:Fragment = new Fragment(i.game,new Point(i.x, i.y));
			return newI;
		}
		
		private function _init(e:Event):void {
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if(!_spawned && _spawningMethod == 0) {
				for (var i:int = 0; i < _fragmentsToSpawn; i++) {
					var p:Point = generatePoint();
					
					_spawnFragment(p);
				}
			}
			_spawned = true;
		}
		
		public function _dropFragment(pos:Point):void {
			trace("fragment drop requested");
			if (_spawnedFragments < _fragmentsToSpawn) {
				
				var fragment:Fragment = new Fragment(_game,pos);
				_spawnedFragments++;
				
				
				_game.fragments.push(fragment);
				_game.addChild(fragment);
				trace("fragment dropped succesfully");
			} else {
				trace("fragment drop call was ignored because already max");
			}
		}
		
		private function _spawnFragment(pos:Point):void {
			var playerPos:Point = Game(parent).playerSpawnPosition;
			var newP:Point;
			for (var i:int = 0; i < _positions.length; i++) {
				var errori:int = 10;				
				while (errori > 0) {
					newP = insideStage(generatePoint());
					if (getDist(newP, _positions[i]) > 300) {
						if (getDist(newP, playerPos) > 500) {
							break;
						}
					}
					errori--;
					pos = newP;
				}
			}
			
			var fragment:Fragment = new Fragment(_game,pos);
			_positions.push(pos);
			
			_game.fragments.push(fragment);
			_game.addChild(fragment);
		}
	}

}