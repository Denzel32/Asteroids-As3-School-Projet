package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PickupDropSystem extends Sprite
	{	
		private var _powerups		: 	PowerUps = new PowerUps;
		
		
		
		public function PickupDropSystem() 
		{	
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
	}

}