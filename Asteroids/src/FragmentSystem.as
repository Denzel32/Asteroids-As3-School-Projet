package  
{
	import flash.display.Sprite;
	import flash.events.Event
	/**
	 * ...
	 * @author Ferdi Alleman
	 */
	public class FragmentSystem extends Sprite
	{
		private var _game:Game;
		private var _fragmentsToSpawn:Number;
		
		public function FragmentSystem(game:Game, spawnThisManyFragments:Number = 3) {
			_game = game;
			if (spawnThisManyFragments <= 0) {
				Error("You're spawning " + spawnThisManyFragments + " fragments! Feeding a value equal to 0 or lower can cause errors.");
				//Just to be safe.
			}
			_fragmentsToSpawn = spawnThisManyFragments;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void {
			
		}
	}

}