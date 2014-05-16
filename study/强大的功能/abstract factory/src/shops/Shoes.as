package shops 
{	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Shoes extends AbstractShops
	{
		/**
		 * 鞋
		 */
		public function Shoes() 
		{
			
		}
		
		override public function createShops():void 
		{
			trace("创建鞋");
		}
		
	}

}