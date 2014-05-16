package { 
	import flash.display.Sprite;
	import flash.events.Event;
	public class Bobbing extends Sprite {
		private var ball:Ball; private var angle:Number = 0;
		public function Bobbing() {
			init(); 
		}
		private function init():void {			
			ball = new Ball(); 
			addChild(ball);
			ball.x = stage.stageWidth / 2; 
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		
	    public function onEnterFrame(event:Event):void {			
			ball.y = stage.stageHeight / 2 + Math.sin(angle) * 50;
			angle += .1; 
		} 
	} 
}