package visitor 
{
	import inf.IVisitor;
	import park.Park;
	import park.ParkA;
	import park.ParkB;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:37
	 */
	public class VisitorClear implements IVisitor
	{
		
		/**
		 * 清洁工
		 */
		public function VisitorClear() 
		{
			
			
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorPark(tpark:Park):void
		{
			
		}
		
		public function visitorParkA(tpark:ParkA):void
		{
			trace("清洁工A, 打扫:" + tpark.name);
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorParkB(tpark:ParkB):void
		{
			
		}
		
	}

}