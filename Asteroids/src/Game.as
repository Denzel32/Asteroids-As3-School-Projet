package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.sampler.NewObjectSample;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Game extends Sprite 
	{	
		//Private game variables
		private var _enemyspawner			: 	EnemySpawnManager;
		//private var _dropSystem				: 	PickupDropSystem;
		private var _player					:	Player;
		private var _enemy					: 	Enemy = new Enemy();
		private var _enemies				:	Array;
		public static const DEATH			:	String = "death";
		private var _playerUIText			: 	TextField = new TextField();
		private var _drop					:	int;
		private var _dropArray				: 	Array = [];
		private var _fragmentSystem 		: 	FragmentSystem;
		
		//Debug variables
		private var _debug					:	Boolean = true;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		
		//Game variables
		public var fragments				:	Array = [];
		public var fragmentsBackup			:	Array = [];
		public var bullets					:	Array = [];
		public var spawnThisManyFragments	:	int = 5;
		
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
			//_dropSystem = new PickupDropSystem();
			_fragmentSystem = new FragmentSystem(this,spawnThisManyFragments);
			
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			
			_playerUIText.text = "Health: " + _player.health;
			_playerUIText.x = 10;
			_playerUIText.y = 10;
			addChild(_playerUIText);
			
			addEventListener(Event.ENTER_FRAME, Update);
			if (_debug) {
				var textformat:TextFormat = new TextFormat();
				textformat.size = 20;
				
				_healthText = new TextField();
				_healthText.defaultTextFormat = textformat;
				_healthText.text = "Health: " + _player.health;
				_healthText.x = -100;
				_healthText.y = 10;
				addChild(_healthText);
				
				this.graphics.lineStyle(3, 0x000000, 1);
				this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			}
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
					_playerUIText.text = "Health: " + _player.health;
					if (!_player.alive)
					{
						//dispatchEvent(new Event(DEATH, true));
					}
				}
					
				var isHit:Boolean = false;
				
				for each(var bull:Bullet in bullets)
				{
					if (bull.hitTestObject(enemy))
					{	
						trace("is hit");
						isHit = true;
					}
				}
				
				if (isHit)
				{	
					enemy.health -= 50;
					trace(enemy.health);
					if (enemy.health <= 0)
					{	
						var enemyIndex:int = enemies.indexOf(enemy);
						removeChild(enemy);
						enemies.splice(enemyIndex, 1);
					}
				}
			}
		}
	}
}