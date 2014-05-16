package mvc.controller 
{
	import mvc.view.BtnMediator;
	import mvc.view.TextMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * ...
	 * @author eko
	 */
	public class EkoCommand extends SimpleCommand
	{
		
		public function EkoCommand() 
		{
			super();
			
		}
		override public function execute(note:INotification):void
		{
			var _main:Main = note.getBody() as Main;
			facade.registerMediator(new TextMediator(_main.txtEko));
			facade.registerMediator(new BtnMediator(_main.btnEko));
		}
	}
	
}