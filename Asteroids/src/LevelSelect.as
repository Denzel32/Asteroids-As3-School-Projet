package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Denzel Dap
	 */
	public class LevelSelect extends Sprite
	{	
		private var button: SimpleButton = new SimpleButton();
		private var button2: SimpleButton = new SimpleButton();
		public static const LEVEL_SELECTED:String = "levelSelected";
		
		public function LevelSelect() 
		{
			addEventListener(Event.ADDED_TO_STAGE, Init);
			
		}
		
		private function Init(e:Event):void 
		{	
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			stage.addEventListener(MouseEvent.CLICK, OnClick);
			var myButtonSprite: Sprite = new Sprite();
			myButtonSprite.graphics.lineStyle(1, 0x555555);
			myButtonSprite.graphics.beginFill(0xff000,1);
			myButtonSprite.graphics.drawRect(0,0,200,30);
			myButtonSprite.graphics.endFill();
			button.overState = button.downState = button.upState = button.hitTestState = myButtonSprite;
			addChild(button);
			
			var myButtonSprite2: Sprite = new Sprite();
			myButtonSprite2.graphics.lineStyle(1, 0x555555);
			myButtonSprite2.graphics.beginFill(0xff000,1);
			myButtonSprite2.graphics.drawRect(210,0,200,30);
			myButtonSprite2.graphics.endFill();
			button2.overState = button2.downState = button2.upState = button2.hitTestState = myButtonSprite2;
			addChild(button2);
		}
		
		private function OnClick(e:MouseEvent):void 
		{
			if (e.target == button)
			{
				dispatchEvent(new Event(LEVEL_SELECTED, true));
			}
			
			if (e.target == button2)
			{
				
			}
		}
	}
}