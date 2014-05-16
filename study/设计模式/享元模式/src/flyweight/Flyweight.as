package flyweight 
{
	import person.Person;
	import person.Teacher;
	/**
	 * @author dengswing
	 * @date 2012-2-20 15:56
	 */
	public class Flyweight 
	{
		private var aPerson:Vector.<Person>;
		
		public function Flyweight() 
		{
			
		}
		
		/**
		 * 获取人物
		 * @param	id	唯一标识
		 * @return
		 */
		public function getPerson(id:String):Person 
		{
			var teacher:Person;
			for (var i:* in aPerson)
			{
				teacher = aPerson[i] as Person;
				if (teacher.id == id)
					break;
				else 
					teacher = null;
			}
			
			if (!teacher)
			{
				if (!aPerson) aPerson = new Vector.<Person>();
				teacher = new Teacher();
				teacher.id = id;
				
				aPerson.push(teacher);
			}
			
			return teacher;
		}
		
	}

}