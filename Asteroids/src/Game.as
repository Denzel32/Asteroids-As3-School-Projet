package 
{
	import flash.display.Sprite;
	import flash.events.Event;
<<<<<<< HEAD
	import flash.text.TextField;
=======
>>>>>>> origin/master
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
<<<<<<< HEAD
		private var _enemyspawner			: 	EnemySpawnManager;
		private var _dropSystem				: 	PickupDropSystem;
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
=======
		private var _enemyspawner	: EnemySpawnManager;
		private var _fragmentSystem : FragmentSystem;
		private var _player:Player;
		private var _enemies:Array;
		private var _PowerUp		: 	PowerUp = new PowerUp();
		private var _drop			:	int;
		private var _dropArray		: 	Array = [];
		
		//Debug variables
		private var _debug:Boolean = true;
		private var _healthText:TextField;
		private var _totalCollectablesText:TextField;
		private var _textformat:TextFormat;
		
		//Game variables
		public var fragments:Array = [];
		public var fragmentsBackup:Array = [];
		public var bullets:Array = [];
		public var spawnThisManyFragments:int = 20;
		public static const DEATH:String = "death";
		
		//UI variables
		private var _playerUIText	: 	TextField = new TextField();
>>>>>>> origin/master
		
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
			_dropSystem = new PickupDropSystem();
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
				_textformat = new TextFormat();
				_textformat.size = 20;
				
				_healthText = new TextField();
				_totalCollectablesText = new TextField();
				_healthText.wordWrap = true;
				_totalCollectablesText.wordWrap = true;
				_totalCollectablesText.width = 200;
				_healthText.defaultTextFormat = _textformat;
				_totalCollectablesText.defaultTextFormat = _textformat;
				_healthText.text = "Health: " + _player.health;
				_totalCollectablesText.text = "Collected: " + fragments.length + " of the " + fragmentsBackup.length;
				_healthText.x = -100;
				_totalCollectablesText.x = -200;
				_healthText.y = 10;
				_totalCollectablesText.y = 30;
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
			
			for (var i:int = l -1; i >= 0; i--)
			{
				var enemy:Enemy = enemies[i] as Enemy;
				enemy.EnemyFollow(_player);
				
<<<<<<< HEAD
				if (_player.hitTestObject(enemy))
				{
					
					_player.damage(1);
					_playerUIText.text = "Health: " + _player.health;
					if (!_player.alive)
					{
						//dispatchEvent(new Event(DEATH, true));
=======
				if (_player.hitTestObject(enemy)) {
					_player.damage(1);
					_playerUIText.text = "Health: " + _player.health;
					if (!_player.alive) {
						dispatchEvent(new Event(DEATH, true));
>>>>>>> origin/master
					}
				}
					
				var isHit:Boolean = false;
<<<<<<< HEAD
				
				for each(var bull:Bullet in bullets)
				{
					if (bull.hitTestObject(enemy))
					{	
						trace("is hit");
=======
				for each(var bull:Bullet in bullets) {
					trace("amihittingsomethin == " + bull.hitTestObject(enemies[i]));
					if (bull.hitTestObject(enemy)) {	
>>>>>>> origin/master
						isHit = true;
					}
				}
				
<<<<<<< HEAD
				if (isHit)
				{	
					enemy.health -= 50;
					trace(enemy.health);
					if (enemy.health <= 0)
					{	
=======
				if (isHit) {	
					enemy.health -= 10;
					trace(enemy.health);
					if (enemy.health <= 0) {	
						_drop = Math.random() * 2;
						
						if (_drop == 1) {
							_dropArray.push(_PowerUp);
						}
						
>>>>>>> origin/master
						var enemyIndex:int = enemies.indexOf(enemy);
						removeChild(enemy);
						enemies.splice(enemyIndex, 1);
					}
<<<<<<< HEAD
=======
				}
				if (_debug) {
					if(_healthText && _totalCollectablesText) {
						_healthText.text = "Health: " + _player.health;
						_totalCollectablesText.text = "Collected: " + fragments.length + " of the " + fragmentsBackup.length;
					}
>>>>>>> origin/master
				}
			}
		}
	}
}