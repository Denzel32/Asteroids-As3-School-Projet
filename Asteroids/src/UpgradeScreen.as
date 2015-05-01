package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class UpgradeScreen extends Sprite 
	{	
		private var _txtfield: TextField = new TextField();
		
		public function UpgradeScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			addChild(_txtfield);
			_txtfield.x = 20;
			_txtfield.y = stage.stageHeight / 2;
		}
		
	}

}