package factory 
{
	import flower.Poinsettia;
	import inf.IFlower;
	import inf.IFlowerFactory;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class PosinsettiaFact implements IFlowerFactory
	{
		
		public function PosinsettiaFact() 
		{
			
		}
		
		/* INTERFACE inf.IFlowerFactory */
		
		public function getFlower():IFlower 
		{
			return new Poinsettia();
		}
		
	}

}