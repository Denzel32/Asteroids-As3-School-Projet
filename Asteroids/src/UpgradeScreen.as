package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class UpgradeScreen extends Sprite 
	{	
		private var _txtfield: TextField = new TextField();
		private var _button: SimpleButton = new SimpleButton();
		private var _buttonSprite:Sprite =  new Sprite();
		public function UpgradeScreen() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			_txtfield.text = "your stats:";
			_txtfield.x = 50;
			_txtfield.y = stage.stageHeight / 2;
			_buttonSprite.graphics.lineStyle(1, 0x555555);
			_buttonSprite.graphics.beginFill(0xff000,1);
			_buttonSprite.graphics.drawRect(0,0,200,30);
			_buttonSprite.graphics.endFill();
			
			_button.overState = _button.downState =  _button.upState = _button.hitTestState = _buttonSprite;
			addChild(_button);
			addChild(_txtfield);
			_button.x = 10;
			_button.y = stage.stageHeight / 2;
		}
		
	}
}