package 
{
	import factory.OrchidFact;
	import factory.PosinsettiaFact;
	import factory.RedRoseFact;
	import flash.display.Sprite;
	import flash.events.Event;
	import inf.IFlower;
	import inf.IFlowerFactory;

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
			// entry pointd
			
			var flower1:IFlowerFactory = new OrchidFact();
			var orchid:IFlower = flower1.getFlower();
			orchid.buy();
			
			
			flower1 = new PosinsettiaFact();
			orchid = flower1.getFlower();
			orchid.buy();
			
			flower1 = new RedRoseFact();
			orchid = flower1.getFlower();
			orchid.buy();			
		}

	}

}