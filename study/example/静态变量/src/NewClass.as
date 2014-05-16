package  
{
	/**
	 * ...
	 * @author dengSwing
	 */
	public class NewClass extends AbstractTest
	{
		private static var YY:Array = new Array();
		
		private var master:String;
		
		public function NewClass(master:String) 
		{
			this.master = master;
			YY.push(this)	//添加自己
		}
		
		override public function traceYY():void 
		{
			trace(NewClass(YY[5]).master); //这样也能访问到私有方法			
		}
		
	}

}