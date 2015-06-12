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

		
		public function LevelSelect() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
			
		}
		
		private function Init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, Init);
	

		}
		
		private function OnClick(e:MouseEvent):void 
		{

		}
	}
}