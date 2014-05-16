package camera 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.media.Camera;
	import flash.media.Video;
	
	public class ColorTracking extends Sprite
	{
		private var _cam:Camera;
		private var _vid:Video;
		private var _bmpd:BitmapData;
		private var _cbRect:Sprite;
		private var _color:uint = 0xffffff;
		
		public function ColorTracking()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_cam = Camera.getCamera();
			_cam.setMode(320, 240, 15);
			_vid = new Video(320, 240);
			_vid.attachNetStream(_cam);
			_bmpd = new BitmapData(320, 240, false);
			addChild(new Bitmap(_bmpd));
			_cbRect = new Sprite();
			addChild(_cbRect);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void
		{
			_color = _bmpd.getPixel(mouseX, mouseY);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_bmpd.draw(_vid, new Matrix(-1, 0, 0, 1, _bmpd.width, 0));
			var rect:Rectangle = _bmpd.getColorBoundsRect(0xffffff,
			_color, true);
			_cbRect.graphics.clear();
			_cbRect.graphics.lineStyle(1, 0xff0000);
			_cbRect.graphics.drawRect(rect.x, rect.y, rect.width,
			rect.height);
		}
	}
}