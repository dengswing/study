package mvc{
	import mvc.controller.EkoCommand;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	
	public class EkoFacade extends Facade implements IFacade 
	{
		public static const STARTUP:String = "startup";
		public static const CHANGETEXT:String = "changetext";
		public function EkoFacade() {
			// constructor code
		}
		public static function getInstance():EkoFacade
		{
			if(instance==null)
			{
				instance=new EkoFacade();
			}
			return instance as EkoFacade;
		}
		override protected function initializeController():void
		{
			super.initializeController();
			registerCommand(STARTUP, EkoCommand);
		}
		public function startup(_main:Main):void
		{
			sendNotification(STARTUP, _main);
		}

	}
	
}
