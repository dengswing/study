package event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NewEvent extends Event 
	{
		
		public static const TEST_EVENT:String = "test_event";
		
		public function NewEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);			
		} 
		
		public override function clone():Event 
		{ 
			return new NewEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("NewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}