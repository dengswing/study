package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Example2 extends Sprite 
	{
		private static var _instance:Example2;
		
		private var myExample3:Example3;
		
		private var _currentEvent:Event;
		
		public function Example2(singleton:Singleton) {	}		
		
		public static function getInstance():Example2 {
			if (_instance == null)			
				_instance = new Example2(new Singleton());
			return _instance;
		}
		
		public function init():void {
			myExample3 = new Example3();
			myExample3.addEventListener(Example3.TESTEVENT, testEventHandler);
			myExample3.init();
			
			createContent();
		}
		
		private function createContent():void {
			var mySprite:Sprite = new Sprite();
			mySprite.graphics.beginFill(0xFFFF00, 1);
			mySprite.graphics.drawCircle(0, 0, 20);
			mySprite.graphics.endFill();

			addChild(mySprite);
			
			mySprite.x = mySprite.y = 100;
			mySprite.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(mouseEvt:MouseEvent):void {
			myExample3.touchEvent();
		}
		
		private function testEventHandler(evt:Event):void {
			_currentEvent = myExample3.currentEvent;
			
			touchEvent();
		}
		
		private function touchEvent():void {
			dispatchEvent(new Event(Example3.TESTEVENT));			
		}
		
		
		public function get currentEvent():Event { return _currentEvent; }
		
	}
	
}

class Singleton { };