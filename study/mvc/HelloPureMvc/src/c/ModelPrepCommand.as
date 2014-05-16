package c
{
	import m.BallDataProxy;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;

	public class ModelPrepCommand extends SimpleCommand
	{
		public function ModelPrepCommand()
		{
		}
		
		override public function execute(notification:INotification):void
		{
			facade.registerProxy(new BallDataProxy())
		}
	}
}