package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import oldcode.LevelSelect;
	
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Main extends Sprite 
	{	
		private var _game			: 	Game 			= new Game(new LEVEL2ANIMATIE);
		private var _mainMenu		: 	MainMenu 		= new MainMenu();
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MainMenu.LEVEL_SELECTED, StartGame);
			addEventListener(Game.ENDGAME, endGame);
			addChild(_mainMenu);
			
		}

		private function StartGame(e:Event):void 
		{
			removeChild(_mainMenu);
			addChild(_game);
		}
		
		private function endGame():void {
			trace("Game ended by main");
			removeChild(_game);
			_game = null;
			addChild(_mainMenu);
		}
	}
	
}