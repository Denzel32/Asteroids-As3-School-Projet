package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Main extends Sprite 
	{	
		private var _game	: Game = new Game();
		private var _mainMenu: MainMenu = new MainMenu();
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			addChild(_game);
			addChild(_mainMenu);
		}
		
	}
	
}