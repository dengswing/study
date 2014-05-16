package status
{
	import inf.IQuack;
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:18
	 */
	public class MuteQuack implements IQuack
	{
		
		/**
		 * 不会叫的
		 */
		public function MuteQuack() 
		{
			
			
		}
		
		/* INTERFACE IQuack */
		
		public function quack():void
		{
			trace("不会叫的鸭子");
		}
		
	}

}