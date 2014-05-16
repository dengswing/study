package 
{
	import adapter.DataLinesAdapter;
	import adapter.DataLinesAdapterB;
	import flash.display.Sprite;
	import flash.events.Event;
	import inf.IDataLines;
	import lines.DataLines;

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
			
			var dataLines:DataLines = new DataLines();
			var tAdapter:IDataLines = new DataLinesAdapter();
			tAdapter.linesTwoPointFive();
			
			trace("---------------------------");
			//方法2
			tAdapter = new DataLinesAdapterB(dataLines);
			tAdapter.linesTwoPointFive();			
		}

	}

}