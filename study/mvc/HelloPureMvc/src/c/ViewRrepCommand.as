package c
{
	
	
	import flash.display.Stage;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import v.StageMediator;
	import v.TextShowMediator;
	import context.ApplicationFacade;
	
	public class ViewRrepCommand extends SimpleCommand implements ICommand
	{
		public function ViewRrepCommand()
		{
		}
		
		override public function execute(notification:INotification):void
		{
			var stage:Stage = notification.getBody() as Stage;
			facade.registerMediator(new StageMediator( stage ) );
			sendNotification(ApplicationFacade.STAGE_ADD_SPRITE );
		}
	}
}