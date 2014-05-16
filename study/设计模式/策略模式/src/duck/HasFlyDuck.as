package  duck
{
	import status.FlyDuck;
	import status.MuteQuack;
	
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:28
	 */
	public class HasFlyDuck extends AbstractDuck 
	{
		
		/**
		 * 会飞的鸭子
		 */
		public function HasFlyDuck() 
		{
			fly = new FlyDuck();
			quack = new MuteQuack();
		}
		
		override public function display():void 
		{
			trace("会飞的鸭子");
		}
		
	}

}