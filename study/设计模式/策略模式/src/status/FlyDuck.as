package status
{
	import inf.IFly;
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:14
	 */
	public class FlyDuck implements IFly
	{
		
		/**
		 * 会飞的鸭子
		 */
		public function FlyDuck() 
		{
			
			
		}
		
		/* INTERFACE IFly */
		
		public function fly():void
		{
			trace("我是会飞的鸭子");
		}
	}

}