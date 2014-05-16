package 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.hexagonstar.util.debug.Debug;
	
	/**
	 * ...
	 * @author dengSwing
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
			Debug.delimiter();	//分隔符			
			Debug.time();	//输出时间
			Debug.delimiter();	//分隔符	
			Debug.traceObj(["da", 1, [new Test(), stage]], 128, Debug.LEVEL_DEBUG);	//打印object类型
			Debug.monitor(stage, 50);	
			Debug.createCategory(1, "hello", 0xFF0000, 0x999999);
			Debug.mark(0xFF0000);
			Debug.hexDump(["a", "1"]);	//十六进制格式输出
			Debug.timerToString();
			
		    Debug.trace("hello >>hello", Debug.LEVEL_WARN);
				
			var array:Array = [777, 123, "Gerry", "Gail"];
			Debug.inspect(array);
			var obj:Object = {n1: "Bill", n2: "Jenny"};
			Debug.inspect(obj);
			Debug.inspect(new Bitmap());
			   
			//Debug.trace("[%TME%]");	//显示输出时间
		   
		}
		
		private function testLoader():void {
			
		}
		
	}
	
}