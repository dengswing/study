package 
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.setTimeout;
	
	public class LockAccount
	{
		//连接名称
		private var _localName:String;
		private var lc:LocalConnection;
		private var kickCall:Function;
		
		/**
		 * 锁定帐户
		 * @param	localName	连接名称
		 */
		public function LockAccount(localName:String)
		{
			_localName = localName;
			
			lc = new LocalConnection();
			lc.client = this;
			lc.allowDomain("*");
			lc.addEventListener(StatusEvent.STATUS, _statusCheck);
		}
		
		/**
		 * 连接
		 * @param	kick	被踢回调
		 */
		public function content(kick:Function):void {
			kickCall = kick;	
			_connect1();
		}
		
		private function _statusCheck(e:StatusEvent):void
		{
			switch(e.level)
			{
				case "status":
					setTimeout(_connect2, 250);
					break;
				default:
					trace("踢失败")
					//DebugTrace.traceFunc("LockAccount.as", "_connect1", "踢失败");
					break;
			}
		}
		
		public function kick():void
		{
			try
			{
				lc.close();
			}catch (err:Error) { };
			
			//DebugTrace.traceFunc("LockAccount.as", "_connect1", "你被踢了");
			if (kickCall != null && kickCall is Function) kickCall();		
			trace("你被踢了");
		}
		
		private function _connect1():void
		{
			try
			{
				//DebugTrace.traceFunc("LockAccount.as", "_connect1", "连接成功");
				lc.connect(localName);	
				trace("连接成功");
			}catch(err:Error)
			{
				//DebugTrace.traceFunc("LockAccount.as", "_connect1", "已有客户端,尝试踢下线");
				lc.send(localName, "kick");	
				trace("已有客户端,尝试踢下线");
			}
		}
		
		private function _connect2():void
		{
			try
			{
				//DebugTrace.traceFunc("LockAccount.as", "_connect1", "踢成功,连接成功");
				lc.connect(localName);	
				trace("踢成功,连接成功");
			}catch(err:Error)
			{
				//DebugTrace.traceFunc("LockAccount.as", "_connect1", "踢失败");
				trace("踢失败");
			}
		}
		
		/**
		 * 连接名称
		 */
		public function get localName():String { return _localName; }
		
		public function set localName(value:String):void 
		{
			_localName = value;
		}
	}
}
