package visitor 
{
	import inf.IVisitor;
	import park.ParkB;
	import park.ParkA;
	import park.Park;
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:59
	 */
	public class VisiTourist implements IVisitor
	{
		
		public function VisiTourist() 
		{
			
			
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorPark(tpark:Park):void
		{
			trace("游客逛公园:" + tpark.name);
		}
		
		public function visitorParkA(tpark:ParkA):void
		{
			
		}
		
		public function visitorParkB(tpark:ParkB):void
		{
			
		}
		
	}

}