package DemoEvent{

	import flash.events.Event;

	public class PickEvent extends Event {
		
		public static const M_DOWN:String = "m_down";
		public static const M_UP:String   = "m_up";
		
		private var _params:Object;

		public function PickEvent( type:String, bubbles:Boolean=true, cancelable:Boolean=false )
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			var _tmp:PickEvent = new PickEvent(type, bubbles, cancelable);
			_tmp.params = _params;
			return _tmp;
		}
		
		
		//---------------------------------------
		// GETTER / SETTERS
		//---------------------------------------
		public function get params():Object
		{
			return _params;
		}
		public function set params(value:Object):void
		{
			_params = value;
		}
	}
}

