﻿package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	public class BitmapCompare extends Sprite
	{
		public function BitmapCompare()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// draw a bunch of random lines
			graphics.lineStyle(0);
			
			for(var i:int = 0; i < 100; i++)
			{
				graphics.lineTo(Math.random() * 300, Math.random() * 400);
			}
			
			// create an opaque bitmap (ARGB 头两位代码透明度)
			var bmpd1:BitmapData = new BitmapData(300, 200, true, 0x70ffffff);
			bmpd1.fillRect(new Rectangle(100, 50, 100, 100), 0xFFffff00);
			var bmp1:Bitmap = new Bitmap(bmpd1);
			
			addChild(bmp1);
			
			// create a transparent bitmap
			var bmpd2:BitmapData = new BitmapData(300, 200, true, 0x00ffffff);
			bmpd2.fillRect(new Rectangle(100, 50, 100, 100), 0x80ff0000);
			var bmp2:Bitmap = new Bitmap(bmpd2);
			bmp2.y = 200;
			addChild(bmp2);
		}
	}
}