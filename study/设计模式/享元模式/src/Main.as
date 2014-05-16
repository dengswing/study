package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flyweight.Flyweight;
	import person.Person;
	import person.Teacher;

	/**
	 * ...
	 * @author dengswing
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
			
			var uflyweight:Flyweight = new Flyweight();
			var person1:Person = uflyweight.getPerson("10085")
			var person2:Person = uflyweight.getPerson("10086")
			var person3:Person = uflyweight.getPerson("10085")
			var person4:Person = uflyweight.getPerson("10087")
			
			if (person1 == person3)
				trace("yes");
			else 
				trace("no");
		}

	}

}