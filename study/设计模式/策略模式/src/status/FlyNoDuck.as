package  status
{
	import inf.IFly;
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:15
	 */
	public class FlyNoDuck implements IFly 
	{
		
		public function FlyNoDuck() 
		{
			
			
		}
		
		/* INTERFACE IFly */
		
		public function fly():void
		{
			trace("我是不会飞的鸭子");
		}
		
	}

}