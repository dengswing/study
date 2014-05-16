package cn.lite3.crossSecurityBoxDemo 
{
	import cn.lite3.ui.MyContextMenu;
	import com.adobe.images.JPGEncoder;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	/**
	 * 绕过安全沙箱demo
	 * @author lite3
	 */
	public class CrossSecurityBoxDemo extends Sprite
	{
		
		private var loaded:Boolean = false;
		private var loader:Loader;
		
		private var file:FileReference;
		
		public function CrossSecurityBoxDemo() 
		{
			super();
			this.contextMenu = MyContextMenu.getMyContextNenu();
			
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			addChildAt(loader, 0);
			
			getChildByName("loadBtn").addEventListener(MouseEvent.CLICK, loadImage);
			getChildByName("saveBtn").addEventListener(MouseEvent.CLICK, saveImage);
			
			file = new FileReference();
			
			TextField(getChildByName("txt")).text = "http://hassandbox.lite3.cn/images/lyc.jpg";
			loadImage(null);
		}
		
		private function loadImage(e:MouseEvent):void 
		{
			loaded = false;
			var url:String = TextField(getChildByName("txt")).text;
			loader.load(new URLRequest(url));
		}
		
		private function saveImage(e:MouseEvent):void 
		{
			if (!loaded) return;
			var bitmapData:BitmapData = new BitmapData(530, 360, false);
			bitmapData.draw(loader);
			var jpg:JPGEncoder = new JPGEncoder();
			file.save(jpg.encode(bitmapData), "img.jpg");
		}
		
		private function completeHandler(e:Event):void 
		{
			try {
				loader.content;
				loaded = true;
			}catch (err:SecurityError)
			{
				loader.loadBytes(loader.contentLoaderInfo.bytes);
			}
		}
	}
}