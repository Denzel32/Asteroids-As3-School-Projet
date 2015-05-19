package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Game extends Sprite 
	{	
		private var _enemyspawner	: EnemySpawnManager;
		private var _fragmentSystem : FragmentSystem;
		private var _player:Player;
		private var _enemies:Array;
		
		public var fragments:Array = [];
		public var fragmentsBackup:Array = [];
		public var bullets:Array = [];
		public static const DEATH:String = "death";
		
		public function get enemies():Array
		{
			return _enemies;
		}
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function get getBullets():Array {
			return bullets;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_enemies = new Array();
			_player = new Player(this);
		
			_enemyspawner = new EnemySpawnManager(this);
			_fragmentSystem = new FragmentSystem(this);
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			
			addEventListener(Event.ENTER_FRAME, Update);
		}
		
		private function Update(e:Event):void 
		{
			var l:int = _enemies.length;
			var b:int = bullets.length;
			
			for (var i:int = l -1; i >= 0; i--)
			{
				var enemy:Enemy = enemies[i] as Enemy;
				enemy.EnemyFollow(_player);
				
				if (_player.hitTestObject(enemy))
				{
					_player.damage(1);
					if (!_player.alive)
					{
						dispatchEvent(new Event(DEATH, true));
					}
				}
				
				var isHit:Boolean = false;
				for each(var bull:Bullet in bullets)
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
					removeChild(enemies[i]);
					enemies.splice(index, 1);
				}
				
			}
			//trace("game: " + bullets); //see what is inside the bullets array.
		}
	}
}