package state 
{
	import context.Person;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class EveningState extends AbstractState
	{
		
		public function EveningState() 
		{
			
		}
		
		override public function doSomething(person:Person):void 
		{
			if (person.hours == 18)
			{
				trace("吃晚饭");
			}else
			{
				person.uState = new OtherState();
				person.doSomething();
			} 
		}
	}

}