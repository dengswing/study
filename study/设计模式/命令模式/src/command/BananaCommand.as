package command 
{
	import peddler.Peddler;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class BananaCommand extends AbstractCommand
	{
		
		/**
		 * 香蕉命令
		 */
		public function BananaCommand(value:Peddler) 
		{
			super(value);
		}
		
		override public function sale():void 
		{
			uPeddler.saleBanana();
		}
	}

}