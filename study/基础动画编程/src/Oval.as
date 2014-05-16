package { 
	import flash.display.Sprite; 
	import flash.events.Event;
	
	public class Oval extends Sprite { 
		private var ball:Ball; 
		private var angle:Number = 0; 
		private var centerX:Number = 200;
		private var centerY:Number = 200; 
		private var radiusX:Number = 200; 
		private var radiusY:Number = 100; 
		private var speed:Number = .1;
		
		public function Oval() { 
			init(); 
		} 
		
		private function init():void { 
			ball = new Ball(5,0x336699); 
			addChild(ball); 
			ball.x = 0; 
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event):void { 
			ball.x = centerX + Math.cos(angle) * radiusX;
			ball.y = centerY + Math.sin(angle) * radiusY; 
			angle += speed; 
		}
	}
}