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
		private var _theEnemy	: PlayerArt = new PlayerArt();
		private var _speed		: int = 5;
		public var _atkPower	: int = 3;
		public var _health		: int = 100;
		
		public function Enemy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_theEnemy);
			
		}
		
		public function Update():void 
		{	
			
		}
		
		public function StatIncrease():void
		{
			_atkPower+= 10;
			_health+= 10;
			
		}
		
		public function EnemyFollow(target:Player):void
		{
			if (this.y < target.y)
			{
				this.y += 4;
				
			}else if (this.y > target.y)
			{
				this.y -= 4;
			}
			
			if (this.x < target.x)
			{
				this.x += 4
			}else if (this.x > target.x)
			{
				this.x -= 4;
			}
		}
	}

}