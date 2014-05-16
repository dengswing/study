package c.event
{
	import flash.events.Event;

	public class ChangeModelEvent extends Event
	{
		public static const CHANGE_VALUE:String = "CHANGE_VALUE";
		private var _changeValue:int;
		
		public function ChangeModelEvent(type:String,value:int,bubbles:Boolean=false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
			_changeValue = value;
		}

		public function get changeValue():int
		{
			return _changeValue;
		}

	}
}