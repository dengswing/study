package  
{
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	/**
	 * Demo: Different ranges
	 * @author Shiu
	 */
	
	 [SWF(width = 400, height = 400)]
	public class Region2 extends Sprite
	{
		private var mi3:ContextMenuItem;
		private var mi2:ContextMenuItem;
		private var mi1:ContextMenuItem;
		private var t1:TextField;
		private var example:int = 0;
		
		private var guard:Ball;
		private var enemy:Ball;
		private var r1:Vector2D = new Vector2D(100, 0);
		private var r2:Vector2D = new Vector2D(200, 0);
		private var r3:Vector2D = new Vector2D(300, 0);
		private var sector:int = 30
		
		public function Region2() 
		{
			mi1 = new ContextMenuItem("Basic FOV"); mi1.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, swap);
			mi2 = new ContextMenuItem("Far/Near Attenuation"); mi2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, swap);
			mi3 = new ContextMenuItem("Observe/Arrow/Sword"); mi3.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, swap);
			var cm:ContextMenu = new ContextMenu(); cm.hideBuiltInItems(); 
			cm.customItems.push(mi1); cm.customItems.push(mi2); cm.customItems.push(mi3); 
			this.contextMenu = cm;
			
			t1 = new TextField; addChild(t1); t1.x = stage.stageWidth / 2; t1.y = stage.stageHeight * 0.8;
			t1.autoSize = TextFieldAutoSize.CENTER;
			
			guard = new Ball; addChild(guard);
			guard.x = stage.stageWidth/5; guard.y = stage.stageHeight / 2;
			
			enemy = new Ball; addChild(enemy); enemy.col = 0; enemy.draw();
			enemy.x = stage.stageWidth * 0.7; enemy.y = stage.stageHeight * 0.2;
			enemy.addEventListener(MouseEvent.MOUSE_DOWN, start);
			enemy.addEventListener(MouseEvent.MOUSE_UP, end);
			drawRegion();
		}
		
		private function start(e:MouseEvent):void 
		{
			e.target.startDrag();
			e.target.addEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		
		private function end(e:MouseEvent):void 
		{
			e.target.stopDrag();
			e.target.removeEventListener(MouseEvent.MOUSE_MOVE, move);
		}
		
		private function move(e:MouseEvent):void 
		{
			var g_e:Vector2D = new Vector2D(enemy.x - guard.x, enemy.y - guard.y);
			var angle:Number = r3.angleBetween(g_e);
			var withinSector:Boolean = Math2.degreeOf(Math.abs(angle)) < sector;
			var withinR3:Boolean = g_e.getMagnitude() < r3.getMagnitude();
			var withinR2:Boolean = g_e.getMagnitude() < r2.getMagnitude();
			var withinR1:Boolean = g_e.getMagnitude() < r1.getMagnitude();
			
			if (example == 0) {
				if (withinSector && withinR3) {
					t1.text = "Within FOV"
				}
				else t1.text = "Beyond FOV"
			}
			else if (example == 1) {
				if (withinSector && withinR3 && !withinR1) {
					t1.text = "In between \nfar and near attenuation"
				}
				else t1.text = "Beyond FOV"
			}
			else if (example == 2) {
				if (withinSector) {
					if (withinR1) t1.text ="Sword attack"
					else if (withinR2) t1.text = "Arrow shoot"
					else if (withinR3) t1.text = "Keep observe"
				}
				else t1.text = "Beyond FOV"
			}
		}
		
		private function swap(e:ContextMenuEvent):void 
		{
			//swap example
			if (e.target.caption == "Basic FOV")		example = 0;
			else if (e.target.caption == "Far/Near Attenuation")		example = 1;
			else if (e.target.caption == "Observe/Arrow/Sword")					example = 2;
			
			drawRegion();
		}
		
		private function drawRegion():void 
		{
			//redraw range indicator			
			var p0:Vector2D = new Vector2D(guard.x, guard.y);
			var p1:Vector2D = r1.clone(); p1.setAngle(Math2.radianOf(sector)); p1 = p1.add(p0);
			var p2:Vector2D = r2.clone(); p2.setAngle(Math2.radianOf(sector)); p2 = p2.add(p0);
			var p3:Vector2D = r3.clone(); p3.setAngle(Math2.radianOf(sector)); p3 = p3.add(p0);
			
			var p4:Vector2D = r1.clone(); p4.setMagnitude(r1.getMagnitude() / Math.cos(Math2.radianOf(sector))); p4 = p4.add(p0);
			var p5:Vector2D = r2.clone(); p5.setMagnitude(r2.getMagnitude() / Math.cos(Math2.radianOf(sector))); p5 = p5.add(p0);
			var p6:Vector2D = r3.clone(); p6.setMagnitude(r3.getMagnitude() / Math.cos(Math2.radianOf(sector))); p6 = p6.add(p0);
			
			var p7:Vector2D = r1.clone(); p7.setAngle(Math2.radianOf(-sector)); p7 = p7.add(p0);
			var p8:Vector2D = r2.clone(); p8.setAngle(Math2.radianOf(-sector)); p8 = p8.add(p0);
			var p9:Vector2D = r3.clone(); p9.setAngle(Math2.radianOf(-sector)); p9 = p9.add(p0);
			
			graphics.clear();
			if (example == 0)	{
				graphics.beginFill(0xFF3300, 0.4);
				graphics.moveTo(guard.x, guard.y);
				graphics.lineTo(p3.x, p3.y); graphics.curveTo(p6.x, p6.y, p9.x, p9.y);
				graphics.lineTo(guard.x, guard.y);
				graphics.endFill();
			}
			if (example == 1)	{
				graphics.beginFill(0xFF3300, 0.4);
				graphics.moveTo(p3.x, p3.y); graphics.curveTo(p6.x, p6.y, p9.x, p9.y); 
				graphics.lineTo(p7.x, p7.y); graphics.curveTo(p4.x, p4.y, p1.x, p1.y);
				graphics.lineTo(p3.x, p3.y);
				graphics.endFill();
			}
			if (example == 2)	{
				graphics.beginFill(0xFF3300, 0.4);
				graphics.moveTo(guard.x, guard.y);
				graphics.lineTo(p1.x, p1.y); graphics.curveTo(p4.x, p4.y, p7.x, p7.y);
				graphics.lineTo(guard.x, guard.y);
				graphics.endFill();
				graphics.beginFill(0xFF9900, 0.4); 
				graphics.moveTo(p2.x, p2.y); graphics.curveTo(p5.x, p5.y, p8.x, p8.y); 
				graphics.lineTo(p7.x, p7.y); graphics.curveTo(p4.x, p4.y, p1.x, p1.y);
				graphics.lineTo(p2.x, p2.y);
				graphics.endFill();
				graphics.beginFill(0xFFFFCC, 0.4); 
				graphics.moveTo(p3.x, p3.y); graphics.curveTo(p6.x, p6.y, p9.x, p9.y); 
				graphics.lineTo(p8.x, p8.y); graphics.curveTo(p5.x, p5.y, p2.x, p2.y);
				graphics.lineTo(p3.x, p3.y);
				graphics.endFill();
			}
			
		}
	}

}