package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class MainMenu extends Sprite
	{	
		private var _txtfield: TextField = new TextField();
		
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_txtfield);
			_txtfield.x  = stage.stageWidth / 2;
			_txtfield.y = stage.stageHeight / 2;
		}
		
	}

}