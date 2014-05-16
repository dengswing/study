package 
{
	import duck.AbstractDuck;
	import duck.HasFlyDuck;
	import duck.OrdinaryDuck;
	import flash.display.Sprite;
	import flash.events.Event;
	import status.Quack;

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
			
			
			var ordinar:AbstractDuck = new OrdinaryDuck();
			ordinar.display();
			ordinar.performFly();
			ordinar.performQuack();
			
			trace("---------------");
			ordinar = new HasFlyDuck();
			ordinar.display();
			ordinar.performFly();
			ordinar.performQuack();
			
			trace("---------------");
			ordinar.setQuack(new Quack());
			ordinar.display();
			ordinar.performQuack();
			
		}

	}

}