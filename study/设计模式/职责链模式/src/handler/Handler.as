package handler 
{
	import inf.IActivity;
	import management.AbstractManagement;
	import management.activity.Department;
	import management.activity.GeneralManager;
	import management.activity.ProjectManager;
	import management.subsidy.Department2;
	import management.subsidy.GeneralManager2;
	import management.subsidy.ProjectManager2;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class Handler 
	{
		
		/**
		 * 处理职责链
		 */
		public function Handler() 
		{
			
		}
		
		public function handlerFund(activity:IActivity):void 
		{
			var pro:AbstractManagement = new ProjectManager();
			var depm:AbstractManagement = new Department();
			var gen:AbstractManagement = new GeneralManager();
			
			pro.setNextHandler(depm);
			depm.setNextHandler(gen);			
			pro.handler(activity);
		}
		
		public function handlerSubisdy(activity:IActivity):void 
		{
			var pro:AbstractManagement = new ProjectManager2();
			var depm:AbstractManagement = new Department2();
			var gen:AbstractManagement = new GeneralManager2();
			
			pro.setNextHandler(depm);
			depm.setNextHandler(gen);			
			pro.handler(activity);
		}
	}

}