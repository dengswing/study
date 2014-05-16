package  duck
{
	import inf.IFly;
	import inf.IQuack;
	
	/**
	 * @author dengswing
	 * @date 2012-2-17 15:09
	 */
	public class AbstractDuck 
	{
		
		protected var fly:IFly;
		protected var quack:IQuack;
		
		/**
		 * 抽象类，鸭子
		 */
		public function AbstractDuck() 
		{
			
		}
		
		public function performFly():void
		{
			fly.fly();
		}
		
		public function performQuack():void
		{
			quack.quack();
		}
		
		public function display():void 
		{
			throw new Error("this is abstract class");
		}		
		
		public function swim():void
		{
			trace("会游泳");
		}
		
		
		public function setFly(fly:IFly):void
		{
			this.fly = fly;
		}
		
		
		public function setQuack(quack:IQuack):void
		{
			this.quack = quack;
		}
	}

}