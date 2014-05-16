package c
{
	import c.event.HelloWorldMessageEvent;
	
	import org.robotlegs.mvcs.Command;
	
	import v.Ball;

	public class CreatNewBallCommand extends Command
	{
		[Inject]
		public var e:HelloWorldMessageEvent;
		
		public function CreatNewBallCommand()
		{
		}
		
		override public function execute():void
		{
			var ball:Ball = new Ball();
			ball.x = Math.random() * 500;
			ball.y = Math.random() * 375;
			contextView.addChild(ball);
			trace(e.message);
		}
	}
}