package 
{
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PowerUp extends Sprite
	{	
		private var _speedPowerUp	: 	MoveSpeed 	= new MoveSpeed();
		private var _attackPowerUp	: 	AttackSpeed = new AttackSpeed();
		public var showPowerUp		:	int;
		
		public function PowerUp() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			showPowerUp = Math.random() * 3;
			if (showPowerUp == 1 )
			{
				addChild(_speedPowerUp);
				_speedPowerUp.x = stage.stageWidth / 2;
				_speedPowerUp.y = 400;
				_speedPowerUp.height = _speedPowerUp.height / 9;
				_speedPowerUp.width = _speedPowerUp.height;
			}
			if (showPowerUp == 2)
			{
				addChild(_attackPowerUp);
				_attackPowerUp.x = stage.stageWidth / 2;
				_attackPowerUp.y = 400;
				_attackPowerUp.height = _attackPowerUp.height / 9;
				_attackPowerUp.width = _attackPowerUp.height;
			}
		}
		
	}

}