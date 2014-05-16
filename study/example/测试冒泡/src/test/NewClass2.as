package test 
{
	import event.NewEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NewClass2 extends Sprite
	{
		
		public function NewClass2() 
		{
			initNewClass();
		}
		
		private function initNewClass():void {
			this.graphics.beginFill(0xFFFFFF, .5);
			this.graphics.drawRect(300, 100, 50, 50);
			this.graphics.endFill();	
			
			this.addEventListener(MouseEvent.CLICK, clickHandler);
		}		
		
		private function clickHandler(mouseEvt:MouseEvent):void {
			/*trace(this);
			trace(mouseEvt)*/
			
			dispatchEvent(new NewEvent(NewEvent.TEST_EVENT, true)); //设置true 冒泡
			
		}
		
	}

}