package person 
{
	/**
	 * @author dengswing
	 * @date 2012-2-20 15:54
	 */
	public class Teacher extends Person
	{
		private var _number:String;	//编号
		
		public function Teacher() 
		{
			
		}
		
		public function get number():String { return _number; }
		
		public function set number(value:String):void 
		{
			_number = value;
		}
		
	}

}