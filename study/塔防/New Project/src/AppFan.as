package  
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * Demo: Area of FOV
	 * @author Shiu
	 */
	[SWF(width = 400, height = 300)]
	public class AppFan extends Sprite
	{
		private var sp:Vector.<Ball>;						//Array to hold all particles on screen
		private var b1:Sprite, b2:Sprite, b3:Sprite	//Points to define 2 lines
		private var t1:Sprite, t2:Sprite						//Sprites to make up the line vector
		private var w:Number;
		private var vLine2:Vector2D;
		private var vLine3:Vector2D;
		public function AppFan() 
		{
			//Populating the screen with screen particles, sp
			//initiating array to hold all particles
			sp = new Vector.<Ball>;
			//Scroll through height (j) and width (i)
			for (var j:int = 0; j < 30; j++) {
				for (var i:int = 0; i < 40; i++) {
					
					//Ball initiation, adding into DisplayList, adding into array, ball radius reset & redraw
					var b:Ball = new Ball; addChild(b); sp.push(b); b.rad = 2; b.draw();
					b.x = i * 10 + 10;	b.y = j * 10 + 5;
				}
			}
			
			//Adding in points to form lines:	Line2-- b1, b2			Line3-- b1, b3
			//Ball initiation, adding into DisplayList, ball naming, ball positioning
			b1 = new Ball; addChild(b1); b1.name = "b1";  b1.x = stage.stageWidth * 0.3; b1.y = stage.stageHeight * 0.5;
			b2 = new Ball; addChild(b2); b2.name = "b2"; b2.x = stage.stageWidth * 0.7; b2.y = stage.stageHeight * 0.7;
			b3 = new Ball; addChild(b3); b3.name = "b3"; b3.x = stage.stageWidth * 0.5; b3.y = stage.stageHeight * 0.2;
			//Draw lines to join points
			graphics.lineStyle(3); graphics.moveTo(b2.x, b2.y); graphics.lineTo(b1.x, b1.y);graphics.lineTo(b3.x, b3.y);
			
			//Arrowhead initiation, adding into DisplayList, arrowhead naming 
			t1 = new Triangle; addChild(t1); t1.name = "t1"; 
			t2 = new Triangle; addChild(t2); t2.name = "t2"; 
			//Calculate distance to offset arrowhead from end points of lines
			w = t1.width;
			vLine2 = new Vector2D(b2.x - b1.x, b2.y - b1.y);
			vLine3 = new Vector2D(b3.x - b1.x, b3.y - b1.y);
			var tPos2:Vector2D = vLine2; tPos2.setMagnitude(10 + w);
			var tPos3:Vector2D = vLine3; tPos3.setMagnitude(10 + w);
			//Do the offset
			t1.x = b2.x - tPos2.x; t1.y = b2.y - tPos2.y;
			t2.x = b3.x - tPos3.x; t2.y = b3.y - tPos3.y; 
			//Re-orient the arrows
			t1.rotation = Math2.degreeOf(tPos2.getAngle());
			t2.rotation = Math2.degreeOf(tPos3.getAngle());
			
			//Progamming interaction onto all points of lines
			b1.addEventListener(MouseEvent.MOUSE_DOWN, start);
			b1.addEventListener(MouseEvent.MOUSE_UP, end);
			b2.addEventListener(MouseEvent.MOUSE_DOWN, start);
			b2.addEventListener(MouseEvent.MOUSE_UP, end);
			b3.addEventListener(MouseEvent.MOUSE_DOWN, start);
			b3.addEventListener(MouseEvent.MOUSE_UP, end);
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
			//Drawing line onto stage
			graphics.clear(); graphics.lineStyle(3); graphics.moveTo(b2.x, b2.y); graphics.lineTo(b1.x, b1.y);graphics.lineTo(b3.x, b3.y);
			//Calculating offset
			vLine2 = new Vector2D(b2.x - b1.x, b2.y - b1.y);
			vLine3 = new Vector2D(b3.x - b1.x, b3.y - b1.y);
			var tPos2:Vector2D = vLine2; tPos2.setMagnitude(10 + w);
			var tPos3:Vector2D = vLine3; tPos3.setMagnitude(10 + w);
			//Update triangles positions & re-orient them
			t1.x = b2.x - tPos2.x; t1.y = b2.y - tPos2.y; t1.rotation = Math2.degreeOf(tPos2.getAngle());
			t2.x = b3.x - tPos3.x; t2.y = b3.y - tPos3.y; t2.rotation = Math2.degreeOf(tPos3.getAngle());
			
			//Calculate the magnitude and angle
			vLine2 = new Vector2D(b2.x - b1.x, b2.y - b1.y);
			vLine3 = new Vector2D(b3.x - b1.x, b3.y - b1.y);
			var ang:Number = Math.abs(vLine2.angleBetween(vLine3))
			var mag:Number = vLine2.getMagnitude();
			
			for each (var item:Ball in sp) {
				var vParticle1:Vector2D = new Vector2D(item.x - b1.x, item.y - b1.y);
				
				//Checking if falls within sector
				//Condition: Magnitude less than mag, angle between particle ang vLine2 less than ang
				 if(Math.abs(vLine2.angleBetween(vParticle1)) <ang && mag>vParticle1.getMagnitude()){
					item.col = 0x000000;
				}
				//if outside of segment, original color
				else item.col = 0xCCCCCC;
				item.draw();
			}
		}
	}

}