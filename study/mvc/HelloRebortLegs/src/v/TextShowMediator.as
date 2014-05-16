package v
{
	import c.event.ChangeModelEvent;
	import c.event.HelloWorldMessageEvent;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.mvcs.Mediator;

	public class TextShowMediator extends Mediator
	{
		[Inject]
		public var view:TextShow;
		
		public function TextShowMediator()
		{
		}
		
		override public function onRegister():void
		{
			view.changeText("befor start");
		//	addContextListener(HelloWorldMessageEvent.MESSAGE_DISPATCHED,handleMessage);
		//	eventMap.mapListener(eventDispatcher,HelloWorldMessageEvent.MESSAGE_DISPATCHED,handleMessage);
			eventMap.mapListener(eventDispatcher,ChangeModelEvent.CHANGE_VALUE,handleMessage);
		}
		
		private function handleMessage(event:ChangeModelEvent):void
		{
			trace("count change");
			view.changeText(event.changeValue.toString());
		}
		
//		private function handleMessage(event:HelloWorldMessageEvent):void
//		{
//			view.changeText(event.message);
//		}
	}
}