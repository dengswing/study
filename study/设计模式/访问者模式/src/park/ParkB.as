package park 
{
	import inf.IPark;
	import inf.IVisitor;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:48
	 */
	public class ParkB implements IPark
	{
		public var name:String = "park b";
		
		/**
		 * 接受者公园的一部分b
		 */
		public function ParkB() 
		{
			
		}
		
		/* INTERFACE IPark */
		
		public function accept(visitor:IVisitor):void
		{
			visitor.visitorParkB(this);
		}
		
	}

}