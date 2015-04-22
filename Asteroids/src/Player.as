package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Player extends Sprite
	{
		private var playerImage:MovieClip = new EnemyArt();
		private var body:Body;
		
		public function Player(posX:int = 0, posY:int = 0) {
			render();
			body = new Body(posX, posY);
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, sendMovement);
		}
		
		public function render():void {
			addChild(playerImage);
		}
		
		public function movement(i:int):void
		{
			if (i == 0) {
				//up
				this.y+=10;
				trace("up");
			} else if (i == 1) {
				//right
				this.x+=10;
				trace("right");
			} else if (i == 2) {
				//down
				this.y-=10;
				trace("down");
			} else if (i == 3) {
				//left
				this.x-= 10;
				trace("left");
			} else {
				trace("Movement was given a incorrect value");
			}
		}
	}

}