package  car
{
	/**
	 * @author dengswing
	 * @date 2012-2-17 11:19
	 */
	public class AbstractCar 
	{
		
		/**
		 * 抽象汽车
		 */
		public function AbstractCar() 
		{
			
		}
		
		/**
		 * 组装车
		 */
		public function makeCar():void
		{
			carHead();
			carBody();
			carTail();
		}
		
		
		/**
		 * 车头
		 */
		public function carHead():void 
		{
			throw new Error("this abstract class");
		};
		
		/**
		 * 车身
		 */
		public function carBody():void
		{
			throw new Error("this abstract class");
		}
		
		
		/**
		 * 车尾
		 */
		public function carTail():void
		{
			throw new Error("this abstract class");
		}
		
	}

}