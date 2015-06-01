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
		private var _positionBackup:Point;
		
		public var collected:Boolean = false;
		public var ID:int;
		public var _visible:Boolean = true;
		
		public function Fragment(id:int, pos:Point) 
		{
			ID = id;
			_positionBackup = pos;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_art);
		}
		
		private function update():void {
			if (visible) {
				this.x = _positionBackup.x;
				this.y = _positionBackup.y;
			} else {
				this.x = -300;
				this.y = 100;
			}
		}
	}

}