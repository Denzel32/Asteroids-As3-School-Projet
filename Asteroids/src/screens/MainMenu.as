package screens {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class MainMenu extends Sprite
	{	
		/*private var _txtfield: TextField = new TextField();*/
		public static const GAME_START: String = "startGame";
		
		private var start_button: Start_Button = new Start_Button();
		private var controls_button: Controls_Button = new Controls_Button();
		private var credits_button: Credits_Button = new Credits_Button();
		private var background:MovieClip = new menubg();
		private var creditsScreen:MovieClip = new credits();
		private var controlsScreen:MovieClip = new controls();
		private var gameover:MovieClip;
		private var winscreen:MovieClip;
		private var backButton:back_button = new back_button();
		private var currentScreen:MovieClip;
		private var stageWidth:int;
		private var stageHeight:int;
		//public static const LEVEL_SELECTED:String = "levelSelected";
	
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function cameFromGame(why:int):void {
			switch(why) {
				case 1:
					makeSideScreen(creditsScreen);
					currentScreen = creditsScreen;
					//player won and finished the game
					break;
				case 2:
					makeSideScreen(controlsScreen);
					currentScreen = controlsScreen;
					//player lost and the game ended
					break;
			}
		}
		
		private function OnClick(e:MouseEvent):void 
		{			
			if (e.target == start_button && backButton.visible == false) {
				dispatchEvent(new Event(GAME_START, true));
			}
			
			if (e.target == credits_button && backButton.visible == false) {
				makeSideScreen(creditsScreen);
				currentScreen = creditsScreen;
			}
			
			if (e.target == controls_button && backButton.visible == false) {
				makeSideScreen(controlsScreen);
				currentScreen = controlsScreen;
				addChild(backButton);
			}
			
			if (e.target == backButton && backButton.visible == true) {
				removeChild(currentScreen);
				currentScreen = null;
				backButton.visible = false;
			}
		}
		
		private function makeSideScreen(_screen:MovieClip):void {
			addChild(_screen);
			_screen.scaleX = 1;
			_screen.scaleY = 1;
			_screen.x = stageWidth / 2;
			_screen.y = stageHeight / 2;
			addChild(backButton);
			backButton.visible = true;
			backButton.x = stageWidth / 2 + 250;
			backButton.y = stageHeight / 2 + 300;
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			/*stage.addEventListener(MouseEvent.CLICK, OnClick);
			addChild(_txtfield);
			_txtfield.text = "Left mouse click to start the game";
			_txtfield.width = 300;
			_txtfield.x  = stage.stageWidth / 2;
			_txtfield.y = stage.stageHeight / 2;*/
			
			stageHeight = stage.stageHeight;
			stageWidth = stage.stageWidth;
			
			stage.addEventListener(MouseEvent.CLICK, OnClick);
			background.x = background.width;
			background.y = stageHeight / 2;
			addChild(background);
			start_button.x = stageWidth / 2;
			start_button.y = 350;
			controls_button.x = stageWidth / 2;
			controls_button.y = 470;
			credits_button.x = stageWidth / 2;
			credits_button.y = 590;
			addChild(start_button);
			addChild(controls_button);
			addChild(credits_button);
			backButton.visible = false;
		}	
	}
}