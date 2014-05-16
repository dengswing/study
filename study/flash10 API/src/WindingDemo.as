package
{

	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	[SWF(backgroundColor = 0xffffff)]
	
	public class WindingDemo extends Sprite
	{
		private var commands:Vector.<int> = new Vector.<int>();
		private var data1:Vector.<Number> = new Vector.<Number>();
		private var data2:Vector.<Number> = new Vector.<Number>();
		
		public function WindingDemo()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			commands.push(GraphicsPathCommand.MOVE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			
			data1.push(150, 100);
			data1.push(200, 100);
			data1.push(200, 250);
			data1.push(150, 250);
			data1.push(150, 100);
			
			data2.push(100, 150);
			data2.push(250, 150);
			data2.push(250, 200);
			data2.push(100, 200);
			data2.push(100, 150);
			
			/*graphics.beginFill(0xff0000,.5);
			graphics.lineStyle(1);
			graphics.drawPath(commands, data1);
			graphics.drawPath(commands, data2);
			graphics.endFill();	*/		
			
			//全部填充方法
			/*graphics.beginFill(0xff0000);
			graphics.drawPath(commands, data1);
			graphics.endFill();
			graphics.beginFill(0xff0000);
			graphics.drawPath(commands, data2);
			graphics.endFill();*/

			
			
			//另外方法绘制			
			commands.push(GraphicsPathCommand.MOVE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);
			commands.push(GraphicsPathCommand.LINE_TO);

			data1.push(100, 150);
			data1.push(250, 150);
			data1.push(250, 200);
			data1.push(100, 200);
			data1.push(100, 150);
			graphics.beginFill(0xff0000);
			graphics.drawPath(commands, data1,GraphicsPathWinding.EVEN_ODD);//第三个参数GraphicsPathWinding.NON_ZERO、GraphicsPathWinding.EVEN_ODD
			graphics.endFill();
			
			
			
		}
	}
}