package m
{
	import context.ApplicationFacade;
	
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;

	public class BallDataProxy extends Proxy implements IProxy
	{
		private var _count:int = 0;
		public static const NAME:String = 'BallDataProxy';
		public function BallDataProxy()
		{
			super(NAME);
		}

		public function get count():int
		{
			return _count;
		}

		public function set count(value:int):void
		{
			_count = value;
			sendNotification(ApplicationFacade.BALL_CLICK);
		}

	}
}