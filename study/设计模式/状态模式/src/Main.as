package 
{
	import context.Person;
	import flash.display.Sprite;
	import flash.events.Event;

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
			
			var person:Person = new Person();
			
			person.hours = 8;
			person.doSomething();
			
			person.hours = 10;
			person.doSomething();
			
			person.hours = 12;
			person.doSomething();
			
			person.hours = 16;
			person.doSomething();
			
			person.hours = 18;
			person.doSomething();
		}

	}

}