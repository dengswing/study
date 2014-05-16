package{
	import flash.display.*;
	import flash.events.*;
	
	public class Square extends Sprite{
		public var squareShape:Shape = new Shape();
		public function Square(){
			addChild(squareShape);
			squareShape.graphics.beginFill(0x000000,1);
			squareShape.graphics.drawRect(-20,-20,40,40);
			squareShape.graphics.endFill();
			this.scaleX = 0.1;
			this.scaleY = 0.1;
		}
	}
}