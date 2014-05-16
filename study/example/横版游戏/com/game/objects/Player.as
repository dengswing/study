package com.game.objects {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import com.game.objects.Bullet;

	public class Player extends MovieClip {
		private var life:Number;
		private var magicLv:Number;
		private var dx:Number;
		private var dy:Number;
		private var acl:Number;
		private var jumping:Boolean;
		private var attacking:Boolean;
		private var iceMode:Boolean;
		private var jumpSpeed:Number;
		private var xSpeed:Number;

		private var unbreakable:Boolean = false;
		private var onMovingTile:Boolean = true;
		private var g:Number = 2;
		private var friction:Number = 0.6;
		private var maxYspeed:Number = 4;
		private var tmpPickBox:MovieClip

		private var keyArr:Array = [];
		private var enterFrameFunc:Function;

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

		public function Player(){
			addEventListener(Event.ADDED_TO_STAGE, onInitStage)
		}

		private function onInitStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onInitStage);

			init();
			idleAction0();
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function init(lf = 5, ml = 1):void {
			//初始化人物参数
			this.life = lf;
			this.magicLv = ml;
			//showNum(ui.score, currentScore);
			this.dx = 0;
			this.dy = 0;
			this.acl = 0.8;
			this.jumping = false;
			this.jumpSpeed = 20;
			this.maxYspeed = 20;
			this.xSpeed = 12;


		}

		private function onEnterFrame(e:Event){
			this.enterFrameFunc();
		}

		private function fullLife():void {
			//血槽同步显示
		}

		private function landAction0(){
			//trace("land")
			this.mc.gotoAndStop("land");
			this.mc.play();
			this.enterFrameFunc = this.landAction;
		}

		private function idleAction0(){
			//trace("idle")
			this.gotoAndStop("idle");
			this.enterFrameFunc = this.idleAction;
		}

		private function jumpAction0(){
			//trace("jump")
			this.gotoAndStop("jump");
			this.enterFrameFunc = this.jumpAction;
		}

		private function duckAction0(){
			//trace("duck")
			this.gotoAndStop("duck");
			this.enterFrameFunc = this.duckAction;
		}

		private function runAction0(){
			//trace("run")
			this.gotoAndStop("run");
			this.enterFrameFunc = this.runAction;
		}

		private function hitAction0(){
			if (this.unbreakable || this.currentFrame == 90){
				return;
			}
			this.magicDown();
			this.gotoAndStop("hit");
			this.dy = -14;
			this.dx = -this.scaleX * 0.05;
			this.enterFrameFunc = this.hitAction;
		}



		private function pickAction0(){
			this.gotoAndStop("pick");
			this.enterFrameFunc = this.pickAction;
		}

		private function idleAction(){
			this.ifAttack();
			this.ifMoveIdle();
			this.ifJump();
			this.ifDuck();
			this.gForce();
			this.chkLand();
			this.chkFall();
			this.moveRange();
			this.ifHitEnemy();
		}

		private function landAction(){
			this.ifAttack();
			this.ifJump();
			this.ifMoveJump();
			this.gForce();
			if (this.mc.currentFrame == this.mc.totalFrames){
				this.idleAction0();
			}
			this.ifDuck();
			if (this.moveAction() != 0){
				this.runAction0();
			}
			this.gForce();
			this.chkLand();
			this.chkFall();
			this.moveRange();
			this.ifHitEnemy();
		}

		private function duckAction(){
			this.ifAttack();
			this.ifMoveDuck();
			this.ifStandUp();
			this.moveActionFriction();
			this.gForce();
			this.chkLand();
			this.chkFall();
			this.moveRange();
			this.ifHitEnemy();
		}

		private function runAction(){
			//trace("runAction")
			this.ifAttack();
			this.ifMoveRun();
			this.ifJump();
			this.ifDuck();
			if (this.moveAction() == 0){
				this.idleAction0();
			}
			this.gForce();
			this.chkLand();
			this.chkFall();
			this.moveRange();
			this.ifHitEnemy();
		}

		private function jumpAction(){
			this.ifAttack();
			this.ifMoveJump();
			this.moveAction();
			if (this.dy == 1){
				this.mc.gotoAndPlay("top");
			} else if (this.dy > 6){
				this.mc.gotoAndStop("down");
			} else if (this.dy < 0){
				this.mc.gotoAndStop("rise");
			}
			this.gForce();
			if (this.chkLand()){
				this.idleAction0();
					//this.ifJump();
					//this.landAction0();
			}
			this.moveRange();
			this.ifHitEnemy();
		}

		private function ifMoveIdle(){
			var bool = false
			if (Main.Key.isDown(leftCode) || Main.Key.isDown(left2Code)){
				this.faceLeft();
				this.dx = this.dx + (-this.xSpeed - this.dx) * this.acl;
				bool = true;
			} else if (Main.Key.isDown(rightCode) || Main.Key.isDown(right2Code)){
				this.faceRight();
				this.dx = this.dx + (this.xSpeed - this.dx) * this.acl;
				bool = true;
			}
			if (bool){
				this.runAction0();
			}
		}



		private function faceLeft():void {
			if (this.scaleX > 0){
				this.scaleX = this.scaleX * -1;
			}
		}

		public function faceRight():void {
			if (this.scaleX < 0){
				this.scaleX = this.scaleX * -1;
			}
		}

		private function moveRange():void {
			if (this.x < 20){
				this.x = 20;
			} else if (this.x > Main.sceneWidth - 20){
				this.x = Main.sceneWidth - 20;
			}
		}

		private function moveAction(){
			this.x = this.x + Math.round(this.dx);
			if (!Main.Key.isDown(leftCode) && !Main.Key.isDown(rightCode) && !Main.Key.isDown(left2Code) && !Main.Key.isDown(right2Code)){
				if (!this.jumping){
					this.dx = this.dx * friction;
				} else {
					this.dx = this.dx * 0.9;
				}
				if (Math.abs(this.dx) < this.acl){
					this.dx = 0;
				}
			}
			return (this.dx);
		}

		private function moveActionFriction(){
			if (!Main.map.ground.hitTestPoint(this.x, this.y)){
				this.x = this.x + Math.round(this.dx);
			}
			this.dx = this.dx * friction;
			if (Math.abs(this.dx) < this.acl){
				this.dx = 0;
			}
		}

		private function ifMoveRun(){
			if (Main.Key.isDown(leftCode) || Main.Key.isDown(left2Code)){
				this.faceLeft();
				this.dx = this.dx + (-this.xSpeed - this.dx) * this.acl;
			} else if (Main.Key.isDown(rightCode) || Main.Key.isDown(right2Code)){
				this.faceRight();
				this.dx = this.dx + (this.xSpeed - this.dx) * this.acl;
			}
		}

		private function ifMoveJump(){
			if (Main.Key.isDown(leftCode) || Main.Key.isDown(left2Code)){
				this.faceLeft();
				this.dx = this.dx + (-this.xSpeed - this.dx) * this.acl;
			} else if (Main.Key.isDown(rightCode) || Main.Key.isDown(right2Code)){
				this.faceRight();
				this.dx = this.dx + (this.xSpeed - this.dx) * this.acl;
			}
		}

		private function ifMoveDuck(){
			if (Main.Key.isDown(leftCode) || Main.Key.isDown(left2Code)){
				this.faceLeft();
			} else if (Main.Key.isDown(rightCode) || Main.Key.isDown(right2Code)){
				this.faceRight();
			}
		}

		private function ifJump(){
			if (!this.jumping){
				if (Main.Key.isDown(jumpCode) || Main.Key.isDown(jump2Code)){
					if (!keyArr[jumpCode]){
						keyArr[jumpCode] = 1;
						this.startJump(-jumpSpeed);
						this.jumpAction0();
					}
				} else {
					keyArr[jumpCode] = 0;
				}
			}
		}

		private function startJump(jumpSpeed){
			this.dy = this.dy + jumpSpeed;
			this.jumping = true;
			this.onMovingTile = false;
		}

		private function ifDuck(){
			if (Main.Key.isDown(duckCode) || Main.Key.isDown(duck2Code)){
				this.duckAction0();
			}
		}

		private function ifStandUp(){
			if (!Main.Key.isDown(duckCode) && !Main.Key.isDown(duck2Code)){
				this.idleAction0();
			}
		}

		private function ifAttack(){
			if (!this.attacking){
				if (Main.Key.isDown(attackCode) || Main.Key.isDown(attack2Code)){
					if (!keyArr[attackCode]){
						this.iceMode = false;
						keyArr[attackCode] = 1;
						this.attackAction0();
					}
				} else {
					keyArr[attackCode] = 0;
				}
				if (Main.Key.isDown(makingIceCode) || Main.Key.isDown(makingIce2Code)){
					if (!keyArr[makingIceCode]){
						keyArr[makingIceCode] = 1;
						this.iceMode = true;
						this.attackAction0();
					}
				} else {
					keyArr[makingIceCode] = 0;
				}
			}
		}

		private function attackAction0(){
			this.gotoAndStop(11);
			if (!this.jumping){
				this.dx = 0;
			} else {
				this.mc.gotoAndPlay(10);
			}
			this.enterFrameFunc = this.attackAction;
		}

		public function attackAction(){
			if (this.jumping){
				//trace ("跳跃中攻击")
				this.ifMoveJump();
				this.moveAction();
				this.gForce();
				if (this.chkLand()){
					this.gotoAndStop(11);
					this.mc.gotoAndPlay(this.mc.currentFrame);
				}
			} else {
				this.chkFall();
			}
			if (this.mc.currentFrame == 13){
				if (this.currentFrame == 30){
					newBullet(this.x + this.scaleX, this.y - 10, 12, 250, this.scaleX, this.iceMode, this.magicLv);
				} else {
					newBullet(this.x + this.scaleX, this.y - 50, 12, 250, this.scaleX, this.iceMode, this.magicLv);
				}
			} else if (this.mc.currentFrame == this.mc.totalFrames){

				switch (this.currentFrame){
					case 11:  {
						this.idleAction0();
						this.dx = 0;
						break;
					}
					case 30:  {
						this.duckAction0();
						this.dx = 0;
						this.mc.gotoAndStop(this.mc.totalFrames);
						break;
					}
					case 50:  {
						this.jumpAction0();
						break;
					}
					case 70:  {
						this.runAction0();
						this.dx = 0;
						break;
					}
				}
			}
			if (!this.jumping){
				if (Main.Key.isDown(duckCode) || Main.Key.isDown(duck2Code)){
					this.gotoAndStop("duckAttack");
					this.mc.gotoAndPlay(this.mc.currentFrame);
				}
				if (Main.Key.isDown(jumpCode) || Main.Key.isDown(jump2Code)){
					if (!keyArr[jumpCode]){
						keyArr[jumpCode] = 1;
						this.gotoAndStop("jumpAttack");
						this.mc.gotoAndPlay(this.mc.currentFrame);
						this.startJump(-this.jumpSpeed);
					}
				} else {
					keyArr[jumpCode] = 0;
				}
			}

			if (Main.Key.isDown(leftCode) || Main.Key.isDown(left2Code)){
				this.faceLeft();
			} else if (Main.Key.isDown(rightCode) || Main.Key.isDown(right2Code)){
				this.faceRight();
			}
			this.moveRange();
			this.ifHitEnemy();
		}

		public function newBullet(startx, starty, speed, range, scalex, iceMode:Boolean, magicLv:Number){
			if (iceMode == false){
				var bullet = new Bullet();
				bullet.x = startx
				bullet.y = starty
				this.parent.addChild(bullet);

				var bulletFx = new BulletFx5();
				bulletFx.x = startx;
				bulletFx.y = starty;
				this.parent.addChild(bulletFx);

				bullet.scaleX = scalex;
				bullet.dx = speed * scalex;
				bullet.dy = -1;
				if (magicLv == 0){
					range = 100;
				} else if (magicLv == 1){
					range = 250;
				} else if (magicLv == 2){
					range = 400;
				}
				bullet.dmg = magicLv * 30;
				bullet.counter = Math.round(range / speed);
			} else {
				var iceblock = new IceBlock();
				iceblock.x = startx + 70 * scaleX;
				iceblock.y = starty;
				iceblock.counter = 220;
				this.parent.addChild(iceblock)
				iceblock.gotoAndStop("ice1");
				Main.platformArr.push(iceblock)
				this.parent.setChildIndex(this, this.parent.numChildren - 1)
				trace(Main.platformArr)

			}
		}

		public function chkLand(){
			var bool:Boolean = false;
			if (Main.map.ground.hitTestPoint(this.x, this.y + 2) || (this.dy >= 0 && Main.map.platform.hitTestPoint(this.x, this.y + 2))){
				this.dy = -g;
				this.jumping = false;
				bool = true;
				return (true);
			}
			if (Main.platformArr.length > 0 && this.dy >= 0){
				for (var i in Main.platformArr){
					if (Main.platformArr[i].hitTestPoint(this.x, this.y + 1)){
						this.dy = -g;
						this.jumping = false;
						bool = true;
						return (true);
					}
				}
			}
			return (false)
		}

		public function chkFall(){
			if (!Main.map.ground.hitTestPoint(this.x, this.y + 1) && !Main.map.platform.hitTestPoint(this.x, this.y + 1)){
				for (var i in Main.platformArr){
					if (!Main.platformArr[i].hitTestPoint(this.x, this.y + 1)){
						if (!this.jumping){
							this.startFall();
						}
					}
				}
			}
		}

		public function startFall(){
			this.dy = 0;
			this.jumping = true;
			this.onMovingTile = false;
			this.jumpAction0();
			this.mc.gotoAndPlay("top");
		}

		public function gForce(){
			this.dy = this.dy + g;
			this.dy = Math.min(this.maxYspeed, this.dy);
			this.y = this.y + Math.round(this.dy);
		}

		private function ifHitEnemy(){
			for (var i in Main.enemyArr){
				if (Main.enemyArr[i] is Soldier){
					if (this.hitMc.hitTestObject(Main.enemyArr[i].hitMc)){
						this.hitAction0();
					}
					continue;
				}
				if (Main.enemyArr[i] is Box){
					var box = Main.enemyArr[i];
					if (Math.abs(this.y - box.y) < 5){
						if (Math.abs(this.x + this.scaleX * 0.15 - box.x) < 25){
							this.tmpPickBox = Main.enemyArr[i];
							this.pickAction0();
						}
					}
				}
			}
		}

		public function hitAction(){
			this.gForce();
			this.chkLand();
			this.chkFall();
			this.moveRange();

			if (this.mc.currentFrame < 15){
				this.mc.gotoAndPlay("land");
			}
			if (this.mc.currentFrame == this.mc.totalFrames){
				this.idleAction0();
			}
		}

		public function pickAction(){
			this.mc.play();
			if (this.mc.currentFrame < 5){
				tmpPickBox.x = -500
				tmpPickBox.y = -500
			} else if (this.mc.currentFrame == this.mc.totalFrames){
				this.idleAction0();
				if (tmpPickBox){
					Box(tmpPickBox).distroy();
					tmpPickBox = null;
				}
			}
		}

		public function magicFx(){

		}

		private function magicUp():void {

		}

		private function magicDown():void {

		}

	}
}
