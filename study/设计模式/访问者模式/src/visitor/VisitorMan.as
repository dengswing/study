package visitor 
{
	import inf.IVisitor;
	import park.Park;
	import park.ParkA;
	import park.ParkB;
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:35
	 */
	public class VisitorMan implements IVisitor
	{
		
		/**
		 * 管理员
		 */
		public function Visitor() 
		{
			
			
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorPark(tpark:Park):void
		{
			trace("管理员，检查:"+tpark.name);
		}
		
		public function visitorParkA(tpark:ParkA):void
		{
			trace("管理员，检查:"+tpark.name);
		}
		
		/* INTERFACE IVisitor */
		
		public function visitorParkB(tpark:ParkB):void
		{
			trace("管理员，检查:"+tpark.name);
		}
		
	}

}