package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import item.Item;

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
			
			var shop:Item = new Item();
			shop.id = 10;
			shop.name = "桌子";
			shop.price = 20.5;
			
			var s:Item = shop.clone();
			shop.price += 10;
			trace(s.price);
			trace("--------------------")
			trace(shop.price);
		}

	}

}