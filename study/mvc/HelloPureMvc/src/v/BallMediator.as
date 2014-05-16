package v
{
	import context.ApplicationFacade;
	
	import flash.events.MouseEvent;
	
	import m.BallDataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;


	public class BallMediator extends Mediator implements IMediator
	{	
		// Cannonical name of the Mediator
		public static const NAME:String = 'BallMediator';
		private var ballDataProxy:BallDataProxy;
		
		public function BallMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
			
			ballDataProxy = facade.retrieveProxy(BallDataProxy.NAME) as BallDataProxy;
			
			// Listen for events from the view component 
			ball.addEventListener(MouseEvent.CLICK,clickHandler);
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				ApplicationFacade.BALL_CLICK
			];
		}
		
		override public function handleNotification(note:INotification):void 
		{
			switch (note.getName()) {
				case ApplicationFacade.BALL_CLICK:
					ball.poke();
					break;
			}
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			ballDataProxy.count++;
			ball.poke();
		}
		
		protected function get ball():Ball
		{
			return viewComponent as Ball;
		}
		
		
		
	//	override public function onRegister():void
	//	{
	//		trace("ball onregister");
	//		ball.addEventListener(MouseEvent.CLICK,clickHandler);
	//		eventMap.mapListener(ball,MouseEvent.CLICK,clickHandler);
	//		eventMap.mapListener(eventDispatcher,HelloWorldMessageEvent.MESSAGE_DISPATCHED,change);
		}
		
//		private function change(e:HelloWorldMessageEvent):void
//		{
//			ball.poke();
//		}
//		
//		private function clickHandler(e:MouseEvent):void
//		{
//			trace("ball click");
//			myModel.count++;
//			ball.poke();
//	
//			dispatch(new HelloWorldMessageEvent(HelloWorldMessageEvent.MESSAGE_DISPATCHED,"new ball create!"));
////			ball.clearBall();
//		}
}