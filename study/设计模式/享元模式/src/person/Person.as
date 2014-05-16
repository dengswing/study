package person
{
	/**
	 * @author dengswing
	 * @date 2012-2-20 15:51
	 */
	public class Person 
	{
		private var _name:String;  //名称
		private var _age:int;	//年龄
		private var _sex:int;  //性别
		private var _id:String;	//id
		
		/**
		 * 人
		 */
		public function Person() 
		{
			
		}
		
		public function get name():String { return _name; }
		
		public function set name(value:String):void 
		{
			_name = value;
		}		
		
		public function get age():int { return _age; }
		
		public function set age(value:int):void 
		{
			_age = value;
		}
		
		public function get sex():int { return _sex; }
		
		public function set sex(value:int):void 
		{
			_sex = value;
		}
		
		public function get id():String { return _id; }
		
		public function set id(value:String):void 
		{
			_id = value;
		}
		
	}

}