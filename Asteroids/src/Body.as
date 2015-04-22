package  
{
	import flash.display.Sprite;
	import flash.display.Graphics;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Body extends Sprite
	{	
		
		public function Body(X:int, Y:int) {
			this.x = X;
            this.y = Y;
		}
		
		public function movement(i:int):void {
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