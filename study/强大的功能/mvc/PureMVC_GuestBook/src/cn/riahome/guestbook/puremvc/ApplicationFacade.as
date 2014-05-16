package cn.riahome.guestbook.puremvc
{
	import cn.riahome.guestbook.puremvc.controller.StartupCommand;
	
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;

	public class ApplicationFacade extends Facade implements IFacade
	{
		/**
		 * 
		 * 目前分析途径: Main.mxml -> ApplicationFacade.as
		 * 完整分析途径: Main.mxml -> ApplicationFacade.as -> StartupCommand.as -> ListTopicProxy.as -> ListPanelMediator.as
		 * 
		 * 来到这里, 有必要说一下 MVC, 即 Model, View, Controller:
		 * 
		 * Model:
		 *     model => 数据! 本人觉得在 pureMVC 里, model 里有两个主角: VO(Value Object) 和 Proxy(代理).
		 *     VO 是数据的结构, 存储数据的容器. 一条留言(TopicVO)就有ID值(id), 留言时间(addTime), 昵称(username), 内容(content)
		 *     Proxy 是负责获得数据的. 获得数据的方式有很多种, 可以获得本地数据(swf本身里的数据), 也可以从互联网上获得数据, 当然从服务器上获得数据也是常发生的事情.
		 *           而从非本地获得数据可以是: http, remote...
		 * 
		 * View:
		 *     view => 显示! 顾名思义, view 就是显示的东西. 一切要显示的东西都在这里了. 通常, 它也会有两个主角: UI 和 Mediator(中介器)
		 *     UI 就是那些要显示的东西, 例如一个显示留言的界面(就是一个component), 一个填写留言的界面(也是一个component)
		 *     Mediator 最最最重要的任务是处理有关 UI 的逻辑. 比如说更新 UI 上显示的数据, 或者是提交数据, 又或者是验证用户输入的数据
		 * 
		 * Controller:
		 *     controller => 逻辑! controller, 里头都是一个命令(Command), 一些算法, 一些逻辑就在这里头完成.
		 *     Model 的 Proxy 获得数据后, 可能需要把这些数据进行一些处理, 那就交由 Controller 里的那些 Command 处理吧.
		 *     Model 的 Proxy 只负责着获得数据, 具体的数据处理交给 Controller 的 Command 吧
		 *     例如: Proxy 获得的数据可能是 变量/值 配对格式的数据, 而我需要的是 xml 格式的, 那就需要实现转化了. 转化过程就交给 command 了.
		 * 
		 * 总的来说:
		 *     View 用于显示东西给用户看的, 显示的数据由 Model 提供. 有时候 Model 获得的数据不一定就合 View 的胃口,
		 *     那么 Model 先把数据交给 Controller 处理好, 处理好后再交给 View 显示出来.
		 * 
		 * 那么, Model 是在什么时候把数据交给 View 层呢? 又是怎样来交给 View 呢? 就是通过发布 "通知" 来实现的, 这个通知携带着数据. 这是 pureMVC 的消息机制.
		 * 
		 * 无论您有没有弄懂以上所说的, 都请您先把它记住!
		 * 
		 * 以下定义了一些通知, 当这个通知发布出去时, 对这个通知感兴趣的 Command 或者 Mediator 会接收这个通知.
		 * 
		 **/
		public static const STARTUP:String = "startup";
		
		public static const GET_ALL_TOPIC_COMPLETE:String = "getAllTopicComplete"; // ListPanel 对这个通知感兴趣
		public static const SELECT_TOPIC:String = "selectTopic"; // DetailPanel 对这个通知感兴趣
		public static const INSERT_TOPIC_COMPLETE:String = "insertTopicComplete"; // ListPanel 对这个通知感兴趣
		
		/**
		 * 以下这个函数是采用单例模式, 也就是整个 swf 就只有它一个
		 **/
		public static function getInstance():ApplicationFacade
		{
			if( instance == null ) instance = new ApplicationFacade();
			return instance as ApplicationFacade;
		}
		
		/**
		 * 下面就是启动整个 pureMVC 的函数
		 * sendNotification() 函数用来发布通知的, 这份通知书里装着数据的.
		 * 第一个参数是通知书的标题(是一个唯一的标识符), 第二个参数是携带的数据(是MVC三者之间传递的数据).
		 **/
		public function startup( app:Object ):void
		{
			sendNotification( STARTUP, app );
		}
		
		/**
		 * 重写这个函数, 您也看到了, 使用 registerCommand() 函数来用注册 command 的.
		 * 何谓 "注册 Command" 呢? 就是使 "通知" 跟 command 对应起来.
		 * 下面就是把通知名 STARTUP 跟 StartupCommand 对应起来.
		 * 在任何时候任何地方, STARTUP 通知被发布了, StarupCommand 就会被执行.
		 * 每一个 command 里头都有一个 execute() 函数的, execute() 函数的参数由谁来充当呢?
		 * 就是通知所携带的数据, 也就是上面 sendNotification() 函数的第二个参数.
		 * 
		 * 好了, 从 Main.mxml 文件里的 creationComplete="facade.startup( this )" 语句中走到这里了,
		 * 现在得从 registerCommand( STARTUP,  StartupCommand ) 语句中走到 StartupCommand 里了.
		 * 请您按着 Ctrl 键点击一下 StartupCommand.
		 **/
		override protected function initializeController():void
		{
			super.initializeController(); // 先调用父类的 initializeController() 方法, 看 pureMVC 源代码可知, 调用这个方法会创建一个单例的 controller, 具体自己看了.
			registerCommand( STARTUP,  StartupCommand );
		}
		
	}
}