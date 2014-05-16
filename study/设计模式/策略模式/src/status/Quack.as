package  status
{
	import inf.IQuack;
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:16
	 */
	public class Quack implements IQuack
	{
		
		/**
		 * 会叫的鸭子
		 */
		public function Quack() 
		{
			
			
		}
		
		/* INTERFACE IQuack */
		
		public function quack():void
		{
			trace("嘎嘎嘎嘎")
		}
		
	}

}