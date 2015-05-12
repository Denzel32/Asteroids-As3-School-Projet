package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{	
		//private player variables
		private var playerImage:PlayerArt = new PlayerArt();
		private var shotsFired:int = 0;
		private var myTimer:Timer = new Timer(4000);
		private var protectTimer:Timer = new Timer(timeProtected, 1);
		private var protection:Boolean = false;
		//private var _game:Game;
		
		//public player variables
		public var alive:Boolean = true;
		public var health:int = 5;
		
		//movement variables
		private var up:Boolean = false;
		private var right:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		private var xSpeed:Number = 0;
		private var ySpeed:Number = 0;
		
		//upgradable variables
		public var maxShots:int = 5;
		public var accel:Number = 0.5;
		public var maxSpeed:Number = 10;
		public var timeProtected:int = 2000;
		public var bulletLifetime:Number = 3;
		public var autofire:Boolean = false; //buggy!!!
		
		public function Player(posX:int = 512, posY:int = 384) {
			this.x = posX; this.y = posY;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(Event.ENTER_FRAME, movement);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			if (!autofire){
				stage.addEventListener(MouseEvent.MOUSE_DOWN, clickEvent);
			} else {
				stage.addEventListener(MouseEvent.MOUSE_DOWN, autoClick);
				stage.addEventListener(MouseEvent.MOUSE_UP, disableAutoClick);
			}
			stage.addEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			protectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, protectionOff);
			
			render();
			myTimer.start();
		}
		
		private function timerEvent(e:TimerEvent):void{
			//trace("Timer is Triggered");
			shotsFired = 0;
		}
		
		//Little secret, this autofire function is disabled by default of course ;)
		private function autoClick(e: MouseEvent):void {
			stage.addEventListener(Event.ENTER_FRAME, clickEventAutoFire);
			maxShots = 100;
		}
		
		private function disableAutoClick(e:MouseEvent):void {
			removeEventListener(Event.ENTER_FRAME, clickEventAutoFire);
			maxShots = 100;
		}
		
		private function clickEventAutoFire(e:Event):void {
			if (shotsFired < maxShots) {
				shotsFired++;
				
				var shot:Bullet = new Bullet(x, y, rotation);
				stage.addChild(shot);
				//trace("click");
			} else {
				//damage(5);
				//trace("Already 5 shots fired in the last several seconds.");
			}
		}
		
		//end of autofire lines
		
		private function render():void {
			addChild(playerImage);
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
				}
				/*
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
				}*/
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
			if (shotsFired < maxShots) {
				shotsFired++;
				/*if (e.localX < 0) {
					//Behind player
					var i:int = 0;
				}*/
				
				var shot:Bullet = new Bullet(x, y, rotation);
				Game(parent).bullets.push(shot);
				Game(parent).addChild(shot);
				//trace("click");
			} else {
				//damage(5);
				//trace("Already 5 shots fired in the last several seconds.");
			}
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
			if(alive) {
				if (up) {
					//up
					if (ySpeed > -maxSpeed){
						ySpeed -= accel;
					} else {
						ySpeed = -maxSpeed
					}
				}
				if (right) {
					//right
					if (xSpeed < maxSpeed) {
						xSpeed += accel;
					} else {
						xSpeed = maxSpeed;
					}
				}
				if (down) {
					//down
					if (ySpeed < maxSpeed) {
						ySpeed += accel;
					} else {
						ySpeed = maxSpeed;
					}
				}
				if (left) {
					//left
					if (xSpeed > -maxSpeed) {
						xSpeed -= accel;
					} else {
						xSpeed = -maxSpeed;
					}
				}
				
				this.x += xSpeed;
				this.y += ySpeed;
				//trace("xsp: " + xSpeed);
				//trace("ysp: " + ySpeed);
				
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
				
				//Check if it's going outside the screen.
				if (this.y > stage.stageHeight+1)
						this.y = 1;
				if (this.x > stage.stageWidth+1)
						this.x = 1;
				if (this.y < 0)
						this.y = stage.stageHeight;
				if (this.x < 0)
						this.x = stage.stageWidth;
			}
		}
		
		private function death() : void
		{
			alive = false;
			if (parent)
				parent.removeChild(this);
			
			removeEventListener(Event.ENTER_FRAME, movement);
			removeEventListener(KeyboardEvent.KEY_DOWN, keyPress);
			removeEventListener(KeyboardEvent.KEY_UP, keyUnpress);
			removeEventListener(MouseEvent.CLICK, clickEvent);
			removeEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.removeEventListener(TimerEvent.TIMER, timerEvent);
			protectTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, protectionOff);
		}
		
		private function protectionOff(e:Event):void {
			protection = false;
			//stage.color = 0xffffff;
		}
		
		public function damage(dmg:int = 1):void {
			if (!protection) {
				//stage.color = 0xff0000;
				protection = true;
				protectTimer.start();
				health -= dmg;
				trace("Health: " + health);
			}
			if (health <= 0) {
				death();
				//stage.color = 0x000000;
			}
		}
	}

}