package activity 
{
	import inf.IActivity;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class ActivitySubsidy implements IActivity
	{
		private var _name:String;	//名称
		
		private var _fund:int;	//补贴
		
		private var _type:int;	//类型
		
		/**
		 * 活动补贴
		 */
		public function ActivitySubsidy() 
		{
			_type = CorConst.SUBSIDY;
		}
		
		
		/* INTERFACE inf.IActivity */
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get fund():int 
		{
			return _fund;
		}
		
		public function set fund(value:int):void 
		{
			_fund = value;
		}
		
		public function get type():int 
		{
			return _type;
		}
		
	}

}