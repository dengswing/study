package{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	public class GridCollision extends Sprite
	{
		private const GRID_SIZE: Number = 50;
		private const RADIUS: Number = 25;
		private var _balls: Array;
		private var _grid: Array;
		private var _numBalls: int = 100;
		private var _numChecks: int = 0;
		
		public function GridCollision()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			makeBalls();
			makeGrid();
			drawGrid();
			assignBallsToGrid();
			checkGrid();
		}
		// 剩余的函数等下一一介绍
		
		private function makeBalls(): void
		{
			_balls = new Array();
			
			for(var i: int=0; i < _numBalls; i++)
			{
				// 创建出一个球，然后把它加入显示列表以及数组
				var ball: Ball = new Ball(RADIUS);
				ball.x = Math.random() * stage.stageWidth;
				ball.y = Math.random() * stage.stageHeight;
				addChild(ball);
				_balls.push(ball);
			}
		}
		
		private function makeGrid(): void
		{
			_grid = new Array();
			// 场景宽度 / 格子大小 = 网格列数
			for(var i: int=0; i < stage.stageWidth / GRID_SIZE; i++)
			{
				_grid[ i ] = new Array();
				
				// 场景高度 / 格子大小 = 网格行数
				for(var j: int=0; j < stage.stageHeight / GRID_SIZE; j++)
				{			
					_grid[ i ][j] = new Array();
				}
			}
		}
		
		private function drawGrid(): void
		{
			// 画出行列线
			graphics.lineStyle(0, .5);
			for(var i: int=0; i <= stage.stageWidth; i+=GRID_SIZE)
			{
				graphics.moveTo(i, 0);
				graphics.lineTo(i, stage.stageHeight);
			}
			
			for(i=0; i <= stage.stageHeight; i+=GRID_SIZE)
			{
				graphics.moveTo(0, i);
				graphics.lineTo(stage.stageWidth, i);
			}
		}		
		
		
		private function assignBallsToGrid(): void
		{
			for(var i: int=0; i < _numBalls; i++)
			{
				// 球的位置除以格子大小，得到该球所在网格的行列数
				var ball: Ball = _balls[ i ] as Ball;
				var xpos: int = Math.floor(ball.x / GRID_SIZE);
				
				var ypos: int = Math.floor(ball.y / GRID_SIZE);
				_grid[ xpos ][ ypos ].push(ball);
			}
		}
		
		
		
		private function checkGrid(): void
		{
			for(var i: int=0; i < _grid.length; i++)
			{			
				for(var j: int=0; j < _grid[ i ].length; j++)
				{
					// 检测第一个格子内的对象间是否发生碰撞
					checkOneCell(i, j);
					checkTwoCells(i, j, i+1, j); // 右边的格子
					checkTwoCells(i, j, i-1, j+1); // 左下角的格子
					checkTwoCells(i, j, i, j+1); // 下边的格子
					checkTwoCells(i, j, i+1, j+1); // 右下角的格子
				}
			}
		}
		
		private function checkOneCell(x: int, y: int): void
		{
			// 检测当前格子内所有的对象
			var cell:Array = _grid[ x ][ y ] as Array;
			
			for(var i: int=0; i < cell.length-1; i++)
			{
				var ballA: Ball = cell[ i ] as Ball;
				for(var j: int=i+1; j < cell.length; j++)
				{
					var ballB: Ball = cell[ j ] as Ball;
					checkCollision(ballA, ballB);
				}
			}
		}
		
		private function checkTwoCells(x1: int, y1: int, x2: int, y2: int): void
		{
			// 确保要检测的格子存在
			if(x2 < 0) return;
			if(x2 >= _grid.length) return;
			if(y2 >= _grid[ x2 ].length) return;
			var cell0:Array = _grid[ x1 ][ y1 ] as Array;
			var cell1:Array = _grid[ x2 ][ y2 ] as Array;
			// 检测当前格子和邻接格子内所有的对象
			for(var i: int=0; i < cell0.length; i++)
			{
				var ballA: Ball = cell0[ i ] as Ball;
				for(var j: int=0; j < cell1.length; j++)
				{
					var ballB: Ball = cell1[ j ] as Ball;
					checkCollision(ballA, ballB);
				}
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