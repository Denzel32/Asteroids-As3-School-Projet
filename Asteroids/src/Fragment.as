package  
{
	import flash.display.Sprite;
	import flash.events.Event
	import flash.geom.Point;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Fragment extends Sprite
	{
		private var _art:fragmentArt = new fragmentArt();
		public var collected:Boolean = false;
		public var ID:int;
		
		public function Fragment(id:int) 
		{
			ID = id;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_art);
		}
	}

}