package management 
{
	import inf.IActivity;
	/**
	 * ...
	 * @author dengsw
	 */
	public class AbstractManagement 
	{
		protected var uAbstractManagement:AbstractManagement;
		
		/**
		 * 管理
		 */
		public function AbstractManagement() 
		{
			
		}
		
		public function handler(activity:IActivity):void { };
		
		public function setNextHandler(value:AbstractManagement):void
		{
			uAbstractManagement = value;
		}
	}

}