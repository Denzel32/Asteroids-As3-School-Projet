package items {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.NewObjectSample;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PowerUp extends Sprite
	{	
		private var _pickup:MovieClip;
		public var pickupValue:int;
		
		public function PowerUp() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			switch(pickupValue) {
				case 0:
					_pickup = new HP();
					break;
				case 1:
					_pickup = new AttackDamage();
					break;
				case 2:
					_pickup = new AttackSpeed();
					break;
				case 3:
					_pickup = new MoveSpeed();
					break;
			}
			addChild(_pickup);
		}	
	}
}