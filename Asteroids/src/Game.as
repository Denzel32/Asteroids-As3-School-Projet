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
		private var _player:Player = new Player();
		private var _enemy: Enemy = new Enemy();
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("game added");
			addChild(_enemyspawner);
			addChild(_player);
			addChild(_enemy);
		}
		
		private function Update(e:Event):void 
		{
			_enemy.EnemyFollow(_player);
		}
		
	}

}