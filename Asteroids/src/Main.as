package
{
	import screens.Game;
	import screens.MainMenu;
	import screens.Intro;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class Main extends Sprite 
	{	
		private var _game			: Game;
		private var _mainMenu		: MainMenu = new MainMenu();
		private var _levels			: Array	= [//Each object inside this array is a level.
											   //[new BACKGROUND, DIFFICULTY],
											   [new BGlevel1, 1],
											   [new LEVEL2ANIMATIE, 2],
											   [new Animatielevel3, 3]];
		private var _maxLevels		: int;
		private var _controlscreen	: controls = new controls();
		private var _creditsScreen	: credits = new credits();
		private var _introscreen	: Intro;
		private var _debug			: Boolean = false;
		private var _musicTransform : SoundTransform = new SoundTransform(0.3);
		private var _musicChannel	: SoundChannel;
		private var _music			: Array = [gS("http://19415.hosts.ma-cloud.nl/bewijzenmap/periode4/eindproj/lib/sound/vidya_mixdown.mp3"), gS("http://19415.hosts.ma-cloud.nl/bewijzenmap/periode4/eindproj/lib/sound/gamemusic.mp3")];
		public var currentLevel		: int = 0;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, debugInit);
		}
		
		private function gS(i:String):Sound {
			return new Sound(new URLRequest(i));
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(MainMenu.GAME_START, StartGame);
			addEventListener(Intro.INTRO_END, EndOfIntro);
			addEventListener(Game.ENDGAME, NextLevel);
			addChild(_mainMenu);
			_maxLevels = _levels.length;
		}
		
		private function EndOfIntro(e:Event):void 
		{
			removeChild(_introscreen);
			_musicChannel.stop()
			_musicChannel = _music[1].play();
			_game = new Game(this, _levels[currentLevel], _debug);
			addChild(_game);
		}
		
		private function NextLevel(e:Event):void 
		{	
			//trace("am I listening");
			if(_maxLevels > currentLevel + 1) {
				removeChild(_game);
				currentLevel++;
				var toGiveSettings:Array;
				if (_levels[currentLevel] == null) {
					toGiveSettings = [new BGlevel1, currentLevel];
					trace("_levels[_currentLevel] == null, made one to prevent errors. @main");
				} else
					toGiveSettings = _levels[currentLevel];
				_game = new Game(this, toGiveSettings, _debug);
				addChild(_game);
				//trace(_game.levelNumber);
			} else {
				currentLevel = 0;
				finishGame(1);
			}
		}

		private function StartGame(e:Event):void 
		{
			removeChild(_mainMenu);
			_introscreen = new Intro();
			_musicChannel = _music[0].play()
			addChild(_introscreen);
			//addChild(_game);
			//addChild(_creditsScreen);
			//addChild(_levelSelect);
		}
		
		public function finishGame(why:int):void {
			removeChild(_game);
			_musicChannel.stop();
			_mainMenu.cameFromGame(why);
			addChild(_mainMenu);
		}
	}
	
}