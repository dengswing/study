package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author dengSwing
	 */
	public class SegmentMain extends Sprite
	{
		
		public function SegmentMain() 
		{
			init();
		}
		
		private function init():void {
			var segment:Segment = new Segment(100, 20);
			addChild(segment);			
			segment.x = 100;
			segment.y = 50;
			
			var segment1:Segment = new Segment(200, 10);
			addChild(segment1); 
			segment1.x = 100;
			segment1.y = 80; 
			
			var segment2:Segment = new Segment(80, 40);
			addChild(segment2); 
			segment2.x = 100; 
			segment2.y =120;
		}
		
	}

}