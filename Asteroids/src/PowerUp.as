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
		private var _attackPower:AttackSpeed;
		private var _moveSpeed:MoveSpeed;
		public var pickupValue:int;
		
		public function PowerUp() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			if (pickupValue == 1)
			{
				_attackPower = new AttackSpeed();
				_attackPower.width = _attackPower.width / 9;
				_attackPower.height = _attackPower.height / 9;
				addChild(_attackPower);
			}
			
			if (pickupValue == 2)
			{
				_moveSpeed = new MoveSpeed;
				_moveSpeed.width = _moveSpeed. width / 9;
				_moveSpeed.height = _moveSpeed.width;
				addChild(_moveSpeed);
			}
			
			if (pickupValue == 3)
			{
				_moveSpeed = new MoveSpeed;
				_moveSpeed.width = _moveSpeed. width / 9;
				_moveSpeed.height = _moveSpeed.width;
				addChild(_moveSpeed);
			}
		}	
	}
}