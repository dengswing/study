package cn.riahome.guestbook.puremvc.model
{
	import cn.riahome.guestbook.puremvc.ApplicationFacade;
	
	import flash.net.URLVariables;
	
	import mx.controls.Alert;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class InsertTopicProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "InsertTopicProxy";
		
		private var httpService:HTTPService;
		
		public function InsertTopicProxy()
		{
			super( NAME, data );
			
			httpService = new HTTPService();
			httpService.method = mx.messaging.messages.HTTPRequestMessage.GET_METHOD;			
			httpService.resultFormat = HTTPService.RESULT_FORMAT_TEXT;
			httpService.url = "http://localhost:8888/php/insertTopic.php"; // 这里的 url 根据您的虚拟目录不同而不同
			httpService.addEventListener( ResultEvent.RESULT, onResult );
			httpService.addEventListener( FaultEvent.FAULT, onFault );
		}
		
		private function onResult( event:ResultEvent ):void
		{
			var str:String = event.result.toString();
			
			if( str == "true" )
			{
				Alert.show( "留言成功", "提示");
				sendNotification( ApplicationFacade.INSERT_TOPIC_COMPLETE, 3 );
			}else
			{
				Alert.show( "留言失败: " + str, "提示");
			}
		}
		
		private function onFault( event:FaultEvent ):void
		{
			Alert.show( event.message.toString(), "提示" );
		}
		
		public function insertTopic( username:String, content:String ):void
		{
			var data:URLVariables = new URLVariables();
			data.username = username;
			data.content = content;
			
			httpService.send( data );
		}
		
	}
}