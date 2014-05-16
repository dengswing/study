package state 
{
	import context.Person;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class NoonState extends AbstractState 
	{
		
		public function NoonState() 
		{
			
		}
		
		override public function doSomething(person:Person):void 
		{
			if (person.hours == 12)
			{
				trace("吃中饭");
			}else
			{
				person.uState = new EveningState();
				person.doSomething();
			}
		}
	}

}