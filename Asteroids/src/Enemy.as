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

		public function StatIncrease():void
		{
			_atkPower+= 10;
			_health+= 10;
			
		}
		
		public function EnemyFollow(target:Player):void
		{
			//trace("enemy x" + this.x);
<<<<<<< HEAD
			if (target.alive == true) {
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
				
				/* Alternative AI.
				if (target.x > this.x && target.x - this.x > this.x) {
					closeToWallX = -1;
				} else if (target.x < this.x && this.x - target.x > target.x) {
					closeToWallX = 1;
				} else {
					closeToWallX = 0;
				}
				
				if (closeToWallX == -1) {
					this.x -= 4;
					trace("X -1");
				} else if (closeToWallX == 1) {
						this.x += 4;
						trace("X 1");
				} else if (closeToWallX == 0) {
					trace("X 0");
					if (this.x <= target.x) {
						this.x += 4
					} else if (this.x >= target.x) {
						this.x -= 4;
					}
				}
				
				if (target.y > this.y && target.y - this.y > this.y) {
					closeToWallY = -1;
				} else if (target.y < this.y && this.y - target.y > target.y) {
					closeToWallY = 1;
				} else {
					closeToWallY = 0;
				}
				
				if (closeToWallY == -1) {
					trace("Y -1");
					this.y -= 4;
				} else if (closeToWallY == 1) {
					this.y += 4;
					trace("Y 1");
				} else if (closeToWallY == 0) {
					trace("Y 0");
					if (this.y <= target.y) {
						this.y += 4;
					} else if (this.y >= target.y) {
						this.y -= 4;
					}
				}
				
				if (this.y > stage.stageHeight+1)
						this.y = 1;
				if (this.x > stage.stageWidth+1)
						this.x = 1;
				if (this.y < -1)
						this.y = stage.stageHeight-1;
				if (this.x < -1)
						this.x = stage.stageWidth;
				//trace(closeToWallX + " , " + closeToWallY);
				*/
=======
			if (this.y <= target.y)
			{
				this.y += 1;
				
			}else if (this.y >= target.y)
			{
				this.y -= 1;
			}
			
			if (this.x <= target.x)
			{
				this.x += 1
			}else if (this.x >= target.x)
			{
				this.x -= 1;
>>>>>>> origin/master
			}
		}
	}

}