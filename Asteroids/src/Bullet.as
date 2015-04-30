package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
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
		private var lifetime:Number = 3;
		private var myTimer:Timer = new Timer(500);
		
		public function Bullet(x:int,y:int,shipRotation:int) {
			init();
			this.rotation = shipRotation;
			vy += Math.sin(degreesToRadians(shipRotation)) * speed;
			vx += Math.cos(degreesToRadians(shipRotation)) * speed;
 
			this.x = x + vx*2;
			this.y = y + vy * 2;
			
			addEventListener(Event.ENTER_FRAME, loop, false, 0, true);
			//trace("shots fired!");
		}
		
		public function degreesToRadians(degrees:Number) : Number
		{
			return degrees * Math.PI / 180;
		}
		
		public function init():void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//trace("shot");
			var image:bullet = new bullet(); //Lowercase == art, placeholder name and probably should be more descriptive.
			addChild(image);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			myTimer.start();
		}
		
		private function timerEvent(e:TimerEvent):void {
			//trace("click goes the timer");
			if (lifetime > 0) {
				lifetime--;
				//trace(lifetime);
			} else {
				destroy();
			}
		}
		
		public function loop(e:Event) : void
		{
			y += vy;
			x += vx;
 
			if (x > 1040 || y > 780 || x < -20 || y < -20)
				destroy();
		}
 
		public function destroy() : void
		{
			if (parent)
				parent.removeChild(this);
 
			removeEventListener(Event.ENTER_FRAME, loop);
		}
	}

}