package factory 
{
	import flower.Orchid;
	import inf.IFlower;
	import inf.IFlowerFactory;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class OrchidFact implements IFlowerFactory
	{
		
		public function OrchidFact() 
		{
			
		}
		
		/* INTERFACE inf.IFlowerFactory */
		
		public function getFlower():IFlower 
		{
			return new Orchid();
		}
		
	}

}