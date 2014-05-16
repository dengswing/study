package 
{
	import car.AbstractCar;
	import car.Cars;
	import car.Jeep;
	import flash.display.Sprite;
	import flash.events.Event;

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
			
			
			var tCar:AbstractCar = new Cars();
			tCar.makeCar();
			
			trace("------------------------")
			tCar = new Jeep();
			tCar.makeCar();
		}

	}

}