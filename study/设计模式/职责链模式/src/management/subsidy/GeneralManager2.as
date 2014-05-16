package management.subsidy 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.activity.GeneralManager;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class GeneralManager2 extends GeneralManager
	{
		
		/**
		 * 总经理
		 */
		public function GeneralManager2() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.SUBSIDY && activity1.name == "小丽")			
			{			
				trace("小丽申请，总经理审批通过", "补贴为", activity1.fund);
			}else
			{
				super.handler(activity1);
			}
		}
		
	}

}