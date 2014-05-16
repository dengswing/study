package car
{
	/**
	 * @author dengswing
	 * @date 2012-2-17 11:23
	 */
	public class Cars extends AbstractCar
	{
		
		/**
		 * 小汽车
		 */
		public function Cars() 
		{
			
		}
		
		override public function carHead():void 
		{
			trace("cars head");
		}
		
		override public function carBody():void 
		{
			trace("cars tail");
		}
		
		override public function carTail():void 
		{
			trace("cars tail");
		}
		
	}

}