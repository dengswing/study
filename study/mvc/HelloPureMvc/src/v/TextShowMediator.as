package v
{
	import context.ApplicationFacade;
	
	import m.BallDataProxy;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class TextShowMediator extends Mediator implements IMediator
	{
		// Cannonical name of the Mediator
		public static const NAME:String = 'TextShowMediator';
		private var ballDataProxy:BallDataProxy;
		public function TextShowMediator(viewComponent:Object)
		{
			super(NAME,viewComponent);
			ballDataProxy = facade.retrieveProxy(BallDataProxy.NAME) as BallDataProxy;
			
			textShow.changeText("before start");
		}
		
		override public function handleNotification(note:INotification):void 
		{
			switch (note.getName()) {
				case ApplicationFacade.BALL_CLICK:
					textShow.changeText(ballDataProxy.count.toString());
					break;
			}
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				ApplicationFacade.BALL_CLICK
			];
		}
		
		protected function get textShow():TextShow
		{
			return viewComponent as TextShow;
		}
	}
}