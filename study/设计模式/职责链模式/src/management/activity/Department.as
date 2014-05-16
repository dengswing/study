package management.activity 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.AbstractManagement;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Department extends AbstractManagement
	{		
		/**
		 * 部门经理
		 */
		public function Department() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.FUND && activity1.name == "小丽" && activity1.fund <= 1000)			
			{			
				trace("小丽申请，部门经理审批通过", "经费为", activity1.fund);
			}else
			{
				uAbstractManagement.handler(activity1);
			}
		}
		
	}

}