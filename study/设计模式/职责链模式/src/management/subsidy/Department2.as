package management.subsidy 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.activity.Department;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Department2 extends Department
	{
		
		/**
		 * 部门经理
		 */
		public function Department2() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.SUBSIDY && activity1.name == "小丽" && activity1.fund <= 500)			
			{			
				trace("小丽申请，部门经理审批通过", "补贴为", activity1.fund);
			}else
			{
				super.handler(activity1);
			}
		}
		
	}

}