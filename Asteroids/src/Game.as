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
		private var _enemyspawner	: 	EnemySpawnManager;
		private var _player:Player = new Player();
		private var _enemy: Enemy = new Enemy();
		private var _enemies:Array;
		public static const DEATH:String = "death";
		
		public function get enemies():Array
		{
			return _enemies;
		}
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_enemies = new Array();
		
			_enemyspawner = new EnemySpawnManager(this);
			addChild(_enemyspawner);
			addChild(_player);
			
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event):void 
		{
			//var l:int = _enemies.length;
			var b:int = _player.bullets.length;
			for (var i:int = enemies.length -1; i >= 0; i--)
			{
				var enemy:Enemy = enemies[i] as Enemy;
				enemy.EnemyFollow(_player);
				
				if (_player.hitTestObject(enemy))
				{
					_player.damage(1);
					if (_player.isDead)
					{
						dispatchEvent(new Event(DEATH, true));
					}
				}
				
				var isHit:Boolean = false;
				for each(var bull:Bullet in _player.bullets)
				{
					if (bull.hitTestObject(enemy))
					{	
						isHit = true;
					}
				}				
				if (isHit)
				{
					trace("try to remove " + enemy);
					var index:int = enemies.indexOf(enemy);
					removeChild(enemy);
					enemies.splice(index, 1);
				}
				
			}
		}
	}
}