package state 
{
	import context.Person;
	/**
	 * ...
	 * @author dengsw
	 */
	public class OtherState extends AbstractState
	{
		
		/**
		 * 其它时间
		 */
		public function OtherState() 
		{
			
		}
		
		override public function doSomething(person:Person):void 
		{
			trace("其它时间");
		}
		
	}

}