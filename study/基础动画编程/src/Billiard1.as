package { 
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Billiard1 extends Sprite {
		private var ball0:Ball;
		private var ball1:Ball;
		
		public function Billiard1() {
			init();
		}                                    
		
		private function init():void {
			ball0 = new Ball(40); 
			ball0.mass = 2;
			ball0.x = 50;
			ball0.y = stage.stageHeight / 2;
			ball0.vx = 1; 
			addChild(ball0);
			
			ball1 = new Ball(25); 
			ball1.mass = 1; 
			ball1.x = 300; 
			ball1.y = stage.stageHeight / 2;
			ball1.vx = -1; 
			addChild(ball1);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		
		private function onEnterFrame(event:Event):void {
			ball0.x += ball0.vx;
			ball1.x += ball1.vx;
			
			var dist:Number = ball1.x - ball0.x; 
			if (Math.abs(dist) < ball0.radius + ball1.radius) { 				
				// 在此执行反作用力				
				var vxTotal:Number = ball0.vx - ball1.vx; 
				ball0.vx = ((ball0.mass - ball1.mass) * ball0.vx + 2 * ball1.mass * ball1.vx) / (ball0.mass + ball1.mass);
				ball1.vx = vxTotal + ball0.vx; 
				
				ball0.x += ball0.vx;
				ball1.x += ball1.vx;
			}
		}
	}

}