package park 
{
	import inf.IPark;
	import inf.IVisitor;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:31
	 */
	public class Park implements IPark
	{
		public var name:String = "park";
		
		private var parkA:ParkA;
		private var parkB:ParkB;
		
		/**
		 * 接受者公园
		 */
		public function Park() 
		{
			parkA = new ParkA();
			parkB = new ParkB();
		}
		
		/* INTERFACE IPark */
		
		public function accept(visitor:IVisitor):void
		{
			visitor.visitorPark(this);
			parkA.accept(visitor);
			parkB.accept(visitor);
		}
	}
}