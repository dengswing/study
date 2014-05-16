package 
{
	import fl.motion.MotionEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import fl.motion.Animator;	
	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Test  extends MovieClip
	{
		
		private var loadXML:URLLoader;
		private var moveShape_xml:XML;
		private var moveShape_animator:Animator;
		
		public function Test() {		
			loadXML = new URLLoader(new URLRequest("aa.xml"));
			loadXML.addEventListener(Event.COMPLETE, completeHandler);	
			
			this.stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function completeHandler(evt:Event):void {
			moveShape_xml = XML(loadXML.data);		
			
			moveShape_animator = new Animator(moveShape_xml, aa);
			
			moveShape_animator.addEventListener(MotionEvent.MOTION_END, motionHandler);
			moveShape_animator.addEventListener(MotionEvent.MOTION_START, motionHandler);			
			moveShape_animator.play();			
		}
		
		private function clickHandler(mouseEvt:MouseEvent):void {
			moveShape_animator.play();
			trace(mouseEvt.type);
		}
		
		private function motionHandler(motionEvt:MotionEvent):void {
			trace(motionEvt.type);
		}
		
	}
	
}