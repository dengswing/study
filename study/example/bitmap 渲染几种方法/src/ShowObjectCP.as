package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Howard.Ren
	 */
	public class ShowObjectCP extends Bitmap implements Render
	{
		
		private var buffer:BitmapData;
		private var _source:BitmapData;
		
		public function ShowObjectCP(source:BitmapData) 
		{
			buffer = new BitmapData(40, 40);
			_source = source;
			
			super(buffer);
		}
		
		public function render():void
		{
			buffer.copyPixels(_source, new Rectangle(int(760 * Math.random()), int(560 * Math.random()), 40, 40), new Point());
		}
		
	}

}