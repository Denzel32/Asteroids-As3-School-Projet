package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.sampler.NewObjectSample;
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
		private var _enemies				:	Array;
		private var _powerups				: 	Array = [];
		private var _playerUIText			: 	TextField = new TextField();
		private var _drop					:	int;
		private var _dropArray				: 	Array = [];
		private var _fragmentSystem 		: 	FragmentSystem;
		
		//Debug variables
		private var _debug					:	Boolean = true;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		private var _textformat				:	TextFormat;
		public var collectedFragments		:	Number = 0; 
		
		//Event variables
		public static const DEATH			:	String = "death";
		
		//Game variables
		public var playerSpawnPosition		:	Point = new Point(512, 384);
		public var fragments				:	Array = [];
		public var bullets					:	Array = [];
		public var spawnThisManyFragments	:	int = 3;
		
		public function get enemies():Array
		{
			return _enemies;
		}
		
		public function get powerups():Array
		{
			return _powerups;
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
			_player = new Player(this,playerSpawnPosition);
			_fragmentSystem = new FragmentSystem(this, spawnThisManyFragments);
			_enemyspawner = new EnemySpawnManager(this);
			_powerupSpawner = new PowerupSpawnManager(this);
			//_powerUp = new PowerUp;
			
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			addChild(_powerupSpawner);
			
			_playerUIText.text = "Health: " + _player.health;
			_playerUIText.x = 10;
			_playerUIText.y = 10;
			addChild(_playerUIText);
			
			if (_debug) {
				_textformat = new TextFormat();
				_textformat.size = 20;
				_healthText = new TextField();
				_totalCollectablesText = new TextField();
				_healthText.defaultTextFormat = _textformat;
				_totalCollectablesText.defaultTextFormat = _textformat;
				_healthText.text = "Health: " + _player.health;
				var collected:Number = spawnThisManyFragments - fragments.length;
				_totalCollectablesText.text = "Collected: " + collected + " of the " + spawnThisManyFragments;
				_totalCollectablesText.scaleX = 2
				_healthText.x = -100;
				_healthText.y = 10;
				_totalCollectablesText.x = -200;
				_totalCollectablesText.y = 40;
				addChild(_healthText);
				addChild(_totalCollectablesText);
				
				this.graphics.lineStyle(3, 0x000000, 1);
				this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			}
		}
		
		private function Update(e:Event):void 
		{
			var l:int = _enemies.length;
			var b:int = bullets.length;
			var p: int = _powerups.length;
			
			for (var i2:int = fragments.length - 1; i >= 0; i--) {
				var fragment:Fragment = fragments[i] as Fragment;
				if (fragment) {
					if (_player._playerImage02.hitTestObject(fragment)) {
						trace("fragment id: " + fragments.indexOf(fragment));
						if (fragment.isFirst()) {
							collectedFragments++;
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						} else {
							trace("failure");
							_fragmentSystem.respawnFragments();
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						}
						/**if (fragments.indexOf(fragment) == 0) {
							fragment.isObtained = true;
							fragment._visible = false;
							collectedFragments++;
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						} else {
							//_fragmentSystem.resetFragments();
						}*/
					}
				}
			}
			for (var i:int = l -1; i >= 0; i--)
			{
				var enemy:Enemy = enemies[i] as Enemy;
				var powerup: PowerUp = powerups[i] as PowerUp;
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
					//	trace("is hit");
						isHit = true;
					}
				}

				
				if (isHit)
				{	
					enemy.health -= 50;
				//trace(enemy.health);
					if (enemy.health <= 0)
					{	
						var enemyIndex:int = enemies.indexOf(enemy);
						removeChild(enemy);
						enemies.splice(enemyIndex, 1);
						addChild(powerup);
					}
				}
				
				if (_debug) {
					_healthText.text = "Health: " + _player.health;
					_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
				}
			}
		}
	}
}