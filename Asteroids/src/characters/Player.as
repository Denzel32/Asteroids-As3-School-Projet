package characters {
	import screens.Game;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import items.Bullet;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{	
		//Player sprite variables
		private var _playerGun:MovieClip = new weapon();
		public var _playerIdle:MovieClip = new playeridle();
		public var _playerMoving:MovieClip = new playerMoving();
		public var _playerDashing:MovieClip = new playerdashing();
		public var playerState:int = 0;
		/*Player states:
		 * 0 = idle 
		 * 1 = moving
		 * 2 = dashing
		 */
		
		//Private player variables
		private var _bullets:Array = [];
		private var _shotsFired:int = 0;
		private var _protectionTimer:Timer = new Timer(timeProtected, 1);
		private var _protection	:Boolean = false;
		private var _game		:	Game;
		private var _autoFiring : Boolean = false;
		private var _cleansed	: Boolean = false;
		private var _debug		: Boolean;
		private var _shotGunTime: Timer = new Timer(4000);
		
		//Public player variables
		public var alive:Boolean = true;
		public var ammoTimer:Timer = new Timer(40);
		
		//Private movement variables
		private var up		:		Boolean = false;
		private var right	:		Boolean = false;
		private var down	:		Boolean = false;
		private var left	:		Boolean = false;
		private var xSpeed	:		Number = 0;
		private var ySpeed	:		Number = 0;
		
		//Upgradable variables
		public var maxShots			:int = 5;
		public var shotCoolDown		:Number = 4;
		public var secSinceAmmoFil	:Number = 0;
		public var accel			:Number = 0.5;
		public var maxSpeed			:Number = 5;
		public var health			:int;
		public var timeProtected	:int = 2000;
		public var bulletLifetime	:Number = 3;
		public var shotGun			:Boolean = false;
		
		public function Player(game:Game, startingPos:Point, debug:Boolean = false) {
			_debug = debug;
			if (_debug) {
				health = 100;
			} else {
				health = 9;
			}
			_game = game;
			this.x = startingPos.x; this.y = startingPos.y;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
			
			ammoTimer.addEventListener(TimerEvent.TIMER, reload);
			_shotGunTime.addEventListener(TimerEvent.TIMER, shotGunUnload);
			_protectionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _protectionOff);
			
			render();
			_shotGunTime.start();
			ammoTimer.start();
		}
		
		private function reload(e:TimerEvent):void {
			if (secSinceAmmoFil >= shotCoolDown) {
				_shotsFired = 0;
				secSinceAmmoFil = 0;
			} else {
				secSinceAmmoFil += 0.05;
				//trace(secSinceAmmoFil);
			}
		}
		
		private function shotGunUnload(e:Event):void {
			shotGun = false;
		}
		
		private function shotGunShot():void {
			if (_shotsFired < maxShots) {
				_shotsFired = maxShots;
				_playSound(0);
				
				for (var i:int = 0; i < maxShots; i++) {
					var left:int = Math.random() * 20;
					
					var finalshot:int = _playerGun.rotation;
					finalshot += 20;
					finalshot -= left;
					
					var shot:Bullet = new Bullet(_game, new Point(this.x, this.y), finalshot, bulletLifetime);
					shot.x = x;
					shot.y = y;
					_game.bullets.push(shot);
					_game.addChild(shot);
				}
			}
		}
		
		private function render():void {
			addChild(_playerGun);
			addChild(_playerIdle);
			addChild(_playerMoving);
			addChild(_playerDashing);
			_playerIdle.visible = false;
			_playerMoving.visible = false;
			_playerDashing.visible = false;
		}
		
		private function keyPress(e:KeyboardEvent):void {
			if (e != null) {
				switch(e.keyCode) {
					case 40: // down arrow
						down = true;
						break;
					case 39: // right arrow
						right = true;
						break;
					case 38: // up arrow
						up = true;
						break;
					case 37: // left arrow
						left = true;
						break;
					case 87: // w
						up = true;
						break;
					case 65: // a
						left = true;
						break;
					case 83: // s
						down = true;
						break;
					case 68: // d
						right = true;
						break;
					/*case 70: // f
						toggleAutofire();
						break;*/
				}
			}
		}
		
		private function keyUnpress(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 40: // down arrow
					down = false;
					break;
				case 39: // right arrow
					right = false;
					break;
				case 38: // up arrow
					up = false;
					break;
				case 37: // left arrow
					left = false;
					break;
				case 87: // w
					up = false;
					break;
				case 65: // a
					left = false;
					break;
				case 83: // s
					down = false;
					break;
				case 68: // d
					right = false;
					break;
			}
		}
		
		private function _playSound(i:int):void {
			_game.playSound(i);
		}
		
		private function clickEvent(e:MouseEvent):void {
			if (shotGun) {
				shotGunShot();
			} else {
				if (_shotsFired < maxShots && alive) {
					_shotsFired++;
					_playSound(0);
					
					//trace(this.x +  ":X-player-Y:" + this.y); 
					var shot:Bullet = new Bullet(_game, new Point(this.x, this.y), _playerGun.rotation, bulletLifetime);
					_game.bullets.push(shot);
					_game.addChild(shot);
					shot.x = x;
					shot.y = y;
				}
			}
		}
		
		private function lookAtMouse(mousePos:Point = null):void {
			if (alive == true && mousePos != null) {
				// find out mouse coordinates to find out the angle
				var cx:Number = mousePos.x- this.x;
				var cy:Number = mousePos.y - this.y; 
			
				// find out the angle
				var Radians:Number = Math.atan2(cy,cx);
			
				// convert to degrees to rotate
				var Degrees:Number = Radians * 180 / Math.PI;
			
				// rotate
				_playerGun.rotation = Degrees;
			//	trace(Degrees);
				if (Degrees >= 90 || Degrees <= -90) {
					_playerIdle.scaleX = -1;
					_playerIdle.x = 20;
					_playerMoving.scaleX = -1;
					_playerMoving.x = 20;
					_playerDashing.scaleX = -1;
					_playerDashing.x = 20;
				} else {
					_playerIdle.scaleX = 1;
					_playerIdle.x = -20;
					_playerMoving.scaleX = 1;
					_playerMoving.x = -20;
					_playerDashing.scaleX = 1;
					_playerDashing.x = -20;
				}
			}
		}
		
		public function movement():void {
			if (up) {
				if (ySpeed > -maxSpeed)
				{
					ySpeed -= accel;
				} else {
					ySpeed = -maxSpeed
				}
			}
			
			if (right) {
				if (xSpeed < maxSpeed) 
				{
					xSpeed += accel;
				} else {
					xSpeed = maxSpeed;
				}
			}
			
			if (down) {
				if (ySpeed < maxSpeed) 
				{
					ySpeed += accel;
				} else {
					ySpeed = maxSpeed;
				}
			}
			
			if (left) {
				if (xSpeed > -maxSpeed) 
				{
					xSpeed -= accel;
				} else {
					xSpeed = -maxSpeed;
				}
			}
			
			this.x += xSpeed;
			this.y += ySpeed;
			
			if (xSpeed > 0 && !right) {
				xSpeed -= accel;
			}
			if (xSpeed < 0 && !left) {
				xSpeed += accel;
			}
			if (ySpeed > 0 && !down) {
				ySpeed -= accel;
			}
			if (ySpeed < 0 && !up) {
				ySpeed += accel;
			}
			
			if (this.y > stage.stageHeight+1)
					this.y = 1;
			if (this.x > stage.stageWidth+1)
					this.x = 1;
			if (this.y < 0)
					this.y = stage.stageHeight;
			if (this.x < 0)
						this.x = stage.stageWidth;
			
			if (up || right || down || left) {
				playerState = 1;
				if (xSpeed > 3.5 || ySpeed > 3.5 || xSpeed < -3.5 || ySpeed < -3.5) {
					playerState = 2;
				}
			} else {
				playerState = 0;
			}
		}
		
		private function updatePlayerSprite():void {
			switch(playerState) {
				case 0:
					_playerIdle.visible = true;
					_playerMoving.visible = false;
					_playerDashing.visible = false;
					break;
				case 1:
					_playerIdle.visible = false;
					_playerMoving.visible = true;
					_playerDashing.visible = false;
					break;
				case 2:
					_playerIdle.visible = false;
					_playerMoving.visible = false;
					_playerDashing.visible = true;
					break;
			}
		}
		
		public function update(e:Event):void {
			if (!_cleansed) {
				if (alive) {
					if (stage != null)
					{
						lookAtMouse(new Point(stage.mouseX, stage.mouseY));
					}
					movement();
					updatePlayerSprite();
					if (shotGun) {
						maxShots = 7;
						bulletLifetime = 5;
					} else { 
						maxShots = 5;
						bulletLifetime = 3;
					}
				}
			}
		}
		
		public function cleanUp() : void {
			trace("cleanup requested@player");
			if (!_cleansed) {
				_cleansed = true;
				stage.removeEventListener(Event.ENTER_FRAME, update);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUnpress);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
				stage.removeEventListener(TimerEvent.TIMER, reload);
				stage.removeEventListener(TimerEvent.TIMER_COMPLETE, _protectionOff);
				for (var i:int = _game.bullets.length - 1; i >= 0;  i--)
				{
					var b: Bullet = _game.bullets[i] as Bullet;
					b.destroy();
				}
				trace("cleanup done@player");
			} else {
				trace("cleanUp failed@player -- was already done.");
			}
		}
		
		private function death() : void
		{	
			cleanUp();
			alive = false;
			if (parent)
				parent.removeChild(this);
		}
		
		private function _protectionOff(e:Event):void {
			_protection = false;
		}

		public function damage(dmg:int = 1):void {
			if (!_protection && alive) {
				_protection = true;
				_protectionTimer.start();

				health -= dmg;
				//trace("Health: " + health);
			}
			if (health <= 0) {
				death();
			}
		}
	}

}