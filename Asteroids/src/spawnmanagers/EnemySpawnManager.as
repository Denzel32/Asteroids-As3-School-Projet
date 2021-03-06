package spawnmanagers{
	import screens.Game;
	import characters.Enemy;
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
		private var _spawnTimer		: 	Timer;
		private var _hasSpawned		:	Boolean;
		private var _enemyPerWave	: 	int;
		private var _maxEnemies		: 	int;
		private var _game			:	Game;
		private var _spawnEnemies	:	Boolean = true;
		
		public function EnemySpawnManager(game:Game,difficulty:int, spawnTimerSeconds:int = 3)
		{
			spawnTimerSeconds *= 1000;
			_game = game;
			_enemyPerWave = Math.floor(2 * difficulty);
			_maxEnemies = Math.floor(2 * difficulty);
			_spawnTimer = new Timer(spawnTimerSeconds)
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			_spawnTimer.addEventListener(TimerEvent.TIMER, spawnEnemyWaves);
			_spawnTimer.start();
		}
		
		public function cleanUp():void {
			_spawnEnemies = false;
			_spawnTimer.stop();
			for (var i:int = 0; i < _game.enemies.length; i++) {
				var enemy:Enemy = _game.enemies[i] as Enemy;
				_game.removeChild(enemy);
				_game.enemies.splice(i, 1);
			}
		}
		
		private function spawnEnemyWaves(e:TimerEvent):void 
		{
			if(_spawnEnemies) {
				for (var i: int = 0; i < _enemyPerWave; i++)
				{
					var _enemy:Enemy = new Enemy();
					
					_game.enemies.push(_enemy);
					_game.addChild(_enemy);
					_enemy.x = Math.random() * stage.stageWidth;
					_enemy.y = Math.random() * stage.stageHeight ;
					_hasSpawned = true;
				}
			}
		}
		private function update(e:Event):void 
		{	
			if (_hasSpawned)
			{
				_enemyPerWave++;
				_hasSpawned = false;
			}
			
			if (_enemyPerWave > _maxEnemies)
			{
				_enemyPerWave = _maxEnemies;
			}
		}
	}
}