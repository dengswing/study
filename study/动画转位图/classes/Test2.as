package
{
	import com.bit101.display.BigAssCanvas;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class Test2 extends MovieClip
	{
		private var rect:Sprite;
		var preview:Bitmap;
		private var ba:BigAssCanvas;
		private var scale;
		
		
		public function Test2() 
		{
			scale= .15;
			
			ba = new BigAssCanvas(3500, 3500, true);
			
			var drawing:MovieClip = new Drawing(); 
			
			ba.draw(drawing);
			
			ba.scaleX = scale;
			ba.scaleY = scale;
			addChild(ba);
			
			rect = new Sprite();
			rect.graphics.lineStyle(1, 0xff0000);
			rect.graphics.drawRect(0, 0, 70, 70);
			addChild(rect);
			
			preview = new Bitmap();
			preview.x = 500;
			addChild(preview);
			
			var lines:Sprite = new Sprite();
			lines.graphics.lineStyle(1, 0xff0000);
			lines.graphics.moveTo(2880*scale,0)
			lines.graphics.lineTo(2880*scale,2880*scale)
			lines.graphics.lineTo(0,2880*scale)
			addChild(lines);
			
			addEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		private function enterFrame(e:Event):void 
		{
			rect.x = mouseX;
			rect.y = mouseY;
			preview.bitmapData = ba.copyPixelsOut(new Rectangle(rect.x/scale, rect.y/scale, rect.width/scale, rect.height/scale));
		}	
	}	
}