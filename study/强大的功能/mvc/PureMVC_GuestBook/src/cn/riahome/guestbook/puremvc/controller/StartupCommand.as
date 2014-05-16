package cn.riahome.guestbook.puremvc.controller
{
	import cn.riahome.guestbook.puremvc.model.InsertTopicProxy;
	import cn.riahome.guestbook.puremvc.model.ListTopicProxy;
	import cn.riahome.guestbook.puremvc.view.DetailPanelMediator;
	import cn.riahome.guestbook.puremvc.view.InsertPanelMediator;
	import cn.riahome.guestbook.puremvc.view.ListPanelMediator;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * 
	 * 目前分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as
	 * 完整分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
	 * 
	 * 一旦收到通知 STARTUP 后, 就会执行这个 StartupCommand.
	 * 收到的通知里头携带着数据, 这个数据作为参数传递给下面那个 execute() 函数了.
	 * 
	 * 在这里, 主要的功能是注册 Model 里的 Proxy(代理) 和 Controller 里的 Mediator(中介器)
	 * 看看 execute() 函数里的代码, 无论是注册 Proxy 还是 Mediator, 都是由 facade 对象的 registerProxy() 方法或 registerMediator() 方法完成的
	 * facade 对象是本类内部的一个家伙, 用来管理 Proxy 和 Mediator 的. 在后面的代码里, 想要重新获得 Proxy 或者 Mediator 都可以通过这个 facade 家伙.
	 * 是不是对这个 facade 对象感到很奇怪呢!? 如果想知道更多, 就得看 pureMVC 框架的源代码了. 在这里简要说一下:
	 *     facade 是一个单例对象, 也就是说整个 swf 只有孤独的它一个. 在你写的 Proxy, Mediator 以及 Command 里都会有它的存在. 用它来管理 Proxy 和 Mediator 的.
	 *     就像最下面那行代码 ( facade.retrieveProxy( ListTopicProxy.NAME ) as ListTopicProxy ).getAllTopic();
	 *     可以通过使用 retrieveProxy() 方法来找回相应的 Proxy, 要找回某个 Proxy, 就要传递那个 Proxy 的名字进去.
	 *     类似地, 也有 retrieveMediator() 方法来找回 Mediator.
	 *     在 facade 内部是使用数组来存放这些 Proxy 和 Mediator 的. 为什么能找到指定的 Proxy 或 Mediator 呢?
	 *     那是因为每一个 Proxy 或 Mediator 都有它自己的一个名字, 那个数组存储 Proxy 或 Mediator 时, 是使用它们自身的名字来作为键(Key)进行存储的.
	 *     要找到指定的 Proxy 或 Mediator, 只需知道它的名字就可以了.
	 **/
	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		/**
		 * 这个函数要重写啊.
		 **/
		override public function execute(note:INotification):void
		{
			/**
			 * 下面两个 Proxy 是用来与服务端通讯的. 它们负责着数据的 获取 或 提交.
			 * InsertTopicProxy 是用来向服务端提交数据的, ListTopicProxy 是用来获取数据的.
			 * 
			 * 您可以按着 Ctrl 键点击 ListTopicProxy, 看看它的内部如何
			 **/
			facade.registerProxy( new InsertTopicProxy() );
			facade.registerProxy( new ListTopicProxy() );
			
			
			/**
			 * 记住, Mediator 是负责 UI(就是那些 component)的逻辑部分.
			 * 不管是数据验证, 更新 UI 所显示的数据, 还是其它乱七八糟的东西, 都由每块UI(就是每块 Component)所对应的 Mediator 来处理的.
			 * 例如: InsertPanelMediator 负责把对应的 InsertPanel(这是一个 component) 里的数据进行检验(对用户输入的数据进行检验正确与否),
			 *      检验无误后, 就把数据交给 InsertTopicProxy 写入数据库. 而 UI(一个component) 本身不进行任何的数据处理或逻辑分析等等.
			 **/
			var app:Main = note.getBody() as Main;
			facade.registerMediator( new InsertPanelMediator( app.insertPanel ) );
			
			/**
			 * 完整分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
			 * 下一站分析途径为以下的 ListPanelMediator.
			 **/
			facade.registerMediator( new ListPanelMediator( app.listPanel ) );
			
			facade.registerMediator( new DetailPanelMediator( app.detailPanel ) );
			
			/**
			 * 有些数据是在一开始的时候就需要的, 所以在这里就命令 ListTopicProxy 调用它的方法 getAllTopic() 来取得服务端上的数据.
			 * 通过 facade 对象的 retrieveProxy() 方法来找回指定的 Proxy.
			 * 在这里找回了 ListTopicProxy, 因为我把这个 ListTopicProxy 的名字作为参数传递进 retrieveProxy() 方法了.
			 * 
			 * 以下代码可以拆分为:
			 * var proxy:ListTopicProxy = facade.retrieveProxy( ListTopicProxy.NAME ) as ListTopicProxy;
			 * proxy.getAllTopic();
			 **/
			( facade.retrieveProxy( ListTopicProxy.NAME ) as ListTopicProxy ).getAllTopic();
		}
	}
}