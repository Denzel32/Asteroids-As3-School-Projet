package 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class UpgradeSystem extends Sprite
	{
		
		public function UpgradeSystem() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
	}

}