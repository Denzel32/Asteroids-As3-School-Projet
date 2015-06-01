package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PowerUps extends Sprite
	{	
		private var _powerUpOne	: AttackSpeed = new AttackSpeed;
		
		public function PowerUps() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
	}

}