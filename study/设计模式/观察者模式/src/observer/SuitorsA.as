package observer 
{
	import inf.IObserver;
	import observable.Beauty;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class SuitorsA implements IObserver
	{
		/**
		 * 追求者A
		 */
		public function SuitorsA()
		{
			
		}
		
		public function update(beauty:Beauty):void 
		{
			trace("追求者A 收到MM的动向", beauty.currentLocation);
		}
	}

}