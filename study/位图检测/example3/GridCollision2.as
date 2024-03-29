﻿package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	import flash.display.DisplayObject;
	
	public class GridCollision2 extends Sprite
	{
		private const GRID_SIZE:Number = 80;
		private const RADIUS:Number = 25;
		private var _balls:Vector.<DisplayObject>;
		private var _grid:CollisionGrid;
		private var _numBalls:int = 100;
		
		public function GridCollision2()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_grid = new CollisionGrid(stage.stageWidth, stage.stageHeight, GRID_SIZE);
			_grid.drawGrid(graphics);
			makeBalls();
			
			var startTime:int;
			var elapsed:int;
			startTime = getTimer();
			
			for(var i:int = 0; i < 10; i++)
			{
				_grid.check(_balls);
				var numChecks:int = _grid.checks.length;
				
				for(var j:int = 0; j < numChecks; j += 2)
				{
					checkCollision(_grid.checks[j] as Ball, _grid.checks[j + 1] as Ball);
				}
			}
			
			elapsed = getTimer() - startTime;
			trace("Elapsed:", elapsed);
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			updateBalls();
			_grid.check(_balls);
			var numChecks:int = _grid.checks.length;
			
			for(var j:int = 0; j < numChecks; j += 2)
			{
				checkCollision(_grid.checks[j] as Ball, _grid.checks[j + 1] as
				Ball);
			}
		}
				
		private function makeBalls():void
		{
			_balls = new Vector.<DisplayObject>(_numBalls);
			for(var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = new Ball(RADIUS);
				ball.x = Math.random() * stage.stageWidth;
				ball.y = Math.random() * stage.stageHeight;
				ball.vx = Math.random() * 4 - 2;
				ball.vy = Math.random() * 4 - 2;
				addChild(ball);
				_balls[i] = ball;
			}
		}
		
		private function updateBalls():void
		{
			for(var i:int = 0; i < _numBalls; i++)
			{
				var ball:Ball = _balls[i] as Ball;
				
				ball.update();
				if(ball.x < RADIUS)
				{
					ball.x = RADIUS;
					ball.vx *= -1;
				}
				else if(ball.x > stage.stageWidth - RADIUS)
				{
					ball.x = stage.stageWidth - RADIUS;
					ball.vx *= -1;
				}
				if(ball.y < RADIUS)
				{
					ball.y = RADIUS;
					ball.vy *= -1;
				}
				else if(ball.y > stage.stageHeight - RADIUS)
				{
					ball.y = stage.stageHeight - RADIUS;
					ball.vy *= -1;
				}
				
				ball.color = 0xffffff;			
			}
		}
		
		private function checkCollision(ballA:Ball, ballB:Ball):void
		{
			var dx:Number = ballB.x - ballA.x;
			var dy:Number = ballB.y - ballA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if(dist < ballA.radius + ballB.radius)
			{
				ballA.color = 0xff0000;
				ballB.color = 0xff0000;
			}
		}
	}
}