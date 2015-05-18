package  
{
	import flash.display.Sprite;
	import flash.events.Event
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Fragment extends Sprite
	{
		
		public function Fragment() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

}