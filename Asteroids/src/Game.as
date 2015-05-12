package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Game extends Sprite 
	{	
		private var _enemyspawner	: 	EnemySpawnManager = new EnemySpawnManager();
		private var _enemy: Enemy = new Enemy();
		private var _player:Player = new Player();
		private var _bullets:Array = [];
		
		public var bullets:Array = [];
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		public function get getBullets():Array {
			return _bullets;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("game added");
			addChild(_enemyspawner);
			addChild(_player);
		}
		
		private function Update(e:Event):void 
		{
			
			var l:int = _enemyspawner.enemies.length;
			var b:int = bullets.length;
			for (var i:int = l -1; i >= 0; i--)
			{
				var enemy:Enemy = _enemyspawner.enemies[i] as Enemy;
				enemy.EnemyFollow(_player);
				if (_player.hitTestObject(enemy))
				{
					_player.damage(1);
				}
			}
			trace("game: " + bullets);
		}
		
	}

}