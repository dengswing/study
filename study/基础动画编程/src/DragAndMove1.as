﻿package { 
	import flash.display.Sprite; 
	import flash.display.StageAlign;
	import flash.display.StageScaleMode; 
	import flash.events.Event; 
	import flash.events.MouseEvent;
	
	public class DragAndMove1 extends Sprite { 
		private var ball:Ball;
		private var vx:Number;
		private var vy:Number; 
		private var bounce:Number = -0.7; 
		private var gravity:Number = .5;
		private var oldX:Number
		private var oldY:Number;
		
		public function DragAndMove1() { 
			init(); 
		} 
		
		private function init():void { 
			stage.scaleMode = StageScaleMode.NO_SCALE; 
			stage.align = StageAlign.TOP_LEFT;
			ball = new Ball ;
			ball.x = stage.stageWidth / 2; 
			ball.y = stage.stageHeight / 2;
			vx = Math.random() * 10 - 5; 
			vy = -10; 
			addChild(ball); 
			ball.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		} 
		
		private function onEnterFrame(event:Event):void { 
			vy += gravity; 
			ball.x += vx; 
			ball.y += vy; 
			var left:Number = 0;
			var right:Number = stage.stageWidth; 
			var top:Number = 0; 
			var bottom:Number = stage.stageHeight; 
			
			if (ball.x + ball.radius > right) { 
				ball.x = right - ball.radius; 
				vx *= bounce; 
			} else if (ball.x - ball.radius < left) {
				ball.x = left + ball.radius;
				vx *= bounce; 
			} if (ball.y + ball.radius > bottom) { 
				ball.y = bottom - ball.radius; 
				vy *= bounce; 
			} else if (ball.y - ball.radius < top) { 
				ball.y = top + ball.radius;
				vy *= bounce; 
			}
		}
		
		private function onMouseDown(event:MouseEvent):void { 
			oldX = ball.x;
			oldY = ball.y; 
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.startDrag(); 
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.ENTER_FRAME, trackVelocity);
		}
		
		private function trackVelocity(event:Event):void {
			vx = ball.x - oldX;
			vy = ball.y - oldY;
			oldX = ball.x; 
			oldY = ball.y;
		}
		
		
		private function onMouseUp(event:MouseEvent):void { 
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			ball.stopDrag(); 
			removeEventListener(Event.ENTER_FRAME, trackVelocity);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	} 
}