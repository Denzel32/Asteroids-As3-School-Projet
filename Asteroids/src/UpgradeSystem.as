package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class UpgradeSystem extends Sprite
	{	
		private var _player:Player = new Player();

		public function UpgradeSystem() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
		}
		
		public function statIncrease(): void
		{
	
		}
		
	}

}