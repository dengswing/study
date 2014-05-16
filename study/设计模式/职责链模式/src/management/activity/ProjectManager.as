package management.activity 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.AbstractManagement;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class ProjectManager extends AbstractManagement
	{		
		/**
		 * 项目经理
		 */
		public function ProjectManager() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.FUND &&  activity1.name == "小丽" && activity1.fund <= 500)			
			{			
				trace("小丽申请，项目经理审批通过", "经费为", activity1.fund);
			}else
			{
				uAbstractManagement.handler(activity1);
			}
		}
	}

}