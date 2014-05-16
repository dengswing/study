package { 
	import flash.display.Sprite;
	import flash.events.MouseEvent; 
	import flash.text.TextField; 
	import flash.text.TextFieldAutoSize;
	
	public class MouseDistance extends Sprite {
		private var sprite1:Sprite; 
		private var textField:TextField;
		
		public function MouseDistance() {
			init(); 
		}
		
		private function init():void {
			sprite1 = new Sprite();
			addChild(sprite1);
			sprite1.graphics.beginFill(0x000000); 
			sprite1.graphics.drawRect( -2, -2, 4, 4);
			sprite1.graphics.endFill();
			sprite1.x = stage.stageWidth / 2;
			sprite1.y = stage.stageHeight / 2;
			
			textField = new TextField(); 
			textField.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(textField);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			
			
			
		} 
		
		public function onMouseMove(event:MouseEvent):void { 
			//var a:Number = Math.random() * 5 + 1;
			trace(Math.random() * 5 +1 << 0);
			
			graphics.clear();
			graphics.lineStyle(1, 0, 1);
			
			graphics.moveTo(sprite1.x, sprite1.y);
			graphics.lineTo(mouseX, mouseY);
			
			var dx:Number = sprite1.x - mouseX;
			var dy:Number = sprite1.y - mouseY;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			textField.text = dist.toString();
		}
	} 
}