package  
{
	/**
	 * ...
	 * @author dengSwing
	 */
	public class Song extends AbstractTest
	{
		private var YY:Array = new Array();
		
		private var master:String;
		
		public function Song(master:String) 
		{
			this.master = master;
			
		}
		
		override public function traceYY():void 
		{
			trace("===>"+master,YY.length);
			for each(var i:AbstractTest in YY) {				
				i.traceYY();
			}		
		}
		
		override public function addItem(value:AbstractTest):void 
		{
			YY.push(value);
		}
		
	}

}