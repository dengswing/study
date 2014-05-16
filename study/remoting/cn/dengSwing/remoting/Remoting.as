package cn.dengSwing.remoting
{
	import flash.events.Event;
	import flash.events.EventDispatcher;	
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	import flash.net.ObjectEncoding;	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Remoting  extends EventDispatcher
	{
		private var gatewayURL:String;
		//服务器连接
		private var webFuncStr:String;
		//服务器远程方法
		private var nc:NetConnection;
		//
		public static const SUCCEED:String = "succeed";
		public static const FAILED:String = "failed";
		//
		private var _resultStr:String;
		//返回值
		public function Remoting(wayUrl:String) {
			gatewayURL = wayUrl;	
			connectFunc();
		}
		
		private function connectFunc():void {
			nc = new NetConnection();
			nc.objectEncoding = ObjectEncoding.AMF3;	
			//设置AMF版本
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			try{
				nc.connect(gatewayURL);		
			}catch (err:Error) {
				trace("nc connect err=" + err);
			}
		}
		//连接服务器
		
		public function getMethodFunc(funcStr:String, ...args):void {
			var responder:Responder = new Responder(onSucceed, onFailed);
			//responder用来侦听成功及失败			
			nc.call(funcStr, responder, args);			
		}
		//调用服务器方法		
		
		private function netStatusHandler(netStatusEvt:NetStatusEvent):void {			
			switch (netStatusEvt.info.code) {
                case "NetConnection.Connect.Success":
                    trace("连接服务器成功!");
                    break;
                case "NetConnection.Connect.Failed":
                    trace("连接服务器失败!");
                    break;
				case "NetConnection.Call.Failed":
                    trace("调用服务器端的方法或命令失败!");
                    break;
            }
		}
		//侦听是否连接成功
		
		private function onSucceed(result:String):void {			
			this.resultStr = result;
			dispatchEvent(new Event(Remoting.SUCCEED));
		}
		//服务器返回结果,成功时调用
		
		private function onFailed(failed:Object):void {
			trace("调用方法失败!");		
			//
			for (var i:Object in failed) {				
				trace(failed[i]);
			}
			dispatchEvent(new Event(Remoting.FAILED));
		}
		//调用服务器方法,失败时调用
		
		public function get resultStr():String {
			return _resultStr;
		}
		
		public function set resultStr(value:String):void {
			_resultStr = value;
		}
		
	}
	
}