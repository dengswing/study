package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			initMain();
			
			
		}
		
		private function initMain():void {
			var rect_1:Sprite = new DrawRect();
			var rect_2:Sprite = new DrawRect();
			
			rect_1.x = 100;
			addChild(rect_1)
			
			
			rect_2.x = 250;
			addChild(rect_2)			
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, listenerHandler1);
			this.addEventListener(MouseEvent.MOUSE_UP, listenerHandler2);
			
			rect_1.addEventListener(MouseEvent.CLICK, childHandler);
			rect_2.addEventListener(MouseEvent.CLICK, childHandler);
			
		}
		
		private function listenerHandler1(mouseEvt:MouseEvent):void {
			//trace("listenerHandler1=" + mouseEvt);		
			//mouseEvt.stopImmediatePropagation();
			
			this.addEventListener(MouseEvent.CLICK, listenerHandler,true);	//捕获事件
		}
		
		private function listenerHandler(mouseEvt:MouseEvent):void {
			trace("this=" + mouseEvt);		
			mouseEvt.stopImmediatePropagation();	//停止触发事件
			
			this.removeEventListener(MouseEvent.CLICK, listenerHandler,true);
		}
		
		private function childHandler(mouseEvt:MouseEvent):void {
			trace(mouseEvt);
			//mouseEvt.stopImmediatePropagation();
		}		
	
			
		private function listenerHandler2(mouseEvt:MouseEvent):void {
			//trace("listenerHandler2="+mouseEvt);			
		}
	}
	
}

class DrawRect extends flash.display.Sprite {
	
	public function DrawRect() {
		init();
	}
	
	private function init():void {
		this.graphics.beginFill(0x666666, 1);
		this.graphics.drawRect(0, 0, 100, 100);
		this.graphics.endFill();	
	}
}