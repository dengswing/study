package com.game.objects {
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * 士兵
	 */
	public class Soldier extends MovieClip {
		private var xSpeed:Number;
		private var dx
		private var dy
		private var hp
		private var counter
		private var boxCount
		private var maxYspeed
		private var hit:Boolean = false;
		private var jumping:Boolean = false;
		private var g:Number = 2;
		private var enterFrameFunc:Function;

		private var magicShow:MovieClip = null;

		public function Soldier(){
			this.xSpeed = 1;
			this.dx = 0;
			this.dy = 0;
			this.hp = 50;
			this.boxCount = 350;
			this.maxYspeed = 20;

			this.moveAction0();
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(e:Event){
			this.moveRange();
			this.enterFrameFunc();
		}

		private function moveAction0(){
			this.gotoAndStop("move");
			this.counter = 0;
			this.enterFrameFunc = this.moveAction;
		}

		private function moveRange(){
			if (this.x < 20){
				this.x = 20;
				turn0()
			} else if (this.x > Main.map.width - 20){
				this.x = Main.map.width - 20;
				turn0()
			}
		}

		private function turn0(){
			this.gotoAndStop("turn");
			this.enterFrameFunc = this.turn;
		}

		private function turn(){
			if (this.mc.currentFrame == this.mc.totalFrames){
				this.scaleX = this.scaleX * -1;
				this.moveAction0();
			}
		}

		private function moveAction(){
			this.dx = this.scaleX * this.xSpeed;
			this.x = this.x + Math.round(this.dx);

			chkLand();
			chkFall();
			gForce();

		}

		private function chkTurn(){

		}

		public function chkLand(){
			var bool:Boolean = false;
			if (Main.map.ground.hitTestPoint(this.x, this.y + 2) || (this.dy >= 0 && Main.map.platform.hitTestPoint(this.x, this.y + 2))){
				this.dy = -g;
				this.jumping = false;
				bool = true;
				return (true);
			}
			return (false)
		}

		public function chkFall(){
			if (!Main.map.ground.hitTestPoint(this.x, this.y + 1) && !Main.map.platform.hitTestPoint(this.x, this.y + 1)){
				if (!this.jumping){
					this.startFall();
				}
			}
		}

		public function gForce(){
			this.dy = this.dy + g;
			this.dy = Math.min(this.maxYspeed, this.dy);
			this.y = this.y + Math.round(this.dy);
		}

		public function startFall(){
			this.dy = 0;
			this.jumping = true;
			this.mc.gotoAndPlay("top");
		}

		public function hitAction0(dmg){
			if (!this.hit){
				this.hit = true;
				this.counter = 0;
				if (this.magicShow == null){
					this.magicShow = new MagicShow()
					this.addChild(magicShow)
				}
				this.magicShow.scaleX = this.scaleX;
				this.enterFrameFunc = this.hitAction;
				this.mc.stop();
			}
			this.counter = this.counter + dmg;
			if (this.counter >= this.hp){
				this.toBox();
			}
		}

		private function toBox(){
			trace("toBox")
			var box = new Box();
			this.parent.addChild(box);
			box.x = this.x;
			box.y = this.y;
			
			var smoke = new SmokeFx();
			this.parent.addChild(smoke);
			smoke.x = this.x;
			smoke.y = this.y - 30;
			
			for (var i in Main.enemyArr) {
				if ( Main.enemyArr[i] == this ) {
					Main.enemyArr[i] = box;
				}
			}
			
			this.distroy();
		}

		private function hitAction(){
			this.magicShow.bar.scaleX = this.counter / this.hp;
			this.y = this.y + Math.round(this.dy);

			chkLand();
			chkFall();
			gForce();

			this.counter = this.counter - 0.5;
			if (this.counter <= 0){
				this.mc.play();
				this.hit = false;
				this.removeChild(this.magicShow);
				this.magicShow = null;
				this.enterFrameFunc = this.moveAction;
			}
		}
		public function distroy() {
			this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			while (this.numChildren > 0) {
				this.removeChild(this.getChildAt(0))
			}
			this.parent.removeChild(this);
			
		}

	}
}