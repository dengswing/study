package v
{
	import c.event.HelloWorldMessageEvent;
	
	import flash.events.MouseEvent;
	
	import m.MyModel;
	
	import org.robotlegs.base.EventMap;
	import org.robotlegs.mvcs.Mediator;

	public class BallMediator extends Mediator
	{
		[Inject]
		public var ball:Ball;
		[Inject]
		public var myModel:MyModel;
		
		public function BallMediator()
		{
		}
		
		override public function onRegister():void
		{
			trace("ball onregister");
	//		ball.addEventListener(MouseEvent.CLICK,clickHandler);
			eventMap.mapListener(ball,MouseEvent.CLICK,clickHandler);
			eventMap.mapListener(eventDispatcher,HelloWorldMessageEvent.MESSAGE_DISPATCHED,change);
		}
		
		private function change(e:HelloWorldMessageEvent):void
		{
			ball.poke();
			trace("ball Change")
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			trace("ball click");
			myModel.count++;
			ball.poke();
	
			dispatch(new HelloWorldMessageEvent(HelloWorldMessageEvent.MESSAGE_DISPATCHED,"new ball create!"));
//			ball.clearBall();
		}
	}
}