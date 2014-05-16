package duck
{
	import status.FlyNoDuck;
	import status.Quack;
	
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:24
	 */
	public class OrdinaryDuck  extends AbstractDuck
	{
		
		/**
		 * 普通的鸭子
		 */
		public function OrdinaryDuck() 
		{
			fly = new FlyNoDuck();
			quack = new Quack();
		}
		
		override public function display():void 
		{
			trace("普通的鸭子");
		}
	}

}