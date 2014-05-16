package visitor 
{
	import inf.IVisitor;
	import park.ParkB;
	import park.ParkA;
	import park.Park;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:54
	 */
	public class VisitorClearB implements IVisitor
	{
		
		public function VisitorClearB() 
		{
			
			
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorPark(tpark:Park):void
		{
			
		}
		
		public function visitorParkA(tpark:ParkA):void
		{
			
		}
		
		public function visitorParkB(tpark:ParkB):void
		{
			trace("清洁工B, 打扫:" + tpark.name);
		}
		
	}

}