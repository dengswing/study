﻿package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.Point;
	[SWF(backgroundColor=0x000000)]
	public class NodeGardenGrid extends Sprite
	{
		private var particles:Vector.<DisplayObject>;
		private var numParticles:uint = 50;
		private var minDist:Number = 50;
		private var springAmount:Number = .001;
		private var grid:CollisionGrid;
		
		public function NodeGardenGrid()
		{
			init();
		}
		
		private function init():void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			grid = new CollisionGrid(stage.stageWidth, stage.stageHeight, 50);
			particles = new Vector.<DisplayObject>();
			
			for(var i:uint = 0; i < numParticles; i++)
			{
				var particle:Ball = new Ball(3, 0xffffff);
				particle.x = Math.random() * stage.stageWidth;
				particle.y = Math.random() * stage.stageHeight;
				particle.vx = Math.random() * 6 - 3;
				particle.vy = Math.random() * 6 - 3;
				addChild(particle);
				
				particles.push(particle);
			}
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			graphics.clear();
			
			for(var i:uint = 0; i < numParticles; i++)
			{
				var particle:Ball = particles[i] as Ball;
				particle.x += particle.vx;
				particle.y += particle.vy;
				
				if(particle.x > stage.stageWidth)
				{
					particle.x = 0;
				}
				else if(particle.x < 0)
				{
					particle.x = stage.stageWidth;
				}
				if(particle.y > stage.stageHeight)
				{
					particle.y = 0;
				}
				else if(particle.y < 0)
				{
					particle.y = stage.stageHeight;
				}
			}
			
			grid.check(particles);
			
			var checks:Vector.<DisplayObject> = grid.checks;
			trace(checks.length);
			var numChecks:int = checks.length;
			for(i=0; i < numChecks; i += 2)
			{
				var partA:Ball = checks[i] as Ball;
				var partB:Ball = checks[i + 1] as Ball;
				spring(partA, partB);
			}
			
		}
		private function spring(partA:Ball, partB:Ball):void
		{
			var dx:Number = partB.x - partA.x;
			var dy:Number = partB.y - partA.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			
			if(dist < minDist)
			{
				graphics.lineStyle(1, 0xffffff, 1 - dist / minDist);
				graphics.moveTo(partA.x, partA.y);
				graphics.lineTo(partB.x, partB.y);
				
				var ax:Number = dx * springAmount;
				var ay:Number = dy * springAmount;
				partA.vx += ax;
				partA.vy += ay;
				partB.vx -= ax;
				partB.vy -= ay;
			}
		}
	}
}