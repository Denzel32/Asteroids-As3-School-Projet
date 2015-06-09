package 
{
	import adobe.utils.CustomActions;
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
		private var _powerupSpawner			: 	PowerupSpawnManager;
		private var _player					:	Player;
		private var _enemy					: 	Enemy = new Enemy();
		private var _enemies				:	Array;
		//private var _powerup				:	PowerUp;
		public static const DEATH			:	String = "death";
		private var _playerUIText			: 	TextField = new TextField();
		private var _fragmentSystem 		: 	FragmentSystem;
		
		//Debug variables
		private var _debug					:	Boolean = true;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		private var _textformat				:	TextFormat;
		
		//Game variables
		public var fragments				:	Array = [];
		public var fragmentsBackup			:	Array = [];
		public var bullets					:	Array = [];
		private var _powerups				: 	Array = [];
		private var dropRate				:	Number = 3;
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
			addEventListener(Event.ENTER_FRAME, Update);
			_enemies = new Array();
			_player = new Player(this);
		
			_enemyspawner = new EnemySpawnManager(this);
			_fragmentSystem = new FragmentSystem(this, spawnThisManyFragments);
			_powerupSpawner = new PowerupSpawnManager(this);
			
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			addChild(_powerupSpawner);
			
			_playerUIText.text = "Health: " + _player.health;
			_playerUIText.x = 10;
			_playerUIText.y = 10;
			addChild(_playerUIText);
			
			if (_debug) {
				var textformat:TextFormat = new TextFormat();
				textformat.size = 20;
				_healthText = new TextField();
				_healthText.defaultTextFormat = textformat;
				_healthText.text = "Health: " + _player.health;
				//_totalCollectablesText.text = "Collected: " + spawnThisManyFragments - fragments.length + " of the " + spawnThisManyFragments;
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
			var p:int = _powerups.length;
			
			for (var i2:int = fragments.length - 1; i >= 0; i--) {
				//trace("hey" + i2);
				var fragment:Fragment = fragments[i] as Fragment;
				if (_player.hitTestObject(fragment)) {
					trace("picked up: " + fragment.ID);
					if (fragments.indexOf(fragment) > fragments[0]) {
						fragments.splice(fragments.indexOf(fragment));
					}	else {
						//_fragmentSystem.resetFragments();
					}
					_playerUIText.text = "Health: " + _player.health;
				}
			}
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
						isHit = true;
					}
				}
				
				if (isHit)
				{	
					enemy.health -= 50;
					trace(enemy.health);
					if (enemy.health <= 0)
					{
						var _powerup:PowerUp = new PowerUp();
						_powerup.pickupValue = Math.floor(Math.random() * dropRate);
						_powerups.push(_powerup);
						
						addChild(_powerup)
						
						_powerup.x = enemy.x;
						_powerup.y = enemy.y;
						
						var enemyIndex:int = enemies.indexOf(enemy);
						removeChild(enemy);
						enemies.splice(enemyIndex, 1);	
					}
				}
				
				for (var k:int = _powerups.length - 1; k >= 0; k-- )
				{	
					//var powerupIndex: int = _powerups.indexOf(_powerup);
					if (_player.hitTestObject(_powerups[k]))
					{	
						
						if (_powerups[k].pickupValue == 1)
						{
							_player.maxShots++;
						}
						
						if (_powerups	[k].pickupValue ==  3)
						{
							_player.health ++;
						}
						
						removeChild(_powerups[k]);
						_powerups.splice(k, 1);
					}
				}
				
				
				if (_debug) {
					if(_healthText && _totalCollectablesText) {
						_healthText.text = "Health: " + _player.health;
						_totalCollectablesText.text = "Collected: " + fragments.length + " of the " + spawnThisManyFragments;
					}
				}
			}
		}
	}
}