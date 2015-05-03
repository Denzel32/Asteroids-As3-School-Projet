package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class EnemySpawnManager extends Sprite
	{
		private var _spawnTimer		: 	Timer = new Timer(5000, 0);
		private var _hasSpawned		:	Boolean;
		private var _enemyPerWave	: 	int = 2;
		private var _maxEnemies		: 	int = 10;
		private var _enemies		: 	Array = [];
		
		public function EnemySpawnManager()
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			_spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemyWaves);
			_spawnTimer.start();
		}
		
		private function spawnEnemyWaves(e:TimerEvent):void 
		{
			for (var i: int = 0; i < _enemyPerWave; i++)
			{	
				if(enemies.length < 1) {
				var _enemy:Enemy = new Enemy();
				_enemies.push(_enemy);
				addChild(_enemy);
				//_enemy.x = Math.random() * stage.stageWidth;
				//_enemy.y = Math.random() * stage.stageHeight ;
				_hasSpawned = true;
				_enemy.StatIncrease();
				trace("current enemies per wave is: " +_enemyPerWave);
				trace("currently there are " +_enemies.length + " enemies in the array");
				}
			}
		}
		
		public function get enemies():Array
		{
			return _enemies
		}
	
		private function update(e:Event):void 
		{	
			if (_hasSpawned)
			{
				_enemyPerWave++;
				trace("enemy per wave has gone up by one and now is: " + _enemyPerWave);
				_hasSpawned = false;
			}
			
			if (_enemyPerWave > _maxEnemies)
			{
				_enemyPerWave = _maxEnemies;
			}
		}
	}
}