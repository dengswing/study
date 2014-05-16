package flower 
{
	import inf.IFlower;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class RedRose implements IFlower
	{
		/**
		 * 红玫瑰
		 */
		public function RedRose() 
		{
			
		}
		
		/* INTERFACE inf.IBuyFlower */
		
		public function buy():void 
		{
			trace("买红玫瑰");
		}
		
	}

}