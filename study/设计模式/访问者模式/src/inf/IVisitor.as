package inf
{
	import park.Park;
	import park.ParkA;
	import park.ParkB;
	
	/**
	 * @author dengswing
	 * @date 2012-2-16 16:29
	 */
	public interface IVisitor 
	{
		function visitorPark(tpark:Park):void
		function visitorParkA(tpark:ParkA):void
		function visitorParkB(tpark:ParkB):void
	}
	
}