package factory 
{
	import flower.RedRose;
	import inf.IFlower;
	import inf.IFlowerFactory;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class RedRoseFact implements IFlowerFactory
	{
		
		public function RedRoseFact() 
		{
			
		}
		
		/* INTERFACE inf.IFlowerFactory */
		
		public function getFlower():IFlower 
		{
			return new RedRose();
		}
		
	}

}