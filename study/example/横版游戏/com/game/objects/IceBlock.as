package com.game.objects {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class IceBlock extends MovieClip {
		public var counter:Number = 150

		public function IceBlock(){
			addEventListener(Event.ADDED_TO_STAGE, onAdd)
		}

		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(e:Event):void {
			if (this.counter < 0){
				distroy();
			} 
			this.counter--
		}

		private function distroy() {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.parent.removeChild(this)
			
			if (Main.platformArr.length > 0) {
				for (var i:int = 0; i < Main.platformArr.length; i++ ) {
					if (Main.platformArr[i] == this) {
						Main.platformArr.splice(i, 1);
					}
				}
			}
		}

	}
}