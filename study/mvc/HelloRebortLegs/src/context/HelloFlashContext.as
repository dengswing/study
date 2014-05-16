package context
{
	import c.CreatNewBallCommand;
	import c.StartupCommand;
	import c.event.HelloWorldMessageEvent;
	
	import flash.display.DisplayObjectContainer;
	
	import m.MyModel;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	import v.Ball;
	import v.BallMediator;
	import v.TextShow;
	import v.TextShowMediator;

	public class HelloFlashContext extends Context
	{
		public function HelloFlashContext(contextView:DisplayObjectContainer)
		{
			super(contextView);
		}
		
		override public function startup():void
		{
			commandMap.mapEvent(ContextEvent.STARTUP,StartupCommand,ContextEvent,true);
	//		commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent, true);	
			commandMap.mapEvent(HelloWorldMessageEvent.MESSAGE_DISPATCHED,CreatNewBallCommand,HelloWorldMessageEvent);
			injector.mapSingleton(MyModel);
			
			mediatorMap.mapView(Ball,BallMediator);
			mediatorMap.mapView(TextShow,TextShowMediator);
			
			contextView.addChild(new TextShow());
			dispatchEvent(new ContextEvent(ContextEvent.STARTUP));
	//		super.startup();
		}
	}
}