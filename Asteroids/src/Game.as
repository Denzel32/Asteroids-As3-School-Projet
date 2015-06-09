package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
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
		private var _enemies				:	Array;
		private var _powerups				: 	Array = [];
		private var _playerUIText			: 	TextField = new TextField();
		private var _drop					:	int;
		private var _dropArray				: 	Array = [];
		private var _fragmentSystem 		: 	FragmentSystem;
		private var _difficulty				:	int;
		
		//Private sound variables
		private var _gameMusic				:	Sound = gS("../lib/gamemusic.mp3");
		private var _fragmentPickupSound	:	Sound = gS("../lib/fragmentpickup.mp3");
		private var _fireSound				:	Sound = gS("../lib/laser.mp3");
		private var _musicTransform			:	SoundTransform = new SoundTransform(0.3);
		private var _musicChannel			:	SoundChannel;
		
		//Debug variables
		private var _debug					:	Boolean = true;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		private var _textformat				:	TextFormat;
		public var collectedFragments		:	Number = 0; 
		
		//Event variables
		public static const DEATH			:	String = "death";
		public static const ENDGAME			:	String = "endgame";
		
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
		
		
		public function Game(difficulty:int = 1) 
		{
			_difficulty = difficulty;
			//spawnThisManyFragments += Math.floor(spawnThisManyFragments * 1.1)
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function get getBullets():Array {
			return bullets;
		}
		
		private function gS(i:String):Sound {
			return new Sound(new URLRequest(i));
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, Update);
			_enemies = new Array();
			_player = new Player(this,playerSpawnPosition);
			_fragmentSystem = new FragmentSystem(this, spawnThisManyFragments);
			_enemyspawner = new EnemySpawnManager(this,_difficulty);
			_powerupSpawner = new PowerupSpawnManager(this);
			_musicChannel = _gameMusic.play(0, 1000, _musicTransform);
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
			//var l:int = _enemies.length;
			var b:int = bullets.length;
			var p: int = _powerups.length;
			
			for (var i2:int = fragments.length - 1; i >= 0; i--) {
				//var fragment:Fragment = fragments[i] as Fragment;
				if (fragments[i] != null) {
					if (_player._playerImage02.hitTestObject(fragments[i])) {
						//trace("fragment id: " + fragments.indexOf(fragment));
						collectedFragments++;
						fragments[i].pickMeUp();
						if(_debug)
							_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						/*if (fragments.indexOf(fragment) == 0) {
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
			for (var i:int = enemies.length -1; i >= 0; i--)
			{
				//var enemy:Enemy = enemies[i] as Enemy;
				//var enemyIndex:int = enemies.indexOf(enemy);
				//var powerup: PowerUp = powerups[0] as PowerUp;
				_enemies[i].EnemyFollow(_player);
				
				if (_player.hitTestObject(enemies[i]))
				{					
					_player.damage(1);
					_playerUIText.text = "Health: " + _player.health;
					if (!_player.alive)
					{
						//dispatchEvent(new Event(DEATH, true));
					}
				}
					
				//var isHit:Boolean = false;
				
				for each(var bull:Bullet in bullets)
				{
					if (bull.hitTestObject(_enemies[i]))
					{	
						enemies[i].health-=50;
						
					}
				}

				if (enemies[i].health <=0)
				{
					removeChild(enemies[i]);
					enemies.splice(i, 1);
					//addChild(powerup);
				}
				
				
			}
			if (_debug) {
					_healthText.text = "Health: " + _player.health;
					_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
				}
			if (collectedFragments == spawnThisManyFragments) {
				trace("ended game by fragment collection");
				endGame();
			}
			
			if (_player.health <= 0) {
				trace("ended game by player death");
				endGame();
			}
		}
		
		private function endGame():void {
			trace("endgame");
			_musicChannel.stop();
			dispatchEvent(new Event(ENDGAME));
		}
	}
}