package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;	
	
	public class Example extends Sprite 
	{
		
		//总个数
		private var count:int = 10;
		
		//每行5个
		private var speed:int = 5;
		
		//当前拖拽容器
		private var currentDraw_mc:MovieClip;
		
		public function Example() { 
			init();
		}
		
		private function init():void {			
			createContent();
		}
		
		/**
		 * 创建内容
		 */
		private function createContent():void {
			var i:int;
			
			var mySprite:MovieClip;
			
			for (i = 0; i < count; i++) {
				mySprite = new MovieClip();
				mySprite.addChild(DrawRect.drawRect(20, 20, Math.random() * 0xFFFFFF, 1));
				
				mySprite.initX = (i % speed) * 30;
				mySprite.initY =  int(i / speed) * 30;
				mySprite.x = mySprite.initX;				
				mySprite.y = mySprite.initY;
				
				addChild(mySprite);	
				
				//侦听事件
				mySprite.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				mySprite.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);				
			}
			
		}
		
		private function mouseDownHandler(mouseEvt:MouseEvent):void {
			var mySprite:MovieClip = mouseEvt.currentTarget as MovieClip;			
			mySprite.startDrag();	
			this.setChildIndex(mySprite, this.numChildren - 1);
			
			currentDraw_mc = mySprite;	
		}		
		
		private function mouseUpHandler(mouseEvt:MouseEvent):void {
			var mySprite:MovieClip = currentDraw_mc  as MovieClip;			
			mySprite.stopDrag();
		
			hitTestObjectFunc(mySprite);
		}
		
		/**
		 * 检测是否碰撞
		 * @param	current_mc	当前拽容器
		 */
		private function hitTestObjectFunc(current_mc:MovieClip):void {
			var myPoint:Point;			
			var i:int;
			var mySprite:MovieClip;
			var isFind:Boolean = false;			
			
			for (i = 0; i < count; i++) {				
				mySprite = this.getChildAt(i) as MovieClip;
				
				if (mySprite != current_mc && mySprite.hitTestObject(current_mc)) {		
					isFind = true;
					
					myPoint = new Point(mySprite.initX, mySprite.initY);
				
					mySprite.initX =  current_mc.initX;
					mySprite.initY =  current_mc.initY;
					mySprite.x = mySprite.initX;				
					mySprite.y = mySprite.initY;					
					
					current_mc.initX = myPoint.x;
					current_mc.initY = myPoint.y;	
					current_mc.x = current_mc.initX;
					current_mc.y = current_mc.initY;						
				}	
			}				
			
			//没找到还原位
			if (!isFind)
				current_mc.x = current_mc.initX;
				current_mc.y = current_mc.initY;		
			
		}		
		
	}
	
}

import flash.display.Shape;

class DrawRect {	
	public static function drawRect(width:int, height:int, color:uint, alpha:Number):Shape {
		var myShape:Shape = new Shape();
		myShape.graphics.beginFill(color, alpha);
		myShape.graphics.drawRect(0, 0, width, height);
		myShape.graphics.endFill();
		
		return myShape;	
	}	
}