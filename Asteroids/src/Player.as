package  
{
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
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{	
		//Player sprite variables
		private var _playerImage:MovieClip = new catGun();
		public var _playerImage02:MovieClip = new catMoving();
		
		//Private player variables
		private var _bullets:Array = [];
		private var _shotsFired:int = 0;
		private var _myTimer:Timer = new Timer(4000);
		private var _protectionTimer:Timer = new Timer(timeProtected, 1);
		private var _protection	:Boolean = false;
		private var _game		:	Game;
		
		//Private sound variables
		private var _laserSound:Sound = new Sound(new URLRequest("../lib/laser.mp3"));
		
		//Public player variables
		public var alive:Boolean = true;
		
		//Private movement variables
		private var up		:		Boolean = false;
		private var right	:		Boolean = false;
		private var down	:		Boolean = false;
		private var left	:		Boolean = false;
		private var xSpeed	:		Number = 0;
		private var ySpeed	:		Number = 0;
		
		//Upgradable variables
		public var maxShots			:int = 5;
		public var accel			:Number = 0.5;
		public var maxSpeed			:Number = 5;
		public var health			:int = 1000;
		public var timeProtected	:int = 2000;
		public var bulletLifetime	:Number = 3;
		public var autoFire			:Boolean = false; //buggy!
		
		public function Player(game:Game, startingPos:Point) {
			_game = game;
			this.x = startingPos.x; this.y = startingPos.y;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			if (!autoFire){
				stage.addEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
			} else {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, autoClick);
				stage.addEventListener(MouseEvent.MOUSE_UP, disableAutoClick);
			}
			_myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			_protectionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, _protectionOff);
		
			render();
			_myTimer.start();
		}
		
		public function toggleAutofire():void {
			if (autoFire) {
				removeEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, autoClick);
				stage.addEventListener(MouseEvent.MOUSE_UP, disableAutoClick);
				autoFire = false;
			} else {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
				removeEventListener(MouseEvent.MOUSE_DOWN, autoClick);
				removeEventListener(MouseEvent.MOUSE_UP, disableAutoClick);
				autoFire = true;
			}
		}
		
		private function timerEvent(e:TimerEvent):void{
			_shotsFired = 0;
		}
		
		// <autofire buggy>
		private function autoClick(e: MouseEvent):void {
			stage.addEventListener(Event.ENTER_FRAME, clickEventAutoFire);
			maxShots = 100;
		}
		
		private function disableAutoClick(e:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, clickEventAutoFire);
			maxShots = 100;
		}
		
		private function clickEventAutoFire(e:Event):void {
			if (_shotsFired < maxShots) {
				_shotsFired++;
				var shot:Bullet = new Bullet(_game, new Point(this.x, this.y), rotation, bulletLifetime);
				_game.bullets.push(shot);
				_game.addChild(shot);
				//trace("click");
			} else {
				//damage(5);
				//trace("Already 5 shots fired in the last several seconds.");
			}
		}
		
		private function render():void {
			addChild(_playerImage);
			addChild(_playerImage02);
			_playerImage02.x -= 140;
			_playerImage02.y -= 60;
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
		
		private function clickEvent(e:MouseEvent):void {
			if (_shotsFired < maxShots && alive) {
				_shotsFired++;
				_laserSound.play();
				
				//trace(this.x +  ":X-player-Y:" + this.y); 
				var shot:Bullet = new Bullet(_game, new Point(this.x, this.y), _playerImage.rotation, bulletLifetime);
				_game.bullets.push(shot);
				_game.addChild(shot);
				shot.x = x;
				shot.y = y;
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
				_playerImage.rotation = Degrees;
			//	trace(Degrees);
				if (Degrees >= 90 || Degrees <= -90) {
					_playerImage02.scaleX = -1;
					_playerImage02.x = 140;
				} else {
					_playerImage02.scaleX = 1;
					_playerImage02.x = -140;
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
				if (xSpeed < maxSpeed) 
				{
					xSpeed -= accel;
				} else {
					xSpeed = maxSpeed;
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
		}
		
		public function update(e:Event):void {
			if (alive) {
				lookAtMouse(new Point(stage.mouseX, stage.mouseY));
				movement();
			}
		}
		
		private function death() : void
		{
			removeEventListener(Event.ENTER_FRAME, update);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			removeEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			if (!autoFire){
				removeEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
			} else {
				removeEventListener(MouseEvent.MOUSE_DOWN, autoClick);
				removeEventListener(MouseEvent.MOUSE_UP, disableAutoClick);
			}
			removeEventListener(TimerEvent.TIMER, timerEvent);
			removeEventListener(TimerEvent.TIMER_COMPLETE, _protectionOff);
			
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