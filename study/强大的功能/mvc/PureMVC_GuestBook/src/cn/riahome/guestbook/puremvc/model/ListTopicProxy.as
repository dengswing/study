package cn.riahome.guestbook.puremvc.model
{
	import cn.riahome.guestbook.puremvc.ApplicationFacade;
	import cn.riahome.guestbook.puremvc.model.vo.TopicVO;
	
	import flash.net.URLVariables;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class ListTopicProxy extends Proxy implements IProxy
	{
		/**
		 * 
		 * 目前分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as
		 * 完整分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
		 * 
		 * 为这个 Proxy(这里为ListTopicProxy) 起一个名字. 这个名字是唯一的, 且应该定义为静态的常量.
		 **/
		public static const NAME:String = "ListTopicProxy";
		
		private var httpService:HTTPService;
		
		public function ListTopicProxy()
		{
			/**
			 * 每一个 Proxy 都有一个 data 属性, 用来存储需要传递的数据, 就是用来携带数据的.
			 * 这里必须先调用父类的构造函数, 把自己的名字和携带的 数据/数据类型 传进父类的构造函数
			 * 下面传递的第二个参数是一个 ArrayCollection, 当执行 super() 后, data(Object类型)属性就会变为一个 ArrayCollection.
			 **/
			super(NAME, new ArrayCollection() );
			
			/**
			 * 在每个 Proxy 里面, 一定要做的事情就是上面的两项: 为自己起一个名字 以及 先调用父类的构造函数
			 * 然后具体要做的事情, 就根据需要而定了.
			 * 这里要做的事是: 从服务端获取留言数据, 当获取数据完成后, 就发布一个通知来告诉大家:"我完成了向服务端获取留言数据了,我拥有这些数据".
			 * 您看看下面的 onResult() 函数, 该函数里有一条语句: sendNotification( ApplicationFacade.GET_ALL_TOPIC_COMPLETE, data ).
			 * 第一个参数就是通知消息, 以静态常量的方式在 ApplicationFacade 类里定义了.
			 **/
			
			httpService = new HTTPService();
			httpService.method = mx.messaging.messages.HTTPRequestMessage.GET_METHOD;
			httpService.resultFormat = HTTPService.RESULT_FORMAT_XML;
			httpService.url = "http://localhost:8888/php/listTopic.php"; // 这里的 url 根据您的虚拟目录不同而不同
			httpService.addEventListener( ResultEvent.RESULT, onResult );
			httpService.addEventListener( FaultEvent.FAULT, onFault);
		}
		
		private function onResult( event:ResultEvent ):void
		{
			var arr:ArrayCollection = new ArrayCollection();
			var result:XMLList = XML( event.result ).children();
			
			for( var i:uint = 0; i < result.children().length(); i++)
			{
				var o:TopicVO = new TopicVO( result[i].@id, result[i].@addTime, result[i].@username, result[i] );
				arr.addItem( o );
			}
			
			data = arr;
			/**
			 * 通知: 各单位注意, 我完成了向服务端获取留言数据了,我拥有这些数据, 有意者请接收通知!
			 * 在这个例子里, 希望得到这些数据的当然是 ListPanel.mxml 了.
			 * 但, 之前已经说过, 取得数据这类的工作并不用 UI(也说是component) 来完成, 这些工作由 UI 的中介器(Mediator)来完成.
			 * 在这里, ListPanel.mxml 的中介器是 ListPanelMediator.
			 * 现在, 请您打开 ListPanelMediator.as 文件, 或者在 "分析途经" 路线上退回上一级(也就是 StartupCommand.as 文件),
			 * 然后找到 facade.registerMediator( new ListPanelMediator( app.listPanel ) ) 这一句,
			 * 按着 Ctrl 键点击 ListPanelMediator, 进入去看看源码.
			 * 
			 * 目前 分析途经: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as
			 * 
			 **/
			sendNotification( ApplicationFacade.GET_ALL_TOPIC_COMPLETE, data );
		}
		
		private function onFault( event:FaultEvent ):void
		{
			Alert.show( event.message.toString(), "提示");
		}
		
		public function getAllTopic():void
		{
			httpService.send( new URLVariables("ran="+Math.random()) ); // 给一个随机参数, 避免缓存
		}
	}
}