package mvc.view 
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import mvc.EkoFacade;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ...
	 * @author eko
	 */
	public class BtnMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "BtnMediator";
		public function BtnMediator(viewComponent:SimpleButton) 
		{
			super(NAME, viewComponent);
			btnEko.addEventListener(MouseEvent.CLICK, onClick);
		}
		private function onClick(e:MouseEvent):void
		{
			sendNotification(EkoFacade.CHANGETEXT,"人人都爱Eko");
		}
		public function get btnEko():SimpleButton
		{
			return viewComponent as SimpleButton;
		}
	}
	
}