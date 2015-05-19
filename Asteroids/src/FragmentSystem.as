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
		
		public function FragmentSystem(game:Game, spawnThisManyFragments:Number = 3) {
			if (spawnThisManyFragments <= 0) {
				trace("You're spawning " + spawnThisManyFragments + " fragments! Feeding a value equal to 0 or lower can cause errors.");
				//Just to be safe.
			}
			_game = game;
			_fragmentsToSpawn = spawnThisManyFragments;
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function _init(e:Event):void {
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if(!_spawned) {
				for (var i:int = 0; i < _fragmentsToSpawn; i++) {
					trace("i: " + i);
					var x:int = Math.random() * _stageWidth;
					var y:int = Math.random() * _stageHeight;
					
					if (x < 10) {
						x = 20;
					} else if (x > _stageWidth - 20) {
						x = _stageWidth - 40;
					}
					
					if (y < 5) {
						y = 10;
					} else if (y > _stageHeight - 10) {
						y = _stageWidth - 10;
					}
					_spawnFragment(new Point(x, y), i);
				}
			}
			_spawned = true;
		}
		
		private function _spawnFragment(pos:Point, id:int):void {
			var fragment:Fragment = new Fragment(id);
			fragment.x = pos.x;
			fragment.y = pos.y;
			Game(parent).fragments.push(fragment); Game(parent).fragmentsBackup.push(fragment);
			addChild(fragment);
		}
	}

}