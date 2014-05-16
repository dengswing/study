package  car
{
	/**
	 * @author dengswing
	 * @date 2012-2-17 13:09
	 */
	public class Jeep extends AbstractCar
	{
		
		/**
		 * 吉普车
		 */
		public function Jeep() 
		{
			
			
		}
		
		override public function carHead():void 
		{
			trace("jeep head");
		}
		
		override public function carBody():void 
		{
			trace("jeep body");
		}
		
		override public function carTail():void 
		{
			trace("jeep tail");
		}
	}

}