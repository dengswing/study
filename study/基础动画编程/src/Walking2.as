package {
	import flash.display.Sprite; 
	import flash.events.Event;
	
	public class Walking2 extends Sprite { 
		private var segment0:Segment; 
		private var segment1:Segment;
		private var segment2:Segment; 
		private var segment3:Segment;
		
		private var cycle:Number = 0;
		private var offset:Number = Math.PI / 2;
		
		public function Walking2() {
			init();
		} 
		
		private function init():void {
			segment0 = new Segment(100, 20);
			addChild(segment0); 
			segment0.x = 200; 
			segment0.y = 200; 
			
			segment1 = new Segment(100, 20); 
			addChild(segment1);
			segment1.x = segment0.getPin().x;
			segment1.y = segment0.getPin().y;
			
			segment2 = new Segment(100, 20);
			addChild(segment2); 
			segment2.x = segment0.getPin().x;
			segment2.y = segment0.getPin().y;
			
			segment3 = new Segment(100, 20);
			addChild(segment3); 
			segment3.x = segment2.getPin().x;
			segment3.y = segment2.getPin().y;
			
	
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		}
		
		private function onEnterFrame(event:Event):void {
			walk(segment0, segment1, cycle);
			walk(segment2, segment3, cycle + Math.PI);
			cycle += .05; 
		}
		
		private function walk(segA:Segment, segB:Segment, cyc:Number):void {
			var angleA:Number = Math.sin(cyc) * 45 + 90;
			var angleB:Number = Math.sin(cyc + offset) * 45 + 45;
			segA.rotation = angleA; 
			segB.rotation = segA.rotation + angleB;
			segB.x = segA.getPin().x;
			segB.y = segA.getPin().y;
		}
	}
}