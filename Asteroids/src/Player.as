package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{
		private var playerImage:PlayerArt = new PlayerArt();
		private var passed:Boolean;
		private var shotsFired:int = 0;
		private var myTimer:Timer = new Timer(4000);
		
		public var health:int = 5;
		
		public function Player(posX:int = 0, posY:int = 0) {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEvent);
			stage.addEventListener(MouseEvent.CLICK, clickEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			render();
			myTimer.start();
		}
		
		private function timerEvent(e:TimerEvent):void{
			//trace("Timer is Triggered");
			shotsFired = 0;
		}
		
		private function render():void {
			addChild(playerImage);
		}
		
		private function keyEvent(e:KeyboardEvent):void {
			if (e != null) {
				passed = true;
				if (e.keyCode == 40) {
					//trace("down arrow");
					movement(0);
				} else if (e.keyCode == 39) {
					//trace("right arrow");
					movement(1);
				} else if (e.keyCode == 38) {
					//trace("up arrow");
					movement(2);
				} else if (e.keyCode == 37) {
					//trace("left arrow");
					movement(3);
				}
			}
		}
		
		private function clickEvent(e:MouseEvent):void {
			if (shotsFired < 5) {
				shotsFired++;
				if (e.localX < 0) {
					//Behind player
					var i:int = 0;
				}
				
				var shot:Bullet = new Bullet(x, y, rotation);
				stage.addChild(shot);
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
		
		public function movement(i:int = 0):void {
			if (i == 0) {
				//up
				this.y += 10;
				if (this.y > 769)
					this.y = 1;
				//trace("down");
			} else if (i == 1) {
				//right
				this.x += 10;
				if (this.x > 1025)
					this.x = 1;
				//trace("right");
			} else if (i == 2) {
				//down
				this.y -= 10;
				if (this.y < 0)
					this.y = 768;
				//trace("up");
			} else if (i == 3) {
				//left
				this.x -= 10;
				if (this.x < 0)
					this.x = 1024;
				//trace("left");
			} else {
				//trace("Movement was given a incorrect value.");
			}
		}
		
		private function death() : void
		{
			if (parent)
				parent.removeChild(this);
			
			removeEventListener(KeyboardEvent.KEY_DOWN, keyEvent);
			removeEventListener(MouseEvent.CLICK, clickEvent);
			removeEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			myTimer.removeEventListener(TimerEvent.TIMER, timerEvent);
		}
		
		public function damage(dmg:int):void {
			health -= dmg;
			if (health < 0) {
				death();
			}
		}
	}

}