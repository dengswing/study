package com.game.objects {
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * 子弹
	 */
	public class Bullet extends MovieClip {
		public var dx
		public var dy
		public var counter
		public var dmg = 5

		public function Bullet(){
			addEventListener(Event.ADDED_TO_STAGE, onAdd)
		}

		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function expl(){
			var hitFx = new HitFx()
			hitFx.x = this.x
			hitFx.y = this.y
			this.parent.addChild(hitFx);
			distroy();
		}

		private function onEnterFrame(e:Event){
			this.y = this.y + this.dy;
			this.dy = this.dy + 0.1;
			this.x = this.x + this.dx;

			for (var enemy in Main.enemyArr){
				if (Main.enemyArr[enemy].hitMc.hitTestObject(this.hitMc)){
					Main.enemyArr[enemy].hitAction0(this.dmg);
					this.expl();
					return;
				}

			}

			if (--this.counter < 0){
				for (var i = 0; i < 3; i++){
					var bulletFx = new BulletFx6();
					bulletFx.x = this.x + 10
					bulletFx.y = this.y - 8
					this.parent.addChild(bulletFx);

				}
				distroy();
			}
		}

		private function distroy(){
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			this.parent.removeChild(this)
		}
	}
}