package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	[ SWF (backgroundColor="#000000")]
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
		
		private var boxContainer:Array;
		
		private var gravity:int = 3;
		
		private var boxContainer_mc:Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			
			initMain();
		}
		
		
		private function initMain():void {
			var tmpShape:Shape = new Shape();
			
			tmpShape.graphics.lineStyle(4, 0xFFFFFF);
			tmpShape.graphics.moveTo(0, 505);
			tmpShape.graphics.lineTo(800, 505);
			tmpShape.graphics.endFill();
			
			addChild(tmpShape);
			
			boxContainer_mc = new Sprite();
			addChild(boxContainer_mc);
			
			this.stage.addEventListener(MouseEvent.CLICK, mouseHandler);
			this.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function mouseHandler(mouseEvt:MouseEvent):void {
			var myDrawRect:DrawRect = new DrawRect();
			myDrawRect.x = mouseEvt.currentTarget.mouseX;
			myDrawRect.y = mouseEvt.currentTarget.mouseY;			
			boxContainer_mc.addChild(myDrawRect)
			
			if (boxContainer == null) boxContainer = new Array();
			
			boxContainer.push(myDrawRect);			
		}
		
		private function enterFrameHandler(evt:Event):void {
			if (boxContainer == null) boxContainer = new Array();
			
			var count:int = boxContainer.length;
			
			var myDrawRect:DrawRect;
			
			for (var i:int = 0; i < count; i++) {
				
				myDrawRect = boxContainer[i] as DrawRect;
				
				if (myDrawRect == null) continue;					
				
				if (myDrawRect.y < 500) {					
					myDrawRect.speed += gravity;
					
					if (myDrawRect.y + myDrawRect.speed > 500-8) {						
						myDrawRect.y = 500-8;
						myDrawRect.speed = -myDrawRect.speed * 0.9;
						continue;
					}					
				}
				
				myDrawRect.y += myDrawRect.speed;				
			}
			
		}
		
	}
	
}

class DrawRect extends flash.display.Sprite {
	public var speed:int = 0;
	
	public function DrawRect():void {
		this.graphics.beginFill(0x993366, 1);
		this.graphics.drawCircle(0, 0, 10);
		this.graphics.endFill();		
	}
}