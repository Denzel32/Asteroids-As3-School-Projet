package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class LevelSelect extends Sprite
	{	
		private var start_button: Start_Button = new Start_Button();
		private var controls_button: Controls_Button = new Controls_Button();
		private var credits_button: Credits_Button = new Credits_Button();
		public static const LEVEL_SELECTED:String = "levelSelected";
		
		public function LevelSelect() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
			
		}
		
		private function Init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			stage.addEventListener(MouseEvent.CLICK, OnClick);
			start_button.x = stage.stageWidth / 2;
			start_button.y = stage.stageHeight / 2 - 200;
			controls_button.x = stage.stageWidth / 2;
			controls_button.y = stage.stageHeight / 2 - 80;
			credits_button.x = stage.stageWidth / 2;
			credits_button.y = stage.stageHeight / 2 + 50;
			addChild(start_button);
			addChild(controls_button);
			addChild(credits_button);

		}
		
		private function OnClick(e:MouseEvent):void 
		{
			if (e.target == start_button)
			{
				dispatchEvent(new Event(LEVEL_SELECTED, true));
			}
			
			if (e.target == controls_button)
			{
				
			}
		}
	}
}