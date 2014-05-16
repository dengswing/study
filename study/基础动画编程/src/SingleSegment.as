package {
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SingleSegment extends Sprite {
		private var slider:SimpleSlider;
		private var segment:Segment; 
		public function SingleSegment() {
			init();
		}
		private function init():void {
			segment = new Segment(100, 20);
			addChild(segment); 
			segment.x = 100;
			segment.y = 100;
			
			slider = new SimpleSlider( -90, 90, 0);
			addChild(slider); 
			
			slider.x = 300;
			slider.y = 20; 
			
			slider.addEventListener(Event.CHANGE, onChange);		
		} 
		
		private function onChange(event:Event):void {
			segment.rotation = slider.value;
		} 
	}
}