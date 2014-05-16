package 
{
	import command.AbstractCommand;
	import command.AppleCommand;
	import command.BananaCommand;
	import flash.display.Sprite;
	import flash.events.Event;
	import invoker.Waiter;
	import peddler.Peddler;

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
			
			var upeddler:Peddler = new Peddler();
			var banana:AbstractCommand = new BananaCommand(upeddler);
			var apple:AbstractCommand = new AppleCommand(upeddler);
			
			var waite:Waiter = new Waiter();
			waite.addOrder(banana);
			waite.addOrder(apple);
			waite.sale();
			
			trace("----------------------------------------");
			waite.removeOrder(apple);
			waite.sale();
		}

	}

}