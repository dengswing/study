package cn.riahome.guestbook.puremvc.view
{
	import cn.riahome.guestbook.puremvc.model.InsertTopicProxy;
	import cn.riahome.guestbook.puremvc.view.UI.InsertPanel;
	
	import flash.events.MouseEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class InsertPanelMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "InsertPanelMediator";
		
		public function InsertPanelMediator( viewComponent:Object )
		{
			super( NAME, viewComponent );
			
			insertPanel.submitBtn.addEventListener( MouseEvent.CLICK, onSubmit );
		}
		
		public function get insertPanel():InsertPanel
		{
			return viewComponent as InsertPanel;
		}
		
		private function onSubmit( event:MouseEvent ):void
		{
			if( insertPanel.username.text == "" )
			{
				insertPanel.username.errorString = "请填写用户名";
				return;
			}else
			{
				insertPanel.username.errorString = "";
			}
			
			if( insertPanel.content.text == "" )
			{
				insertPanel.content.errorString = "请填写内容";
				return;
			}else
			{
				insertPanel.content.errorString = "";
			}
			
			var insertTopicProxy:InsertTopicProxy = (facade.retrieveProxy( InsertTopicProxy.NAME )) as InsertTopicProxy;
			insertTopicProxy.insertTopic( insertPanel.username.text, insertPanel.content.text );
		}
		
	}
}