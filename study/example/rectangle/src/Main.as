package 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	[SWF (backgroundColor = "#000000")]
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Main extends Sprite 
	{
	
		private var targetPoint:Point;
		private var shape:Shape;
		
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
			shape = new Shape();
			addChild(shape);
			
			this.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			this.stage.addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
		}
		
		private function mouseHandler(mouseEvt:MouseEvent):void {			
			if (mouseEvt.type == MouseEvent.MOUSE_DOWN) {	
				targetPoint = new Point(mouseEvt.currentTarget.mouseX, mouseEvt.currentTarget.mouseY);				
				this.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);					
			}else {	
				shape.graphics.clear();
				this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
			}	
				
		}
		
		private function mouseMoveHandler(mouseEvt:MouseEvent):void {						
			 var recWidth:Number= mouseEvt.currentTarget.mouseX - targetPoint.x;			 
		     var recHeight:Number = mouseEvt.currentTarget.mouseY - targetPoint.y;	 
			
		     shape.graphics.clear();
		     shape.graphics.beginFill(0x99ccff,0.2);
		     shape.graphics.lineStyle(2, 0x993366,0.8);            
			 shape.graphics.drawRect(targetPoint.x, targetPoint.y, recWidth, recHeight)
		     shape.graphics.endFill(); 			
		}
		
	}
	
}