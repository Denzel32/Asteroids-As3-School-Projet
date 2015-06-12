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
		private var _game			: 	Game 			= new Game();
		private var _levelSelect	: 	LevelSelect 	= new LevelSelect();
		private var _mainMenu		: 	MainMenu 		= new MainMenu();
		private var _controlscreen	: Controls = new Controls();
		private var _creditsScreen	: Credits = new Credits();
		private var _introscreen	: Intro = new Intro();
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MainMenu.GAME_START, StartGame);
			//addEventListener(LevelSelect.LEVEL_SELECTED, StartLevel);
			addEventListener(Intro.INTRO_END, EndOfIntro);
			addEventListener(Game.ENDGAME, NextLevel)
			addChild(_mainMenu);
		}
		
		private function EndOfIntro(e:Event):void 
		{
			removeChild(_introscreen);
			addChild(_game);
		}
		
		private function NextLevel(e:Event):void 
		{	
			//trace("am I listening");
			
			removeChild(_game);
			_game = new Game();
			addChild(_game);
			//trace(_game.levelNumber);
		}

		private function StartGame(e:Event):void 
		{
			removeChild(_mainMenu);
			addChild(_introscreen);
			//addChild(_game);
			//addChild(_creditsScreen);
			//addChild(_levelSelect);
		}
		
		private function StartLevel(e:Event):void 
		{
			//trace("event dispatched");
			removeChild(_levelSelect);
			addChild(_game);
		}
		
		
	}
	
}