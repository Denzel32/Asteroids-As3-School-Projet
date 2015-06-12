package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Controls extends Sprite
	{	
		private var controlScreen: controls = new controls();
		
		public function Controls() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(controlScreen);
			controlScreen.x = stage.stageWidth / 2;
			controlScreen.y = stage.stageHeight / 2;
		}
		
	}

}