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
		
		public var game:Game;
		public var fragments:Array;
		public var collected:Boolean = false;
		public var _visible:Boolean = true;
		
		public function Fragment(gm:Game, pos:Point) 
		{
			game = gm;
			fragments = game.fragments;
			_positionBackup = pos;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function isFirst():Boolean {
			if (fragments.indexOf(this) == 0) {
				_visible = false;
				fragments.splice(fragments.indexOf(this),1);
				trace("repeat");
				return true;
			} else {
				return false;
			}
		}
		
		private function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			addChild(_art);
		}
		
		private function update(e:Event):void {
			if (_visible) {
				this.x = _positionBackup.x;
				this.y = _positionBackup.y;
			} else {
				this.x = -300;
				this.y = 100;
			}
		}
	}

}