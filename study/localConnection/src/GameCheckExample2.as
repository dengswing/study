package
{
	import flash.display.Sprite;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.setTimeout;
	
	[SWF(width="310",height="110",backgroundColor="#FFFFFF")]
	public class GameCheckExample2 extends Sprite
	{
		private var lc:LocalConnection;
		private var text:TextField;
		public function GameCheckExample2()
		{
			lc = new LocalConnection();
			lc.client = this;
			lc.addEventListener(StatusEvent.STATUS,_statusCheck);
			
			text = new TextField();
			text.backgroundColor = 0xCCCCCC;
			text.background = true;
			text.defaultTextFormat = new TextFormat("宋体",12);
			text.x = 5;
			text.y = 5;
			text.selectable = false;
			text.width = 300;
			text.height = 100;
			addChild(text);
			
			_connect1();
		}
		private function _statusCheck(e:StatusEvent):void
		{
			switch(e.level)
			{
				case "status":
					setTimeout(_connect2,250);
					break;
				default:
					text.text = "踢失败";
					break;
			}
		}
		
		public function kick():void
		{
			try
			{
				lc.close();
			}catch(err:Error){};
			text.text = "你被踢了";
		}
		
		private function _connect1():void
		{
			try
			{
				lc.connect("GameCheckExample2");
				text.text = "连接成功";
			}catch(err:Error)
			{
				text.text = "已有客户端,尝试踢下线";
				lc.send("GameCheckExample2","kick");
			}
		}
		
		private function _connect2():void
		{
			try
			{
				lc.connect("GameCheckExample2");
				text.text = "踢成功,连接成功";
			}catch(err:Error)
			{
				text.text = "踢失败";
			}
		}
	}
}
