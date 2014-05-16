package mvc.view 
{
	import flash.text.TextField;
	import mvc.EkoFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author eko
	 */
	public class TextMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "TextMediator";
		public function TextMediator(viewComponent:TextField) 
		{
			super(NAME, viewComponent);
		}
		override public function listNotificationInterests():Array
		{
			return [EkoFacade.CHANGETEXT];
		}
		override public function handleNotification(note:INotification):void
		{

			switch(note.getName())
			{
				case EkoFacade.CHANGETEXT:
					txtEko.text = note.getBody() as String;
					break;
			}
		}
		private function get txtEko():TextField
		{
			return viewComponent as TextField;
		}
	}
	
}