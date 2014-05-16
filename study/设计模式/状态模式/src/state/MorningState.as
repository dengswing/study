package state 
{
	import context.Person;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class MorningState extends AbstractState
	{
		
		public function MorningState() 
		{
			
		}
		
		override public function doSomething(person:Person):void 
		{
			if (person.hours == 8)
			{			
				trace("吃早餐");
			}else
			{
				person.uState = new NoonState();
				person.doSomething();
			} 
		}
		
	}

}