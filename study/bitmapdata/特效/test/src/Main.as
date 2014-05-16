package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
	
			main();
		}
		
		private function main():void {
			var bitmapData:BitmapData = new BitmapData(100, 100, false, 0);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			addChild(bitmap);
			var rect:Rectangle = new Rectangle(10, 10, 40, 50);
			bitmapData.fillRect(rect, 0xCCCCCC);
			
			var rect2:Rectangle = new Rectangle(40, 40, 40, 50);
			bitmapData.fillRect(rect2, 0x879456);
			
			//bitmapData.applyFilter(bitmapData, rect2, new Point(40,40), new BlurFilter());
			bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), new BlurFilter());	//所有的位图			
			//bitmap.filters = [new BlurFilter()];
		}
		
	}
	
}