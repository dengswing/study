package c
{
	import context.HelloFlashContext;
	
	import m.MyModel;
	
	import org.robotlegs.mvcs.Command;
	
	import v.Ball;

	public class StartupCommand extends Command
	{
		[Inject]
		public var myModel:MyModel;
		
		public function StartupCommand()
		{
		}
		
		override public function execute():void
		{
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			contextView.addChild(ball);
			
			//trace("Start ok!");
			//myModel.count++;
			//trace(myModel.count);
		}
	}
}