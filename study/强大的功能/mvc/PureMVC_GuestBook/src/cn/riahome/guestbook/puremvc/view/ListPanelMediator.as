package cn.riahome.guestbook.puremvc.view
{
	import cn.riahome.guestbook.puremvc.ApplicationFacade;
	import cn.riahome.guestbook.puremvc.model.ListTopicProxy;
	import cn.riahome.guestbook.puremvc.view.UI.ListPanel;
	
	import mx.collections.ArrayCollection;
	import mx.events.ListEvent;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;

	public class ListPanelMediator extends Mediator implements IMediator
	{
		/**
		 * 
		 * 目前分析途经: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
		 * 完整分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
		 * 
		 * 以下是给自己一个唯一的名字, 通过 facade 对象的 registerMediator() 方法找回自己时, 就得用这个唯一的名字了.
		 * **/
		public static const NAME:String = "ListPanelMediator";
		
		public function ListPanelMediator( viewComponent:Object )
		{
			/**
			 * 调用父类的构造函数, 第一个参数传入自己的名字, 上面只是起了名字, 还没写入户口薄或身份证哩, 调用 super() 后才算是写入户口薄.
			 * 如果您是按着 "分析途经" 看过来的话, 那您就应该在 StartupCommand.as 里看过, 应该知道每个 UI(component) 都有一个对应的 Mediator.
			 * 在这里, 这个 ListPanelMediator 就是为那个 ListPanel.mxml 服务的. super() 函数的第二个参数就是指明为哪个 UI(component) 服务.
			 * 那么参数 viewComponent 是在哪里开始传入的呢? 大家回顾 StartupCommand.as 文件, 在注册 ListPanelMediator 时就已经传入了 app.listPanel.
			 * app 是 主文件(Main.mxml)的引用, listPanel 是 app 里的一个 UI(component).
			 * 也就是说, 从一开始在 StartupCommand.as 里注册自己(ListPanelMediator)时, 就已经指明了自己是为哪个 UI(component) 服务的.
			 * 
			 * 看 "分析途经", 上一级的 ListTopicProxy.as 成功获取服务端的数据后, ListPanel.mxml 急切地想得到那些数据,
			 * 但 取得数据 这项工作是由它的中介器(就是本类 ListPanelMediator)来完成的.
			 * 
			 * 上一级的 ListTopicProxy.as 成功获取服务端的数据后, 发布通知, 说已经成功获取数据了.
			 * 然后到了这里, 在这里是怎样接收那个通知的呢? 又是怎样为对应的 UI(component) 完成上述工作的呢?
			 * 请看下面的 listNotificationInterests()函数 和 handleNotification()函数. 第一个实现如何接收通知, 第二个实现相应工作.
			 **/
			super( NAME, viewComponent );
			
			listPanel.dataGrid.addEventListener( ListEvent.ITEM_CLICK, onSelect );
		}
		
		// 通知: 各单位注意, 用户现已选择了一条留言, 需要接收通知的单位请马上接收.
		private function onSelect( event:ListEvent ):void
		{
			sendNotification( ApplicationFacade.SELECT_TOPIC, listPanel.dataGrid.selectedItem );
		}
		
		// 获得对应的 UI(component)
		public function get listPanel():ListPanel
		{
			return viewComponent as ListPanel;
		}
		
		/**
		 * 在下面的函数里列出了所以感兴趣的通知, 包括: GET_ALL_TOPIC_COMPLETE 和 INSERT_TOPIC_COMPLETE.
		 * 上一级的 ListTopicProxy.as 成功获取服务端的数据后, 发布这个通知: GET_ALL_TOPIC_COMPLETE.
		 * 因为本类对这个通知感兴趣, 所以当通知(GET_ALL_TOPIC_COMPLETE)一旦被发布了(不管发布是谁), 本类马上接收了该通知,同时取得该通知所携带的数据.
		 * 接收到通知后, 就进入最下面的 handleNotification() 函数了.
		 * 
		 * (只要把感兴趣的通知放入下面函数的数组里, pureMVC 内部就会把通知从发布者送到接收者手上了. 有兴趣可以打开 pureMVC 的源代码看看内部机制)
		 **/
		override public function listNotificationInterests():Array
		{
			return [
					ApplicationFacade.GET_ALL_TOPIC_COMPLETE,
					ApplicationFacade.INSERT_TOPIC_COMPLETE
					];
		}
		
		/**
		 * 以下函数的参数 note 就是那个通知了. 姑且把那个通知叫做通知书, 所以在这个通知书里有两个重要信息: 通知书名称(通知类型) 和 通知书里的内容(通知书所携带的数据).
		 * 如何分别取得通知(note)的类型和它所携带的数据呢? 可以这样:
		 *     通知类型: note.getName()
		 *     通知携带的数据: note.getBody()
		 * 
		 * 以下函数就是根据接收到的通知类型而采取不同措施. 比如说, 接收到 ListTopicProxy 发布的 GET_ALL_TOPIC_COMPLETE 通知, 于是执行 switch 语句的第一个分支.
		 * switch 语句的第一个分支的功能是: 更新对应的 UI(这里是 listPanel, 一个component) 里的数据.
		 * 在 listPanel 里先定义好一个 topicData 变量, 给中介器操作.
		 * 相当于在 UI 里提供一个接口给中介器操作, 这样就把 表现层(UI) 跟 逻辑层(Mediator) 分开了, 伟人说这是 松偶合 !
		 * 
		 * 如何取得对应的 UI(component) 呢? 就在上面的那个 getter 函数取得: public function get listPanel():ListPanel{}
		 * 
		 * 到此为止, 一个完整的 pureMVC 工作原理在 "分析途径" 上算是表现出来了.
		 * 来到这里, 如果你通过本例子弄懂了 pureMVC 工作原理, 那恭喜您! 也恭喜我! 您是聪明的, 我也是聪明的:)
		 * 
		 * 欢迎一起交流技术:
		 *         My Blog : www.riahome.cn
		 *         My Email: y_boy@126.com & riahome.cn@gmail.com
		 **/
		override public function handleNotification(note:INotification):void
		{
			switch( note.getName() )
			{
				case ApplicationFacade.GET_ALL_TOPIC_COMPLETE:
					listPanel.topicData = note.getBody() as ArrayCollection;
					break;
				
				case ApplicationFacade.INSERT_TOPIC_COMPLETE:
					( facade.retrieveProxy( ListTopicProxy.NAME ) as ListTopicProxy ).getAllTopic();
					break;
			}
		}
		
	}
}