package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Example extends Sprite 
	{
		
		public function Example():void {
			init();
		}
		
		
		private function init():void {
			var myExample2:Example2;
			myExample2 = Example2.getInstance();
			myExample2.addEventListener(Example3.TESTEVENT, testEventHandler);		
			myExample2.init();
			
			addChild(myExample2);
		}
		
		private function testEventHandler(evt:Event):void {
			trace(evt);		
		}
	}
	
}