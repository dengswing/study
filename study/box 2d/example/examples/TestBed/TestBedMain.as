package TestBed {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	import TestBed.*;
	
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	
	
	/****************************************************************************
	*	
	*	TestBedMain - Document class
	*	
	****************************************************************************/
	
	
	public class TestBedMain extends MovieClip {
		
		
		
		/************************************************************************
		*	Constructor
		************************************************************************/
		public function TestBedMain() {
			addChild( new FPSCounter() );
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKey, false, 0, true );
			stop();
		}
		
		
		// switch frames on keypress
		function onKey( e:KeyboardEvent ) {
			var c:int = e.keyCode;
			if (c == Keyboard.LEFT) { switchFrames( -1 ); }
			if (c == Keyboard.RIGHT){ switchFrames(  1 ); }
			if (c == 82 /* R */) { switchFrames(-1); switchFrames(1); }
			/* num keys */
			var num:int = e.charCode - 48;
			if (num>0 && num<=totalFrames) {
				gotoAndStop(num);
			}
		}
		
		function switchFrames( dir:int ) {
			var f:int = currentFrame + dir;
			if (f<1) { f = totalFrames; }
			if (f> totalFrames) { f = 1; }
			gotoAndStop(f);
		}

		
	} // class
	
	
	
	
} // package