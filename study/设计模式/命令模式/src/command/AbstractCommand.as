package command 
{
	import peddler.Peddler;
	/**
	 * ...
	 * @author dengsw
	 */
	public class AbstractCommand 
	{
		private var _uPeddler:Peddler;
		
		/**
		 * 命令
		 * @param	value
		 */
		public function AbstractCommand(value:Peddler)
		{
			_uPeddler = value;
		}
		
		public function get uPeddler():Peddler 
		{
			return _uPeddler;
		}
		
		public function set uPeddler(value:Peddler):void 
		{
			_uPeddler = value;
		}
		
		public function sale():void { };
	}

}