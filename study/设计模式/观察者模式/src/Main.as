package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import inf.IObserver;
	import observable.Tourism;
	import observer.SuitorsA;
	import observer.SuitorsB;

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
			
			var utourism:Tourism = new Tourism();
			
			var sA:IObserver = new SuitorsA();
			var sB:IObserver = new SuitorsB();
			
			utourism.addObserver(sA);
			utourism.addObserver(sB);
			
			
			utourism.startTourism();
		}

	}

}