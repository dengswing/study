package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mediator.Mediator;
	import person.Man;
	import person.Women;

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
			
			
			var uMediator:Mediator = new Mediator();
			var man:Man = new Man("lilei");
			var women:Women = new Women("hangmeimei");
			
			man.uMediator = uMediator;
			women.uMediator = uMediator;
			
			man.request(women);
			women.request(man);
			women.request(women);
		}

	}

}