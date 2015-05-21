package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{	
		//private player variables
		private var playerImage:PlayerArt = new PlayerArt();
		private var passed:Boolean;
		private var shotsFired:int = 0;
		private var myTimer:Timer = new Timer(4000);
		private var protectTimer:Timer = new Timer(timeProtected, 1);
		private var protection:Boolean = false;
		private var _bullets:Array = [];

		
		//movement variables
		private var up:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		private var xSpeed:Number = 0;
		private var ySpeed:Number = 0;
		
		//upgradable variables
		public var maxShots:int = 5;
		public var accel:Number = 0;
		public var maxSpeed:Number = 10;
		public var health:int = 5;
		public var timeProtected:int = 2000;
		
		public var isDead: Boolean = false;
		
		public function Player(posX:int = 512, posY:int = 384) {
			this.x = posX; this.y = posY;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, movement);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			stage.addEventListener(MouseEvent.CLICK, clickEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			protectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, protectionOff);
			
			
			render();
			myTimer.start();
		}
		
		public function get bullets():Array
		{
			return _bullets
		}
		
		private function timerEvent(e:TimerEvent):void{
			//trace("Timer is Triggered");
			shotsFired = 0;
		}
		
		private function render():void {
			addChild(playerImage);
		}
		
		private function keyPress(e:KeyboardEvent):void {
			if (e != null) {
				passed = true;
				if (e.keyCode == 40 || e.keyCode == 83) {
					//trace("down arrow");
					down = true;
				}
				if (e.keyCode == 39 || e.keyCode == 68) {
					//trace("right arrow");
					right = true;
				}
				if (e.keyCode == 38 || e.keyCode == 87) {
					//trace("up arrow");
					up = true;
				}
				if (e.keyCode == 37 || e.keyCode == 65) {
					//trace("left arrow");
					left = true;
				}
			}
		}
		
		private function keyUnpress(e:KeyboardEvent):void {
			up = false;
			right = false;
			down = false;
			left = false;
		}
		
		private function clickEvent(e:MouseEvent):void {
			if (shotsFired < maxShots) {
				shotsFired++;
				if (e.localX < 0) {
					//Behind player
					var i:int = 0;
				}
				
				var shot:Bullet = new Bullet(x, y, rotation);
				_bullets.push(shot);
				_bullets[bullets.length - 1].addEventListener("bullet destroyed", removeBullet);
				stage.addChild(shot);
				//trace("click");
			} else {
				//damage(5);
				//trace("Already 5 shots fired in the last several seconds.");
			}
		}
		
		private function removeBullet(e:Event):void 
		{
			
			var b:Bullet = e.target as Bullet;
			b.removeEventListener("bullet destroyed", removeBullet);
			var i:int = _bullets.indexOf(b)
			_bullets.splice(i, 1);
		}
		
	
		
		private function lookAtMouse(e:MouseEvent):void {
			// find out mouse coordinates to find out the angle
			var cy:Number = e.localY - this.y; 
			var cx:Number = e.localX - this.x;
			//trace(e.localY + " - " + this.y + " = cy(" + cy + ")");
			//trace(e.localX + " - " + this.x + " = cx(" + cx + ")");
		
			// find out the angle
			var Radians:Number = Math.atan2(cy,cx);
		
			// convert to degrees to rotate
			var Degrees:Number = Radians * 180 / Math.PI;
		
			// rotate
			this.rotation = Degrees;
		}
		
		public function movement(e:Event):void {
			if (up) {
				//up
				if (ySpeed > -maxSpeed)
				{
					ySpeed -= 0.5;
				} else {
					ySpeed = -maxSpeed
				}
			}
			if (right) {
				//right
				if (xSpeed < maxSpeed) 
				{
					xSpeed += 0.5;
				} else {
					xSpeed = maxSpeed;
				}
			}
			if (down) {
				//down
				if (ySpeed < maxSpeed) 
				{
					ySpeed += 0.5;
				} else {
					ySpeed = maxSpeed;
				}
			}
			if (left) {
				//left
				if (xSpeed > -maxSpeed) {
					xSpeed -= 0.5;
				} else {
					xSpeed = -maxSpeed;
				}
			}
			
			this.x += xSpeed;
			this.y += ySpeed;
			//trace("xsp: " + xSpeed);
			//trace("ysp: " + ySpeed);
			
			if (xSpeed > 0 && !right) {
				xSpeed -= 0.5;
			}
			if (xSpeed < 0 && !left) {
				xSpeed += 0.5;
			}
			if (ySpeed > 0 && !down) {
				ySpeed -= 0.5;
			}
			if (ySpeed < 0 && !up) {
				ySpeed += 0.5;
			}
			
			//Check if it's going outside the screen.
			if (this.y > 769)
					this.y = 1;
			if (this.x > 1025)
					this.x = 1;
			if (this.y < 0)
					this.y = 768;
			if (this.x < 0)
					this.x = 1024;
		}
		
		private function death() : void
		{
			if (parent)
				parent.removeChild(this);
			
			removeEventListener(Event.ENTER_FRAME, movement);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			removeEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			removeEventListener(MouseEvent.CLICK, clickEvent);
			removeEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.removeEventListener(TimerEvent.TIMER, timerEvent);
			protectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, protectionOff);
			isDead = true;
		}
		
		private function protectionOff(e:Event):void {
			protection = false;
		}
		
		public function damage(dmg:int):void {
			//trace("Health: " + health);
			if (!protection) {
				protection = true;
				protectTimer.start();
				health -= dmg;
			}
			
			if (health <= 0) {
				death();
			}
		}
	}

}