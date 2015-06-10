package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class PowerupSpawnManager extends Sprite 
	{	
		public var _powerup : PowerUp;
		private var _game	: Game;
		
		public function PowerupSpawnManager(game:Game) 
		{	
			_game = game;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_powerup = new PowerUp();
			
			trace("powerup: " +_powerup);
			trace("powerups: " +_game.powerups);
			_game.powerups.push(_powerup);
			_game.addChild(_powerup);
			_powerup.width = _powerup.width / 9;
			_powerup.height = _powerup.height / 9;
			_powerup.x = 200;
			_powerup.y = _powerup.x;
		}
		
	}

}