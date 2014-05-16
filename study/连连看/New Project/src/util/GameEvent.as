package util
{
	import flash.events.Event;

	public class GameEvent extends Event {
		public static const XMLLOADED:String = "XMLLOADED";
		public static const XMLLOADFAIL:String = "XMLLOADFAIL";
		public static const XMLPROGRESS:String = "XMLPROGRESS";
		
		public var _evt:Object;
		public function GameEvent(type:String,evt:Object = null) {
			super(type);
			_evt = evt;
		}
		
		public function get getEvt() : Object
		{
			return _evt
		}
	}
}