package {
	import com.cn.TT;
    import flash.utils.getDefinitionByName;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;

	//預載
	TT
	//引掉試試
	//
	public class Demo extends Sprite
	{
		private var ld:Loader;
		private var contentsss:Sprite
		public function Demo()
		{
			//addChild (new TT ()); 這行寫在這里就沒有用�?
			ld= new Loader ();
			ld.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);			
			ld.load(new URLRequest("TestPro.swf"));
		}
		
		private function onComplete ( e:Event ):void {			
			ld = null
			contentsss = e.currentTarget.content;
			//addChild (contentsss);
			//
			//var ttClass:Class = Class(getDefinitionByName("com.cn.TT"));
			//var ttClass:Class = contentsss.loaderInfo.applicationDomain.getDefinition("com.cn.TT") as Class;
			//addChild(new ttClass());
			//加上試試
			addChild ( e.target.loader );
			
			//removeChild(contentsss);
			
			//contentsss = null;
			
			//ld = null;
		}
	}
}

// TestPro中被linkage為TT的元素實際充當為類TT增加顯示元件的作�?
// 而且即使Fla編譯時TT類不存在也可�?
// TT類可以放在別的地方以Source folder的方式導入。只要確保程序運行的時候預載此類即�?
