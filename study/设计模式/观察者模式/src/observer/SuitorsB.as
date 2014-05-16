package observer 
{
	import inf.IObserver;
	import observable.Beauty;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class SuitorsB implements IObserver
	{
		
		public function SuitorsB()
		{
			
		}
		
		/* INTERFACE inf.IObserver */
		
		public function update(beauty:Beauty):void 
		{
			trace("追求者B 收到MM的动向", beauty.currentLocation);
		}
	}

}