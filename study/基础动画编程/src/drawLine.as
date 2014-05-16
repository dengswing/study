package  
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class drawLine extends Sprite
	{
		
		public function drawLine() 
		{
			init();
		}
		
		private function init():void {
			this.graphics.lineStyle(1);
			this.graphics.moveTo(100, 100);
			this.graphics.lineTo(200, 200);
			
			var distance:Number = Point.distance(new Point(100, 100), new Point(200, 200));
			
			var angle:Number = Math.atan2(100 - 200, 100 - 200) * 180 / Math.PI;
			
			if (angle < 0)			
				angle = angle + 360;
			else 
				angle = angle;			
			
			trace(distance, angle)
			
			for (var i:int = 0; i < distance; i += 1) {				
				var mySprite:Sprite = new Sprite();
				mySprite.graphics.beginFill(0x00FF00);
				mySprite.graphics.drawCircle(0, 0, 1);
				mySprite.graphics.endFill();				
				
				mySprite.x = 100;
				mySprite.y = Math.sin(i*0.1) * distance + 100;				
				
				addChild(mySprite)
			}
			//for (var angle:Number = 0; angle < Math.PI * 2; angle += .1) { trace(Math.sin(angle)); }
		}
		
	}

}