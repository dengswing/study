package 
{
	import event.NewEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import test.NewClass;
	import test.NewClass2;
	
	[SWF (backgroundColor = 0x000000) ]	
	
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
			
			var myNewClass:NewClass = new NewClass();
			myNewClass.addEventListener(NewEvent.TEST_EVENT, testEventHandler,true); //接收孙级冒泡.	注:第三个参数为true:运行于捕获阶段.即事件重最上层开始
			myNewClass.addEventListener(NewEvent.TEST_EVENT, testEventHandler); //接收孙级冒泡.	注:第三个参数为false:运行于目标或冒泡阶段.即事件重最下层开始
			
			myNewClass.addEventListener(MouseEvent.CLICK, testMouseHandler, true); //内部API 事件,默认是冒泡。自定义事件，设置bubbles 为true即可
			
			addChild(myNewClass);	
		}
		
		private function testEventHandler(newEvt:NewEvent):void {
			trace(this);
			trace(newEvt);		
			
			//newEvt.stopImmediatePropagation();	//停止处理后面事件	
			
			var myNewClass:NewClass2 = new NewClass2();
			
			myNewClass.x = 100;
			myNewClass.y = 100;			
			addChild(myNewClass);	
		}
		
		private function testMouseHandler(newEvt:MouseEvent):void {
			trace(this);
			trace(newEvt);
		}
		
	}
	
}