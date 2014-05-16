package index.base.events{
	
	import flash.events.Event;
	
	public class DirectionEvent extends Event{
		
		public var up:Boolean;
		public var down:Boolean;
		public var left:Boolean;
		public var right:Boolean;
		
		public static const DO:String = "do";
		
		public function DirectionEvent(type:String){
			super(type);
		}
	}
}