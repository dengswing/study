package {
	import flash.display.Sprite; 
	import flash.events.MouseEvent; 
	public class DrawingApp extends Sprite { 
		
		private var oldX:int;
		private var oldY:int;
		
		public function DrawingApp() { 
			init(); 
		} 
		
		private function init():void { 
			graphics.lineStyle(1); 
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown); 
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	
		private function onMouseDown(event:MouseEvent):void {
			//graphics.moveTo(mouseX, mouseY); 
			oldX = mouseX;
			oldY = mouseY;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove); 
		}
		
		private function onMouseUp(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		} 
		
		private function onMouseMove(event:MouseEvent):void { 
			//graphics.clear();				
			graphics.moveTo(oldX, oldY); 			
			graphics.lineStyle(0);
			graphics.lineTo(mouseX, mouseY); 
			graphics.endFill();
		} 
	} 
}