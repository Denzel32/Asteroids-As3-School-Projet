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
		public static const GAME_START: String = "startGame";
	
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function OnClick(e:MouseEvent):void 
		{	
			//trace("clickclickclick");
			dispatchEvent(new Event(GAME_START, true));
			//stage.removeEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.CLICK, OnClick);
			addChild(_txtfield);
			_txtfield.text = "Left mouse click to start the game";
			_txtfield.width = 300;
			_txtfield.x  = stage.stageWidth / 2;
			_txtfield.y = stage.stageHeight / 2;
		}	
	}
}