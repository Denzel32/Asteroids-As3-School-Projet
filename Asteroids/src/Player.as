package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{
		private var playerImage:PlayerArt = new PlayerArt();
		private var passed:Boolean;
		private var bullets:Array;
		
		public function Player(posX:int = 0, posY:int = 0) {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEvent);
			stage.addEventListener(MouseEvent.CLICK, clickEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, lookAtMouse);
			stage.addEventListener(Event.ADDED_TO_STAGE, checkBullets);
			render();
		}
		
		private function render():void {
			addChild(playerImage);
		}
		
		private function keyEvent(e:KeyboardEvent):void {
			if (e != null) {
				passed = true;
				if (e.keyCode == 40) {
					trace("down arrow");
					movement(0);
				} else if (e.keyCode == 39) {
					trace("right arrow");
					movement(1);
				} else if (e.keyCode == 38) {
					trace("up arrow");
					movement(2);
				} else if (e.keyCode == 37) {
					trace("left arrow");
					movement(3);
				}
			}
		}
		
		private function clickEvent(e:MouseEvent):void {
			if (e.localX < 0) {
				//Behind player
				var i:int = 0;
			}
			var shot:Bullet = new Bullet(i);
			shot.x = this.x;
			shot.y = this.y;
			addChild(shot);
			trace("click");
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
				this.y+=10;
				//trace("down");
			} else if (i == 1) {
				//right
				this.x+=10;
				//trace("right");
			} else if (i == 2) {
				//down
				this.y-=10;
				//trace("up");
			} else if (i == 3) {
				//left
				this.x-= 10;
				//trace("left");
			} else {
				trace("Movement was given a incorrect value.");
			}
		}
		
		private function checkBullets():void {
			
		}
	}

}