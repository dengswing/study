package { 
	import flash.display.Sprite; 
	import flash.events.Event; 
	
	public class Spring1 extends Sprite {
		private var ball:Ball; 
		private var spring:Number = 0.1;
		private var targetX:Number = stage.stageWidth / 2;
		private var targetY:Number = stage.stageHeight / 2;
		private var vx:Number = 50;
		private var vy:Number = 0;
		private var friction:Number = 0.95;
		
		public function Spring1() { 
			init(); 
		}
		
		private function init():void {
			ball = new Ball();
			addChild(ball); 
			//ball.y = stage.stageHeight / 2; 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void { 
			var dx:Number = targetX - ball.x;
			var dy:Number = targetY - ball.y;
			var ax:Number = dx * spring; 
			var ay:Number = dy * spring;
			vx += ax;
			vy += ay;
			vx *= friction;
			vy *= friction;
			ball.x += vx; 
			ball.y += vy;
		} 
	}
}