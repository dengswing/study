﻿package { 
	import flash.display.Sprite; 
	import flash.display.StageAlign;
	import flash.display.StageScaleMode; 
	import flash.events.Event; 
	
	public class Friction1 extends Sprite { 
		private var ball:Ball;
		private var vx:Number = 0; 
		private var vy:Number = 0;
		private var friction:Number = 0.1;
		
		public function Friction1() {
			init();
		}
		
		private function init():void { 
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT; 
			ball = new Ball(); 
			ball.x = stage.stageWidth / 2; 
			ball.y = stage.stageHeight / 2; 
			vx = Math.random() * 10 - 5;
			vy = Math.random() * 10 - 5;
			addChild(ball); 
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame); 
		} 
		
		private function onEnterFrame(event:Event):void {
			var speed:Number = Math.sqrt(vx * vx + vy * vy); 
			var angle:Number = Math.atan2(vy, vx); 
			
			if (speed > friction) { 
				speed -= friction; 
			} else { 
				speed = 0; 
			} 
			
			vx = Math.cos(angle) * speed; 
			vy = Math.sin(angle) * speed;
			
			ball.x += vx; 
			ball.y += vy; 
		} 
	}
}