package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Howard.Ren
	 */
	public class ShowObjectSC extends Bitmap implements Render
	{
		private var rect:Rectangle;
		public function ShowObjectSC(bitmap:BitmapData) 
		{
			super(bitmap);
			rect = new Rectangle(0, 0, 40, 40);
			scrollRect = rect;
		}
		
		public function render():void
		{
			rect.x= int(760*Math.random());
			rect.y = int(560 * Math.random());
			scrollRect = rect;
		}
		
		
		
	}

}