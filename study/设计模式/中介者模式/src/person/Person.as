package person 
{
	import mediator.Mediator;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Person 
	{
		protected var _name:String;
		private var _uMediator:Mediator;
		
		/**
		 * 人
		 */
		public function Person(name:String) 
		{
			_name = name;
		}
		
		public function set uMediator(value:Mediator):void 
		{
			_uMediator = value;			
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		/**
		 * 请求
		 * @param	value
		 */
		public function request(value:Person):void
		{
			_uMediator.currentPerson = this;
			_uMediator.contact(value);
		}
	}

}