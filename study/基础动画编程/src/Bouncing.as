package { 
	import flash.display.Sprite; 
	import flash.display.StageAlign;
	import flash.display.StageScaleMode; 
	import flash.events.Event; 
	
	public class Bouncing extends Sprite { 
		private var ball:Ball;
		private var vx:Number; 
		private var vy:Number;
		private var bounce:Number = 0.7;//反弹序数
		
		public function Bouncing() { 
			init();
		} 
		
		private function init():void { 
			stage.scaleMode = StageScaleMode.NO_SCALE; 
			stage.align = StageAlign.TOP_LEFT;
			ball = new Ball ; 
			ball.x = stage.stageWidth / 2; 
			ball.y = stage.stageHeight / 2; 
			vx = Math.random() * 20 - 5;
			vy = Math.random() * 20 - 5;
			addChild(ball); 
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		} 
		
		private function onEnterFrame(event:Event):void { 
			ball.x += vx;
			ball.y += vy; 
			var left:Number = 0;
			var right:Number = stage.stageWidth; 
			var top:Number = 0; 
			var bottom:Number = stage.stageHeight; 
			
			if (ball.x + ball.radius > right) { 
				ball.x = right - ball.radius;
				vx *= -1* bounce
				
			} else if (ball.x - ball.radius < left) { 
				ball.x = left + ball.radius;
				vx *= -1* bounce 				
			} 
			
			if (ball.y + ball.radius > bottom) { 
				ball.y = bottom - ball.radius; 
				vy *= -1 * bounce;
				
			} else if (ball.y - ball.radius < top) {
				ball.y = top + ball.radius;
				vy *= -1 * bounce;				
			} 
		}
	} 
}