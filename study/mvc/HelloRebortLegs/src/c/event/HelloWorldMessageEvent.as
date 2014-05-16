package c.event
{
	import flash.events.Event;

	public class HelloWorldMessageEvent extends Event
	{
		public static const MESSAGE_DISPATCHED:String = "messageDispatched";
		private var _message:String;
		
		public function HelloWorldMessageEvent(type:String,message:String,bubbles:Boolean=false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
			_message = message;
		}

		public function get message():String
		{
			return _message;
		}
	}
}