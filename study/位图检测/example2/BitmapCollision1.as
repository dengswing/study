﻿package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	public class BitmapCollision1 extends Sprite
	{
		private var bmpd1:BitmapData;
		private var bmp1:Bitmap;
		private var bmpd2:BitmapData;
		private var bmp2:Bitmap;
		
		public function BitmapCollision1()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// make a star
			var star:Star = new Star(50);
			// make a fixed bitmap, draw the star into it
			bmpd1 = new BitmapData(100, 100, true, 0);
			bmpd1.draw(star, new Matrix(1, 0, 0, 1, 50, 50));
			bmp1 = new Bitmap(bmpd1);
			bmp1.x = 200;
			bmp1.y = 200;
			addChild(bmp1);
			
			// make a moveable bitmap, draw the star into it, too
			bmpd2 = new BitmapData(100, 100, true, 0);
			bmpd2.draw(star, new Matrix(1, 0, 0, 1, 50, 50));
			bmp2 = new Bitmap(bmpd2);
			addChild(bmp2);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoving);
		}
		
		private function onMouseMoving(event:MouseEvent):void
		{
			// move bmp2 to the mouse position (centered).
			bmp2.x = mouseX - 50;
			bmp2.y = mouseY - 50;
			// the hit test itself.
			if (bmpd2.hitTest(new Point(bmp2.x, bmp2.y), 255, bmpd1, new Point(bmp1.x, bmp1.y), 255))			
			{
				bmp1.filters = [new GlowFilter()];
				bmp2.filters = [new GlowFilter()];
			}
			else
			{
				bmp1.filters = [];
				bmp2.filters = [];
			}
		}
	}
}