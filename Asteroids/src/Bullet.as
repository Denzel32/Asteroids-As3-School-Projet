package  
{
	import flash.display.MovieClip;
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
		private var _lifetimeBackup:Number;
		private var _game:Game;
		private var _stageHeight:int;
		private var _stageWidth:int;
		private var _flying:MovieClip = new blastFly();
		private var _dying:MovieClip = new blastEnd();
		public var state:int = 0;
		/*Sprite states:
		 * 0 = fired !!OLD!!
		 * 1 = flying
		 * 2 = dying
		 */
		
		public function Bullet(game:Game, pos:Point,shipRotation:int,lifetime:Number = 1) {
			
			_lifetime = lifetime;
			_lifetimeBackup = lifetime;
			addEventListener(Event.ADDED_TO_STAGE, init);
			
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
		
		public function init(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			myTimer.addEventListener(TimerEvent.TIMER, timerEvent);
			addEventListener(Event.ENTER_FRAME, _update);
			myTimer.start();
			_flying.visible = false;
			_dying.visible = false;
			addChild(_flying);
			addChild(_dying);
			_stageHeight = stage.stageHeight;
			_stageWidth = stage.stageWidth;
		}
		
		private function spriteState():void {
			trace(state + " :state -- lifetime: " + _lifetime);
			if (_lifetime == _lifetimeBackup) {
				state = 1;
			} else if (_lifetime <= 0) {
				state = 2;
			} else {
				state = 1;
			}
			
			switch(state) {
				case 1:
					_flying.visible = true;
					_dying.visible = false;
					break;
				case 2:
					_flying.visible = false;
					_dying.visible = true;
					break;
			}
		}
		
		private function _update(e:Event):void {
			spriteState();
		}
		
		private function timerEvent(e:TimerEvent):void {
			if (_lifetime > 0) {
				_lifetime--;
			} else {
				//destroy();
			}
		}
		
		public function loop(e:Event) : void
		{
			if (_dying.currentFrame >= _dying.totalFrames && _dying.visible == true) {
				_dying.stop();
				destroy();
			}
			if (state < 2) {
				y += vy;
				x += vx;
				//if (x > 1040 || y > 780 || x < -20 || y < -20)
				//	destroy();
				if (this.y > _stageHeight+1)
						this.y = 1;
				if (this.x > _stageWidth+1)
						this.x = 1;
				if (this.y < 0)
						this.y = _stageHeight;
				if (this.x < 0)
						this.x = _stageWidth;
			}
					
			
			//trace("bullet.x " + this.x);
		}
 
		public function destroy() : void
		{
			//Game(parent).bullets.splice(this);
			
			var i:int = _game.bullets.indexOf(this);
			_game.bullets.splice(i, 1);
			
			_game.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, loop);
			removeEventListener(Event.ENTER_FRAME, _update);
			myTimer.removeEventListener(TimerEvent.TIMER, timerEvent);
			myTimer = null;
		}
	}

}