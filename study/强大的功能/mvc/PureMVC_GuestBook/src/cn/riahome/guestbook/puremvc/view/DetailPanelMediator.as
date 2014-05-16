package cn.riahome.guestbook.puremvc.view
{
	import cn.riahome.guestbook.puremvc.ApplicationFacade;
	import cn.riahome.guestbook.puremvc.model.vo.TopicVO;
	import cn.riahome.guestbook.puremvc.view.UI.DetailPanel;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class DetailPanelMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "DetailPanelMediator";
		
		public function DetailPanelMediator( viewComponent:Object )
		{
			super( NAME, viewComponent);
		}
		
		public function get detailPanel():DetailPanel
		{
			return viewComponent as DetailPanel;
		}
		
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.SELECT_TOPIC
					];
		}
		
		override public function handleNotification(note:INotification):void
		{
			switch( note.getName() )
			{
				case ApplicationFacade.SELECT_TOPIC:
					var topic:TopicVO = TopicVO( note.getBody() );
					detailPanel.topic = topic;
					break;
			}
		}
		
	}
}