package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Intro extends Sprite
	{
		private var gameIntro: video = new video();
		public static const INTRO_END:String = "EndOfIntro";
		
		public function Intro() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
			addChild(gameIntro);
			gameIntro.x = stage.stageWidth / 2;
			gameIntro.y = stage.stageHeight / 2;
		}
		
		private function update(e:Event):void 
		{
			if (gameIntro.currentFrame >= gameIntro.totalFrames)
			{
				dispatchEvent(new Event(INTRO_END, truegir));
			}
		}
		
	}

}