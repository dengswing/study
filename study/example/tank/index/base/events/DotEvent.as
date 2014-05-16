package index.base.events{
	
	import flash.events.Event;
	
	public class DotEvent extends Event{
		
		public static const X_CHANGE:String = "xChange";
		public static const Y_CHANGE:String = "yChange";
		public static const R_CHANGE:String = "rChange";
		
		public function DotEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false){
			super(type,bubbles,cancelable);
		}
	}
}