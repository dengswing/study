package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Howard.Ren
	 */
	public class ShowObjectXY extends Sprite implements Render
	{
		
		private var masker:Sprite;
		private var b:Bitmap;
		public function ShowObjectXY(bitmap:BitmapData) 
		{
			masker = new Sprite();
			masker.graphics.beginFill(0);
			masker.graphics.drawRect(0, 0, 40, 40);
			
			addChild(masker);
			
			b = new Bitmap(bitmap);
			addChild(b);
			
			b.mask = masker;
		}
		
		public function render():void
		{
			b.x = -int(760*Math.random());
			b.y = -int(560*Math.random());
		}
		
	}

}