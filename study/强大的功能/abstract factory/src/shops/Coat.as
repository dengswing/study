package shops 
{
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Coat extends AbstractShops
	{
		/**
		 * 上衣
		 */
		public function Coat() 
		{
			
		}
	
		override public function createShops():void 
		{
			trace("创建上衣");
		}
		
	}

}