package DemoEvent{

	import DemoEvent.PickEvent;
	
	import flash.events.EventDispatcher;

	public class PickEventDispatcher extends EventDispatcher {

		public function PickEventDispatcher()
		{
			super();
		}

		public function doMouseDown(num:Number, eventFlag:int,id:int):void
		{
			var _evt:PickEvent = new PickEvent(PickEvent.M_DOWN);
			_evt.params = {'index':num, 'eventFlag':eventFlag,'id':id};
			dispatchEvent(_evt);
		}
		public function doMouseUp(eventType:String = ''):void
		{
			var _evt:PickEvent = new PickEvent(PickEvent.M_UP);
			_evt.params = {'eventType':eventType};
			dispatchEvent(_evt);
		}
	}
}