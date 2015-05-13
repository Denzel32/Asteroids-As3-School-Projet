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
		private var _upgradeScreen: UpgradeScreen = new UpgradeScreen();
		public var speed = 5;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MainMenu.GAME_START, StartGame);
			addEventListener(Game.DEATH, ScreenUpgrade);
			// entry point
			addChild(_mainMenu);
		}
		
		private function ScreenUpgrade(e:Event):void 
		{
			removeChild(_game);
			_game = null;
			addChild(_upgradeScreen);
		}
		
		private function StartGame(e:Event):void 
		{
			trace("startgame");
			removeChild(_mainMenu);
			addChild(_game);
		}
		
	}
	
}