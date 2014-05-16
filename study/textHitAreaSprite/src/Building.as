package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;

	public class Building extends HitAreaSprite
	{
		private var _bmp:Bitmap = null;
		
		public function Building(bmpd:BitmapData)
		{
			_bmp = new Bitmap(bmpd);
			addChild(_bmp);
		}

		override protected function getSpriteBounds():Rectangle
		{
			return _bmp.bitmapData == null ? null : _bmp.bitmapData.rect;
		}
		
		override protected function inHitArea(mouseX:Number, mouseY:Number):Boolean
		{
			return _bmp.bitmapData == null ? false : _bmp.bitmapData.getPixel32(mouseX, mouseY) >>> 24 != 0x00;
		}
	}

}