package management.activity 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.AbstractManagement;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class GeneralManager extends AbstractManagement
	{
		/**
		 * 总经理
		 */
		public function GeneralManager() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.FUND && activity1.name == "小丽")			
			{			
				trace("小丽申请，总经理审批通过", "经费为", activity1.fund);
			}else
			{
				trace(activity1.name, "申请，审批失败!");
			}
		}
		
	}

}