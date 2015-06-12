package 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
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
		//private var _playerUIText			: 	TextField = new TextField();
		private var _drop					:	int;
		private var _dropArray				: 	Array = [];
		private var _fragmentSystem 		: 	FragmentSystem;
		private var _difficulty				:	int;
		private var _background				:	LEVEL2ANIMATIE = new LEVEL2ANIMATIE();
		
		//Private sound variables
		private var _gameMusic				:	Sound = gS("../lib/sound/gamemusic.mp3");
		private var _fragmentPickupSound	:	Sound = gS("../lib/sound/fragmentpickup.mp3");
		private var _fireSound				:	Sound = gS("../lib/sound/laser.mp3");
		private var _musicTransform			:	SoundTransform = new SoundTransform(0.3);
		private var _musicChannel			:	SoundChannel;
		
		//Debug variables
		private var _debug					:	Boolean = true;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		private var _textformat				:	TextFormat;
		private var droprate				:	int = 5;;
		public var collectedFragments		:	Number = 0; 
		
		//Event variables
		public static const DEATH			:	String = "death";
		public static const ENDGAME			:	String = "endgame";
		
		//Game variables
		public var playerSpawnPosition		:	Point = new Point(512, 384);
		public var fragments				:	Array = [];
		public var bullets					:	Array = [];
		public var spawnThisManyFragments	:	int = 3;
		private var remove:Boolean = false;
		private var explosion: weaponCollission = new weaponCollission();
		public var levelNumber:Number = 1;
		private var _levelTwoBg: LEVEL2ANIMATIE = new LEVEL2ANIMATIE();
		private var _levelThreeBg:Animatielevel3 = new Animatielevel3();
		
		public function get enemies():Array {
			return _enemies;
		}
		
		public function Game(difficulty:int = 1) {
			
			_difficulty = difficulty;
			//spawnThisManyFragments += Math.floor(spawnThisManyFragments * 1.1)
			addEventListener(Event.ADDED_TO_STAGE, init);
			if (levelNumber == 1)
			{
				//addChild(_levelTwoBg)
			}
			if (levelNumber == 2)
			{
				addChild(_levelTwoBg)
			}
			
			if (levelNumber == 3)
			{
				addChild(_levelThreeBg);
			}
		}
		
		public function get getBullets():Array {
			return bullets;
		}
		
		private function gS(i:String):Sound {
			return new Sound(new URLRequest(i));
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, Update);
			_enemies = new Array();
			_player = new Player(this, playerSpawnPosition);
			_fragmentSystem = new FragmentSystem(this, spawnThisManyFragments);
			_enemyspawner = new EnemySpawnManager(this,_difficulty);
			_powerupSpawner = new PowerupSpawnManager(this);
			_musicChannel = _gameMusic.play(0, 1000, _musicTransform);
			
			//addChild(_background);
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			
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
				_totalCollectablesText.scaleX = 2;
				_healthText.scaleX = 2;
				_healthText.x = -120;
				_healthText.y = 10;
				_totalCollectablesText.x = -200;
				_totalCollectablesText.y = 40;
				addChild(_healthText);
				addChild(_totalCollectablesText);
				
				this.graphics.lineStyle(3, 0x000000, 1);
				this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			}
		}
		
		private function powerUpHitTest():void {
			for (var k:int = _powerups.length - 1; k >= 0; k-- ){	
				if (_player.hitTestObject(_powerups[k])){	
					if (_powerups[k].pickupValue == 1){
						_player.maxShots++;
					}
					if (_powerups	[k].pickupValue ==  3){
						_player.health ++;
					}
					removeChild(_powerups[k]);
					_powerups.splice(k, 1);
				}
			}
		}
		
		private function enemyHitTest():void {
			for (var i:int = enemies.length -1; i >= 0; i--) {
				_enemies[i].EnemyFollow(_player);
				if (_player.hitTestObject(enemies[i])){					
					_player.damage(1);
				}
				for each(var bull:Bullet in bullets){
					if (bull.hitTestObject(_enemies[i])) {
						
						addChild(explosion);
						explosion.x = enemies[i].x;
						explosion.y = enemies[i].y;
						if (explosion.currentFrame >= explosion.totalFrames)
						{
							removeChild(explosion);
						}
						enemies[i].health -= 50;
					}
				}
				if (enemies[i].health <= 0)
				{	
					var powerup:PowerUp = new PowerUp();
					powerup.pickupValue = Math.floor(Math.random() * droprate);
					_powerups.push(powerup);
					
					addChild(powerup);
					
					powerup.x = enemies[i].x;
					powerup.y = enemies[i].y;
					
					trace(powerup);
					removeChild(enemies[i]);
					enemies.splice(i, 1);
					
				}
			}
		}
		
		private function fragmentHitTest():void {
			for (var i:int = fragments.length - 1; i >= 0; i--) {
				if (fragments[i] != null) {
					if(_player.playerState == 0) {
						if (_player._playerIdle.hitTestObject(fragments[i])) {
							trace("fragment found");
							collectedFragments++;
							fragments[i].pickMeUp();
							playSound(1);
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						}
					} else if (_player.playerState == 1) {
						if (_player._playerMoving.hitTestObject(fragments[i])) {
							trace("fragment found");
							collectedFragments++;
							fragments[i].pickMeUp();
							playSound(1);
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						}
					} else {
						if (_player._playerDashing.hitTestObject(fragments[i])) {
							trace("fragment found");
							collectedFragments++;
							fragments[i].pickMeUp();
							playSound(1);
							if(_debug)
								_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
						}
					}
				}
			}
		}
		
		private function Update(e:Event):void 
		{	
			enemyHitTest();
			fragmentHitTest();
			powerUpHitTest();
			endGameConditions();
			
			if (_debug) {
				_healthText.text = "Health: " + _player.health;
				_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
			}
		}
		
		private function endGameConditions():void {
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
			_musicChannel.stop();
			_player.cleanUp();
			_fragmentSystem.cleanUp();
			_enemyspawner.cleanUp();
			removeEventListener(Event.ENTER_FRAME, Update);
			dispatchEvent(new Event(ENDGAME, true));
		}
		
		public function playSound(i:int):void {
			switch(i) {
				case 0:
					_fireSound.play();
					break;
				case 1:
					_fragmentPickupSound.play();
					break;
			}
		}
	}
}