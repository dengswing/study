package com.game.utils {
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.ui.*;

	public class KeyObject extends Proxy {

		private static var keys:Object;
		private static var stage:Stage;
		
		public static var instance:KeyObject = null;

		public function KeyObject(_stage:Stage) {
			if (instance == null){
				stage = _stage;
				keys = new Object();
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedHandler);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyReleasedHandler);
				stage.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			}
		}

		private function focusOutHandler(e:FocusEvent):void {
			keys = new Object();
		}

		private function keyPressedHandler(e:KeyboardEvent):void {
			keys[e.keyCode] = true;
		}

		public function destroy():void {
			stage = null;
			keys = new Object();
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressedHandler);
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleasedHandler);
			stage.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
		}

		public function getProperty(str){
			return ((Keyboard[str]) ? Keyboard[str] : -1);
		}

		public function isDown(keycode:uint):Boolean {
			return (Boolean(keys[keycode]));
		}

		private function keyReleasedHandler(e:KeyboardEvent):void {
			delete keys[e.keyCode];
		}
		public static function getInstance() {
			if (instance) {
				return instance
			}else {
				return null
			}
		}

	}
}
