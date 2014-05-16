package TestBed {
	
	import flash.display.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.events.*;
	
	/****************************************************************************
	*	
	*	A minimal FPS counter
	*	
	****************************************************************************/
	
	
	public class FPSCounter extends Sprite {
		
		private var every:int = 500; // update every X miliseconds
		
		private var f:int;
		private var tf:TextField;
		private var t0:int;
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function FPSCounter() {
			tf = new TextField();
			var tff:TextFormat = new TextFormat( "_sans", 11 );
			tf.defaultTextFormat = tff;
			tf.x = 5;
			tf.y = 2;
			addChild(tf);
			mouseEnabled = false;
			mouseChildren = false;
			addEventListener( Event.ADDED_TO_STAGE, onAdd, false, 0, true );
		}
		
		public function onAdd( evt:Event ):void {
			t0 = getTimer();
			f = 0;
			stage.addEventListener( Event.ENTER_FRAME, onFrame, false, 0, true );
			removeEventListener( evt.type, onAdd );
		}
		
		public function onFrame( evt:Event ):void {
			f++;
			var t:int = getTimer();
			var dt:int = t-t0;
			if (dt > every) {
				var fps:Number = 1000*f/dt;
				fps = Math.round(fps*10) / 10;
				var s:String = (fps==Math.round(fps)) ? ".0" : "";
				tf.text = "FPS: "+fps+s;
				t0 = t;
				f = 0;
			}
		}
		
		
	} // class
	
	
	
	
	
	
} // package