package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
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
			
			initMain();
		}
		
		private function initMain():void {
			
			
			var mySong:Song = new Song("test1");
			mySong.addItem(new NewClass("node 1"));
			mySong.addItem(new NewClass("node 2"));
			
			var mySong_1:Song = new Song("test2");
			mySong_1.addItem(new NewClass("node 2——1"));
			mySong_1.addItem(new NewClass("node 2-2"));
			mySong_1.addItem(new NewClass("node 2-3"));
			mySong_1.addItem(new NewClass("node 2-4"));
			
			mySong.addItem(mySong_1)
			
			var mySong_2:Song = new Song("dd");
			mySong.addItem(mySong_2);
			mySong_2.addItem(new NewClass("node 3-2"));
			
			mySong.traceYY();
		}
		
		
	}
	
}