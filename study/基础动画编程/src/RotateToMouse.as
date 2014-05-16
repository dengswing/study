package { 
	import flash.display.Sprite; 
	import flash.events.Event; 
	import flash.events.MouseEvent;
	
	public class RotateToMouse extends Sprite { 
		private var arrow:Arrow;
		
		private var oldX:Number;
		private var oldY:Number;
		
		public function RotateToMouse() { 
			init();
		} 
		private function init():void { 
			arrow = new Arrow ; 
			addChild(arrow); 
			arrow.x = stage.stageWidth / 2; 
			arrow.y = stage.stageHeight / 2;
			
			oldX = arrow.x;
			oldY = arrow.y;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			
		} 
		public function onEnterFrame(event:Event):void {			
			arrow.x = mouseX;
			arrow.y = mouseY;			
		} 
		
		private function mouseMoveHandler(mouseEvt:MouseEvent):void {			
			var dx:Number = mouseX - oldX; 
			var dy:Number = mouseY - oldY; 
			var radians:Number = Math.atan2(dy, dx);
			arrow.rotation = radians * 180 / Math.PI; 
		
			oldX = arrow.x;
			oldY = arrow.y;			
		}
		
	} 
}