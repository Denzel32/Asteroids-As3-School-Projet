package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Enemy extends Sprite
	{	
		private var _theEnemy	: MovieClip;
		private var _skins		: Array = new Array(new Green_Monster, new Enemy_Red);
		public var health		: int = 100;
		public var isHit		: Boolean = false;
		
		public function Enemy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var skin:int = Math.random() * _skins.length;
			trace(_skins[skin]);
			_theEnemy = _skins[skin];
			_skins = null;
			addChild(_theEnemy);
		}
		
		private function lookAtPlayer(playerPos:Point = null):void {
			if (playerPos != null) {
				// find out mouse coordinates to find out the angle
				var cx:Number = playerPos.x- this.x;
				var cy:Number = playerPos.y - this.y; 
			
				// find out the angle
				var Radians:Number = Math.atan2(cy,cx);
			
				// convert to degrees to rotate
				var Degrees:Number = Radians * 180 / Math.PI;
			
				// rotate
				Degrees += 90;
				_theEnemy.rotation = Degrees;
			//	trace(Degrees);
			}
		}
		
		public function EnemyFollow(target:Player):void {
			if (target.alive == true) 
			{
				lookAtPlayer(new Point(target.x, target.y));
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