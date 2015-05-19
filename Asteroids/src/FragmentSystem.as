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
			_game = game;
			_fragmentsToSpawn = spawnThisManyFragments;
			addEventListener(Event.ADDED_TO_STAGE, _init);
		}
		
		private function generateX():int {
			var x:int = Math.random() * _stageWidth;
			if (x < 10) {
				x = 20;
			} else if (x > _stageWidth - 20) {
				x = _stageWidth - 40;
			}
			return x;
		}
		
		private function generateY():int {
			var y:int = Math.random() * _stageHeight;
			if (y < 5) {
				y = 10;
			} else if (y > _stageHeight - 10) {
				y = _stageWidth - 10;
			}
			return y;
		}
		
		private function _init(e:Event):void {
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			if(!_spawned) {
				for (var i:int = 0; i < _fragmentsToSpawn; i++) {
					var x:int = generateX();
					var y:int = generateY();
					
					_spawnFragment(new Point(x, y), i);
				}
			}
			_spawned = true;
		}
		
		private function _spawnFragment(pos:Point, id:int):void {
			var fragment:Fragment = new Fragment(id);
			_positions.push(pos);
			
			var x:int = pos.x;
			var y:int = pos.y;
			
			for (var Xi:int = 0; Xi < _positions.length; Xi++) {
				var Xpassed:Boolean = false;
				while(!Xpassed) {
					if (x <= _positions[Xi].x + 40 && x >= _positions[Xi].x -40) {
						x = generateX();
					} else {
						Xpassed = true;
					}
				}
			}
			
			for (var Yi:int = 0; Yi < _positions.length; Yi++) {
				var Ypassed:Boolean = false;
				while(!Ypassed){
					if (y <= _positions[Yi].y + 40 && y >= _positions[Yi].y -40) {
						y = generateY();
					} else {
						Ypassed = true;
					}
				}
			}
			
			fragment.x = x;
			fragment.y = y;
			Game(parent).fragments.push(fragment); Game(parent).fragmentsBackup.push(fragment);
			addChild(fragment);
		}
	}

}