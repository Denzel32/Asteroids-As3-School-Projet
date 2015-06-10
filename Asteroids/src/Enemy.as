package 
{
	import adobe.utils.CustomActions;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import mx.core.ApplicationDomainTarget;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Enemy extends Sprite
	{	
		private var _theEnemy	: Green_Monster = new Green_Monster();
		public var health		: int = 100;
		public var isHit		: Boolean = false;
		public var lastHitBy	: int;
		
		public function Enemy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_theEnemy);	
		}
		
		public function EnemyFollow(target:Player):void {
			if (target.alive == true) 
			{
				if (this.x <= target.x) {
					this.x += 1;
				} else if (this.x >= target.x) {
					this.x -= 1;
				}
				if (this.y <= target.y) {
					this.y += 1;
				} else if (this.y >= target.y) {
					this.y -= 1;
				}
			}
		}
	}

}