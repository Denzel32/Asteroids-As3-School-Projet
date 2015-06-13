package screens {
	import spawnmanagers.EnemySpawnManager;
	import spawnmanagers.FragmentSystem;
	import characters.Player;
	import items.PowerUp;
	import items.Bullet;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
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
		private var _main					:	Main;
		private var _enemyspawner			: 	EnemySpawnManager;
		private var _player					:	Player;
		private var _enemies				:	Array;
		private var _powerups				: 	Array = [];
		private var _drop					:	int;
		private var _dropArray				: 	Array = [];
		private var _fragmentSystem 		: 	FragmentSystem;
		private var _difficulty				:	int;
		private var _remove					:	Boolean = false;
		private var _explosion				:	weaponCollission = new weaponCollission();
		private var _background				:	MovieClip;
		
		//Private UI variables
		private var _hearts					:	Array = [];
		private var _fullAmmo				:	MovieClip = new Ammo_Volledig;
		private var _noAmmo					:	MovieClip = new Ammo_Leeg;
		
		//Private sound variables
		private var _fragmentPickupSound	:	Sound = gS("../lib/sound/fragmentpickup.mp3");
		private var _fireSound				:	Sound = gS("../lib/sound/laser.mp3");
		
		//Debug variables
		private var _debug					:	Boolean;
		private var _healthText				:	TextField;
		private var _totalCollectablesText	:	TextField;
		private var _textformat				:	TextFormat;
		private var droprate				:	int = 30; //to 100 chance // Gets modified with the difficulty variable in the init();
		public var collectedFragments		:	Number = 0; 
		
		//Event variables
		public static const DEATH			:	String = "death";
		public static const ENDGAME			:	String = "endgame";
		
		//Game variables
		public var playerSpawnPosition		:	Point = new Point(512, 384);
		public var fragments				:	Array = [];
		public var bullets					:	Array = [];
		public var spawnThisManyFragments	:	int = 3;
		public var levelNumber:Number = 1;

		public function get enemies():Array {
			return _enemies;
		}
		
		public function Game(main:Main, settings:Array = null, debug:Boolean = false) {
			main = _main;
			_debug = debug;
			if (settings == null) {
				settings = [new BGlevel1, Main(parent).currentLevel];
				trace("No settings object was given with the creation of the game class so I made one for you! @game");
			}
			_background = settings[0];
			_difficulty = settings[1];
			//spawnThisManyFragments += Math.floor(spawnThisManyFragments * 1.1)
			addEventListener(Event.ADDED_TO_STAGE, init);
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
			_player = new Player(this, playerSpawnPosition, _debug);
			_fragmentSystem = new FragmentSystem(this, spawnThisManyFragments);
			_enemyspawner = new EnemySpawnManager(this,_difficulty);
			droprate -= Math.ceil((droprate / 10) * _difficulty);
			
			addChild(_background);
			addChild(_enemyspawner);
			addChild(_fragmentSystem);
			addChild(_player);
			
			uiInit();
			
			if (_debug) {
				var collected:Number = spawnThisManyFragments - fragments.length;
				
				_textformat = new TextFormat();
				_textformat.size = 20;
				
				_healthText = new TextField();
				_healthText.scaleX = 2;
				_healthText.x = -120;
				_healthText.y = 10;
				_healthText.defaultTextFormat = _textformat;
				_healthText.text = "Health: " + _player.health;
				
				_totalCollectablesText = new TextField();
				_totalCollectablesText.defaultTextFormat = _textformat;
				_totalCollectablesText.text = "Collected: " + collected + " of the " + spawnThisManyFragments;
				_totalCollectablesText.scaleX = 2;
				_totalCollectablesText.x = -200;
				_totalCollectablesText.y = 40;
				
				addChild(_healthText);
				addChild(_totalCollectablesText);
				
				/*this.graphics.lineStyle(3, 0x000000, 1);
				this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);*/
			}
		}
		
		private function powerUpHitTest():void {
			for (var k:int = _powerups.length - 1; k >= 0; k-- ){	
				if (_player.hitTestObject(_powerups[k])){	
					if (_powerups[k].pickupValue == 2){
						_player.maxShots++;
					}
					if (_powerups[k].pickupValue == 3) {
						_player.accel += 0.5;
						_player.maxSpeed += 1;
					}
					if (_powerups[k].pickupValue ==  0){
						_player.health ++;
					}
					if (_powerups[k].pickupValue == 1) {
						_player.shotGun = true;
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
						
						addChild(_explosion);
						_explosion.x = enemies[i].x;
						_explosion.y = enemies[i].y;
						if (_explosion.currentFrame >= _explosion.totalFrames)
						{
							removeChild(_explosion);
						}
						enemies[i].health -= 50;
					}
				}
				if (enemies[i].health <= 0)
				{	
					powerUpSummon(new Point(enemies[i].x,enemies[i].y));
					removeChild(enemies[i]);
					enemies.splice(i, 1);
					
				}
			}
		}
		
		private function powerUpSummon(enemyPos:Point):void {
			if(Math.random() * 100 < droprate) {
				var powerup:PowerUp = new PowerUp();
				powerup.pickupValue = Math.floor(Math.random() * 3);
				_powerups.push(powerup);
				
				addChild(powerup);
				
				powerup.x = enemyPos.x;
				powerup.y = enemyPos.y;
			} else {
				trace("no drops made");
			}
		}
		
		private function uiInit():void {
			//Hearts UI objects
			for (var i:int = 0; i < _player.health; i++ ) {
				var heart:MovieClip = new hartje1();
				heart.y = 30;
				heart.x = 20 + 35 * i;
				_hearts.push(heart);
				addChild(heart);
			}
			
			//Ammo UI objects
			addChild(_noAmmo);
			_noAmmo.scaleX = 3;
			_noAmmo.scaleY = 3;
			_noAmmo.y = 50;
			_noAmmo.x = 100;
			addChild(_fullAmmo);
			_fullAmmo.scaleX = 3;
			_fullAmmo.scaleY = 3;
			_fullAmmo.y = 50;
			_fullAmmo.x = 100;
		}
		
		private function updateUI():void {
			//Heart UI update
			var lastHeart:MovieClip = _hearts[_hearts.length - 1];
			if (_player.health < _hearts.length) {
				removeChild(lastHeart);
				_hearts.splice(_hearts.indexOf(lastHeart), 1);
			}
			if (_player.health > _hearts.length) {
				for (var i:int = 0; i < _player.health - _hearts.length; i++) {
					var newHeart:MovieClip = new hartje1();
					_hearts.push(newHeart);
					newHeart.x = lastHeart.x + 35;
					newHeart.y = lastHeart.y;
					addChild(newHeart);
				}
			}
			
			//Ammo UI update
			var result:int = Math.floor(_player.secSinceAmmoFil / _player.shotCoolDown * 100);
			_fullAmmo.scaleX = 3 / 100 * result;
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
			updateUI();
			
			if (_debug) {
				_healthText.text = "Health: " + _player.health;
				_totalCollectablesText.text = "Collected: " + collectedFragments + " of the " + spawnThisManyFragments;
			}
		}
		
		private function endGameConditions():void {
			if (collectedFragments == spawnThisManyFragments) {
				trace("ended game by fragment collection");
				endGame(1);
			}
			
			if (_player.health <= 0) {
				trace("ended game by player death");
				endGame(2);
			}
		}
		
		private function endGame(why:int = 2):void {
			/* endgame conditions:
			 * 1 means player succeeded in collecting
			 * 2 means player failed and has died
			 * the why condition defaults to 2 so if its not given with the usage
			 * by mistake it will end the game rather than continuing it.
			 */
			_player.cleanUp();
			_fragmentSystem.cleanUp();
			_enemyspawner.cleanUp();
			removeEventListener(Event.ENTER_FRAME, Update);
			removeChild(_background);
			_player.health = 0;
			updateUI();
			switch(why) {
				case 1:
					dispatchEvent(new Event(ENDGAME, true));
					break;
				case 2:
					if (!_main)
						_main = Main(parent);
					_main.finishGame(2);
					break;
			}
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