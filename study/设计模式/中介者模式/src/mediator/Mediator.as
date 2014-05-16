package mediator 
{
	import person.Man;
	import person.Person;
	import person.Women;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Mediator 
	{
		//绑定的人
		private var _currentPerson:Person;
		
		public function Mediator() 
		{
			
		}
		
		/**
		 * 交往
		 * @param	value
		 */
		public function contact(value:Person):void
		{
			if ((value is Man && _currentPerson is Man) || (value is Women && _currentPerson is Women))
			{
				trace("对不起,这不是我的爱好!");
			}else
			{
				trace(_currentPerson.name, "和", value.name, "天生一对");
			}
		}	
		
		public function set currentPerson(value:Person):void 
		{
			_currentPerson = value;
		}
		
	}

}