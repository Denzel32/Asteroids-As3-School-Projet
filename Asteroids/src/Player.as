package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{
		private var playerImage:PlayerArt = new PlayerArt();
		private var passed:Boolean;
		
		public function Player(posX:int = 0, posY:int = 0) {
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEvent);
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
		
		public function movement(i:int = 0):void {
			if (i == 0) {
				//up
				this.y+=10;
				trace("down");
			} else if (i == 1) {
				//right
				this.x+=10;
				trace("right");
			} else if (i == 2) {
				//down
				this.y-=10;
				trace("up");
			} else if (i == 3) {
				//left
				this.x-= 10;
				trace("left");
			} else {
				trace("Movement was given a incorrect value.");
			}
		}
	}

}