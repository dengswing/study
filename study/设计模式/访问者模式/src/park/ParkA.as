package park 
{
	import inf.IPark;
	import inf.IVisitor;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:33
	 */
	public class ParkA implements IPark
	{
		public var name:String = "park a";
		
		/**
		 * 接受者公园的一部分a
		 */
		public function ParkA() 
		{
			
		}
		
		/* INTERFACE IPark */
		
		public function accept(visitor:IVisitor):void
		{
			visitor.visitorParkA(this);
		}
		
	}

}