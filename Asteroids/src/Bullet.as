package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Bullet extends Sprite
	{
		private var direction:int;
		
		public function Bullet(Direction:int) {
			init();
			direction = Direction;
			//trace("shots fired!");
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//trace("shot");
			var image:bullet = new bullet(); //Lowercase == art, placeholder name and probably should be more descriptive.
			addChild(image);
		}
	}

}