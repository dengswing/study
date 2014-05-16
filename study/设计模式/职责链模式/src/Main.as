package 
{
	import activity.ActivityFund;
	import activity.ActivitySubsidy;
	import flash.display.Sprite;
	import flash.events.Event;
	import handler.Handler;
	import inf.IActivity;
	import management.AbstractManagement;

	/**
	 * ...
	 * @author dengsw
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{

		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			
			var rActivity:IActivity = new ActivityFund();
			rActivity.name = "小丽";
			rActivity.fund = 1000;
			
			var rActivity2:IActivity = new ActivityFund();
			rActivity2.name = "小累";
			rActivity2.fund = 500;
			
			var rActivity3:IActivity = new ActivitySubsidy();
			rActivity3.name = "小丽";
			rActivity3.fund = 500;
			
			var approval:Handler = new Handler();
			approval.handlerFund(rActivity);
			approval.handlerSubisdy(rActivity2);
			approval.handlerSubisdy(rActivity3);
		}

	}

}