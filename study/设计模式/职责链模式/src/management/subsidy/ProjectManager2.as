package management.subsidy 
{
	import activity.CorConst;
	import inf.IActivity;
	import management.activity.ProjectManager;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class ProjectManager2 extends ProjectManager
	{		
		
		/**
		 * 项目经理
		 */
		public function ProjectManager2() 
		{
			
		}
		
		override public function handler(activity1:IActivity):void 
		{
			if (activity1.type == CorConst.SUBSIDY &&  activity1.name == "小丽" && activity1.fund <= 200)
			{			
				trace("小丽申请，项目经理审批通过", "补贴为", activity1.fund);
			}else 
			{				
				super.handler(activity1);
			}
		}
	}

}