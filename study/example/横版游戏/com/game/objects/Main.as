package com.game.objects{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.game.utils.KeyObject;


	public class Main extends MovieClip {
		public var stageWidth;
		public var stageHeight
		public static var sceneWidth;
		public static var sceneHeight;
		public static var Key:KeyObject
		public static var map:MovieClip
		public static var platformArr:Array = [];
		public static var enemyArr:Array = [];
	
		private const leftCode:Number = 37;
		private const rightCode:Number = 39;
		private const jumpCode:Number = 38;
		private const duckCode:Number = 40;
		private const left2Code:Number = 65;
		private const right2Code:Number = 68;
		private const jump2Code:Number = 87;
		private const duck2Code:Number = 83;
		private const attackCode:Number = 74;
		private const attack2Code:Number = 90;
		private const makingIceCode:Number = 75;
		private const makingIce2Code:Number = 88;
		private const pauseCode:Number = 80;


		public function Main(){
			addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInit);

			stageWidth = 500;
			stageHeight = 350;
			sceneWidth = Math.round(this.bg.width);
			sceneHeight = Math.round(this.bg.height);
			map = _map
			enemyArr.push(enemy);
	
			Key = new KeyObject(stage);

			addEventListener(Event.ENTER_FRAME, onEnter);
		}

		private function onEnter(e:Event):void {
			scrolling()
		}

		public function scrolling(){
			if (this.player.scaleX > 0){
				this.x = this.x + Math.round((150 - this.player.x - this.x) * 0.1);
				if (Key.isDown(duckCode) || Key.isDown(duck2Code)){
					this.y = this.y + Math.round((120 - this.player.y - this.y) * 0.7);
				} else {
					this.y = this.y + Math.round((240 - this.player.y - this.y) * 0.2);
				}
			} else {
				this.x = this.x + Math.round((350 - this.player.x - this.x) * 0.1);
				if (Key.isDown(duckCode) || Key.isDown(duck2Code)){
				   this.y = this.y + Math.round((120 - this.player.y - this.y) * 0.07);
				   } else {
				   this.y = this.y + Math.round((240 - this.player.y - this.y) * 0.2);
				 } 
			} 

			if (this.x > 0){
				this.x = 0;
			} else if (sceneWidth - stageWidth - 60 < -this.x){
				this.x = stageWidth - sceneWidth + 60;
			}
			if (this.y > 0){
				this.y = 0;
			} else if (sceneHeight - stageHeight - 190 < -this.y) {
				this.y = stageHeight - sceneHeight +190;
			}

		}


	}
}