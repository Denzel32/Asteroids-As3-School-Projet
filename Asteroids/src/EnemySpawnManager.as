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
		private var _spawnTimer		: 	Timer 		= new Timer(5000, 0);
		private var _enemyPerWave	: 	int			= 2;
		private var _maxEnemies		: 	int			= 10;
		private var _hasSpawned		:	Boolean;
		private var _game			:	Game;
		private var _stageWidth		:	int;
		private var _stageHeight	:	int;
		
		public function EnemySpawnManager(game:Game)
		{
			_game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_stageWidth = stage.stageWidth;
			_stageHeight = stage.stageHeight;
			addEventListener(Event.ENTER_FRAME, update);
			_spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemyWaves);
			_spawnTimer.start();
			addEventListener(Game.DEATH, stopSpawning);
		}
		
		private function stopSpawning():void {
			removeEventListener(Game.DEATH, stopSpawning);
			_spawnTimer.stop();
		}
		
		private function spawnEnemyWaves(e:TimerEvent):void 
		{
			for (var i: int = 0; i < _enemyPerWave; i++)
			{	
				var _enemy:Enemy = new Enemy();
				
				_game.enemies.push(_enemy);
				Game(parent).addChild(_enemy);
				_enemy.x = Math.random() * _stageWidth;
				_enemy.y = Math.random() * _stageHeight;
				_hasSpawned = true;
			}
		}
		private function update(e:Event):void 
		{	
			if (_hasSpawned)
			{
				_enemyPerWave++;
				//trace("enemy per wave has gone up by one and now is: " + _enemyPerWave);
				_hasSpawned = false;
			}
			
			if (_enemyPerWave > _maxEnemies)
			{
				_enemyPerWave = _maxEnemies;
			}
		}
	}
}