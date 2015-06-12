package 
{
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
		private var background: menubg = new menubg();
		//public static const LEVEL_SELECTED:String = "levelSelected";
	
		public function MainMenu() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function OnClick(e:MouseEvent):void 
		{			
			if (e.target == start_button)
			{
				dispatchEvent(new Event(GAME_START, true));
			}
			
			if (e.target == controls_button)
			{
				
			}
			
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
			
			stage.addEventListener(MouseEvent.CLICK, OnClick);
			background.x = stage.stageWidth / 2 + 510;
			background.y = stage.stageHeight / 2;
			addChild(background);
			start_button.x = stage.stageWidth / 2;
			start_button.y = 350;
			controls_button.x = stage.stageWidth / 2;
			controls_button.y = 470;
			credits_button.x = stage.stageWidth / 2;
			credits_button.y = 590;
			addChild(start_button);
			addChild(controls_button);
			addChild(credits_button);
		}	
	}
}