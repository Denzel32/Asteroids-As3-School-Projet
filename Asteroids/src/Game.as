package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Game extends Sprite 
	{	
		private var _enemyspawner	: 	EnemySpawnManager;
		private var _player			:	Player = new Player();
		private var _enemy			: 	Enemy = new Enemy();
		private var _enemies		:	Array;
		public static const DEATH	:	String = "death";
		private var _playerUIText	: 	TextField = new TextField();
		private var _PowerUp		: 	PowerUp = new PowerUp();
		private var _drop			:	int;
		private var _dropArray		: 	Array = [];
		
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
			addChild(_PowerUp);
			_playerUIText.text = "Health: " + _player.health;
			_playerUIText.x = 10;
			_playerUIText.y = 10;
			addChild(_playerUIText);
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
					_playerUIText.text = "Health: " + _player.health;
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
						/*var playerIndex:int = _player.bullets.indexOf(bull);;
						removeChild(bull);
						_player.bullets.splice(playerIndex, 1);*/
					}
				}				
				if (isHit)
				{	
					enemy.health -= 10;
					trace(enemy.health);
					if (enemy.health <= 0)
					{	
						_drop = Math.random() * 2;
						
						if (_drop == 1)
						{
							_dropArray.push(_PowerUp);
						}
						var enemyIndex:int = enemies.indexOf(enemy);
						removeChild(enemy);
						enemies.splice(enemyIndex, 1);
					}
				}
			}
		}
	}
}