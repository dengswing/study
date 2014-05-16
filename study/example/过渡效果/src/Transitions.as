package {
	import flash.display.*;
	import flash.events.*;

	public class Transitions extends MovieClip {
		static public var val:Number = new Number();
		static public var transitionAttached:Boolean = new Boolean();
		public function Transitions() {
			val = 7;
			transitionAttached = false;
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		public function enterFrame(e:Event){
			if(transitionAttached == false){
				transitionAttached = true;
				var f1:Sprite=new FadeEffect;
				stage.addChild(f1);
				trace("hell");
			}
		}
	}
}