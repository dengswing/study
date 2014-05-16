package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import inf.IVisitor;
	import park.Park;
	import park.ParkB;
	import visitor.VisitorClear;
	import visitor.VisitorClearB;
	import visitor.VisitorMan;
	import visitor.VisiTourist;

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
			
			var upark:Park = new Park();
			var clear:IVisitor = new VisitorClear();
			upark.accept(clear);
			
			var clear2:IVisitor = new VisitorClearB();
			upark.accept(clear2);
			
			var clears:IVisitor = new VisitorMan();
			upark.accept(clears);
			
			var tourist:IVisitor = new VisiTourist();
			upark.accept(tourist);
		}

	}

}