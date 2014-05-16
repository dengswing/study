package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import inf.IBook;
	import invoke.RsProxy;

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
			
			var books:IBook = new RsProxy();
			books.saleBooks();
		}

	}

}