package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Credits extends Sprite
	{
		private var _credits: credits = new credits();
		
		public function Credits() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_credits);
			_credits.x = stage.stageWidth / 2;
			_credits.y = stage.stageHeight / 2;
		}
		
	}

}