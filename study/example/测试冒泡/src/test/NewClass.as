package test 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import event.NewEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NewClass extends Sprite
	{
		
		public function NewClass() 
		{
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(evt:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			initNewClass();
		}
		
		private function initNewClass():void {
			this.graphics.beginFill(0xFFFFFF, .5);
			this.graphics.drawRect(100, 100, 100, 100);
			this.graphics.endFill();		
			
			var myNewClass:NewClass2 = new NewClass2();
			myNewClass.addEventListener(NewEvent.TEST_EVENT, testEventHandler);
			
			//myNewClass.addEventListener(MouseEvent.CLICK, testMouseHandler,true);	//中间层是无法捕获事件的
			myNewClass.addEventListener(MouseEvent.CLICK, testMouseHandler); 
			
			addChild(myNewClass);		
		}		
		
		private function testEventHandler(newEvt:NewEvent):void {
			trace(this);
			trace(newEvt);
			//newEvt.stopImmediatePropagation();
		}
		
		private function testMouseHandler(newEvt:MouseEvent):void {
			trace(this);
			trace(newEvt);
		}
	}

}