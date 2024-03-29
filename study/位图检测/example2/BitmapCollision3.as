﻿package{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class BitmapCollision3 extends Sprite
	{
		private var bmpd1:BitmapData;
		private var bmpd2:BitmapData;
		private var star1:Star;
		private var star2:Star;
		public function BitmapCollision3()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// make two stars, add to stage
			star1 = new Star(50);			
			addChild(star1);
			
			star2 = new Star(50);
			star2.x = 200;
			star2.y = 200;
			addChild(star2);
			// make two bitmaps, not on stage
			bmpd1 = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0);
			bmpd2 = bmpd1.clone();
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoving);
		}
		
		private function onMouseMoving(event:MouseEvent):void
		{
			// move star1 to the mouse position
			star1.x = mouseX;
			star1.y = mouseY;
			
			// clear the bitmaps
			bmpd1.fillRect(bmpd1.rect, 0);
			bmpd2.fillRect(bmpd2.rect, 0);
			
			// draw one star to each bitmap
			bmpd1.draw(star1, new Matrix(1, 0, 0, 1, star1.x, star1.y));
			bmpd2.draw(star2, new Matrix(1, 0, 0, 1, star2.x, star2.y));
			
			// the hit test itself.
			if(bmpd1.hitTest(new Point(), 255, bmpd2, new Point(), 255))
			{			
				star1.filters = [new GlowFilter()];
				star2.filters = [new GlowFilter()];
			}
			else
			{
				star1.filters = [];
				star2.filters = [];
			}
		}
	}
}