package com.game.objects {
	import flash.display.MovieClip;
	import flash.events.Event;


	public class SmokeFx extends MovieClip {

		public function SmokeFx(){
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function onEnterFrame(e:Event):void {
			if (this.currentFrame == this.totalFrames){
				distroy();
			}
		}

		public function distroy(){
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.parent.removeChild(this);
		}

	}
}