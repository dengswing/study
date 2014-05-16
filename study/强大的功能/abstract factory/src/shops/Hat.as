package shops 
{	
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Hat extends AbstractShops
	{
		/**
		 * 帽子
		 */
		public function Hat() 
		{
			
		}
		
		override public function createShops():void 
		{
			trace("创建帽子");
		}
		
	}

}