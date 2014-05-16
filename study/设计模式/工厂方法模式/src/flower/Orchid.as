package flower 
{
	import inf.IFlower;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Orchid implements IFlower
	{
		
		/**
		 * 兰花
		 */
		public function Orchid() 
		{
			
		}
		
		/* INTERFACE inf.IBuyFlower */
		
		public function buy():void 
		{
			trace("买兰花");
		}
		
	}

}