package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class Bullet extends Sprite
	{
		private var vx:Number = 0;
		private var vy:Number = 0;
		private var speed:Number = 7;
		private var myTimer:Timer = new Timer(500);
		private var _lifetime:Number;
		private var _game:Game;
		
		public function Bullet(game:Game, pos:Point,shipRotation:int,lifetime:Number = 1) {
			
			_lifetime = lifetime;
			init();
			
			_game = game;
			
			this.rotation = shipRotation;
			vy += Math.sin(degreesToRadians(shipRotation)) * speed;
			vx += Math.cos(degreesToRadians(shipRotation)) * speed;
			
			//trace("vel x" + vx + "vel y" + vy);
			//trace(pos.x + ":X-bullet-Y:" + pos.y);
			//this.x = pos.x + vx*2;
			//this.y = pos.y + vy * 2;
			
			//trace("vel x" + vx + "vel y" + vy);
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
		}
		
		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var image:bullet = new bullet(); //Lowercase == art, placeholder name and probably should be more descriptive.
			addChild(image);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			myTimer.start();
		}
		
		private function timerEvent(e:TimerEvent):void {
			//trace("click goes the timer");
			if (_lifetime > 0) {
				_lifetime--;
				//trace(lifetime);
			} else {
				destroy();
			}
		}
		
		public function loop(e:Event) : void
		{
			y += vy;
			x += vx;
 
			//if (x > 1040 || y > 780 || x < -20 || y < -20)
			//	destroy();
			if (this.y > stage.stageHeight+1)
					this.y = 1;
			if (this.x > stage.stageWidth+1)
					this.x = 1;
			if (this.y < 0)
					this.y = stage.stageHeight;
			if (this.x < 0)
					this.x = 1024;
					
					
			//trace("bullet.x " + this.x);
		}
 
		public function destroy() : void
		{
			//Game(parent).bullets.splice(this);
			
			var i:int = _game.bullets.indexOf(this);
			_game.bullets.splice(i, 1);
			
			if (parent)
				parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loop);
			myTimer.removeEventListener(TimerEvent.TIMER, timerEvent);
			myTimer = null;
		}
	}

}