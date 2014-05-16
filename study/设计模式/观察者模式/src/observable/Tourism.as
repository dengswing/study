package observable 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author dengsw
	 */
	public class Tourism extends Beauty
	{
		private var vLocation:Vector.<String>;		
		private var timer:Timer;
		
		public function Tourism() 
		{
			timer = new Timer(3000);
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			
			vLocation = new Vector.<String>();
			vLocation.push("北京", "上海", "天津", "深圳");
		}
		
		private function timerHandler(e:TimerEvent):void 
		{
			super.notifyObservers(vLocation[int(Math.random() * vLocation.length)]);
		}
		
		/**
		 * 开始旅游
		 */
		public function startTourism():void 
		{
			timer.start();
		}
		
	}

}