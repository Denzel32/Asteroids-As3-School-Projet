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
<<<<<<< HEAD
		private var _game			: 	Game 			= new Game();
		private var _levelSelect	: 	LevelSelect 	= new LevelSelect();
		private var _mainMenu		: 	MainMenu 		= new MainMenu();
		private var _upgradeScreen	: 	UpgradeScreen 	= new UpgradeScreen();
=======
		private var _game	: Game = new Game();
		private var _mainMenu: MainMenu = new MainMenu();
		private var _upgradeScreen: UpgradeScreen = new UpgradeScreen();
		
		public var speed:Number = 5;
>>>>>>> origin/master
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MainMenu.GAME_START, StartGame);
			addEventListener(LevelSelect.LEVEL_SELECTED, StartLevel);
			addChild(_mainMenu);
		}
		
		/*private function ScreenUpgrade(e:Event):void 
		{
			removeChild(_game);
			_game = null;
			addChild(_upgradeScreen);
		}*/
		
		private function StartGame(e:Event):void 
		{
			trace("startgame");
			removeChild(_mainMenu);
			//addChild(_game);
			addChild(_levelSelect);
		}
		
		private function StartLevel(e:Event):void 
		{
			trace("event dispatched");
			removeChild(_levelSelect);
			addChild(_game);
		}
		
		
	}
	
}