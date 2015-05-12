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
		public var attack:int = 0;
		public var health:int = 0;
		
		public function UpgradeSystem() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
<<<<<<< HEAD
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
=======
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
>>>>>>> origin/master
		}
		
		public function statIncrease(): void
		{
			attack += 10;
			health += 100;
		}
		
	}

}