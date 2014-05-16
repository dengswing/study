package flower 
{
	import inf.IFlower;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Poinsettia implements IFlower 
	{
		
		/**
		 * 一品红
		 */
		public function Poinsettia() 
		{
			
		}
		
		/* INTERFACE inf.IBuyFlower */
		
		public function buy():void 
		{
			trace("买一品红");
		}
	}

}