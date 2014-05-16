package command 
{
	import peddler.Peddler;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class AppleCommand extends AbstractCommand
	{
		
		/**
		 * 苹果的命令
		 * @param	value
		 */
		public function AppleCommand(value:Peddler) 
		{
			super(value);
		}
		
		override public function sale():void 
		{
			uPeddler.saleApple();
		}
	}

}