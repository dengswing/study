package 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Example3 extends EventDispatcher 
	{
		public static const TESTEVENT:String = "Example3::test_event";
		
		private var _currentEvent:Event
		
		public function Example2() { }
		
		public function init():void {
			
			
		}			
		
		public function touchEvent():void {
			_currentEvent = new Event("hello" + String(Math.random() * 100 << 0));
			
			dispatchEvent(new Event(TESTEVENT));
		}
		
		
		public function get currentEvent():Event { return _currentEvent; }
	}
	
}