package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	/**
	 * ...
	 * @author dengswing
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			lockAccount();
		}
		
		/**
		 * 账号锁定检测
		 */
		private function lockAccount():void {
			//DebugTrace.traceFunc("SimCity.as", "lockAccount", [GlobalVariable.localName + GlobalVariable.MIXI_ID]);
			var lockAccount:LockAccount = new LockAccount("topcity_999966");
			lockAccount.content(function():void {
									trace("account Login");	
								});
		}
		
		
	}
	
}