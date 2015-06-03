package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PowerUp extends Sprite 
	{	
		private var _powerupArt: MoveSpeed;
		
		public function PowerUp() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			_powerupArt = new MoveSpeed
			addChild(_powerupArt);
		}
		
	}

}