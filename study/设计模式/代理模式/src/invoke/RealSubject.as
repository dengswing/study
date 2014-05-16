package invoke 
{
	import inf.IBook;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class RealSubject implements IBook
	{
		/**
		 * 卖书
		 */
		public function RealSubject() 
		{
			
		}
		
		/* INTERFACE inf.IBook */
		
		public function saleBooks():void 
		{
			trace("卖书.");
		}
		
	}

}