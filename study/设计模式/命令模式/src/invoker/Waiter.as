package invoker 
{
	import command.AbstractCommand;
	/**
	 * ...
	 * @author dengsw
	 */
	public class Waiter 
	{
		private var vCommand:Vector.<AbstractCommand>;
		
		/**
		 * 服务命令
		 */
		public function Waiter() 
		{
			vCommand = new Vector.<AbstractCommand>();
		}
		
		public function addOrder(value:AbstractCommand):void
		{
			if (vCommand.indexOf(value) == -1) vCommand.push(value);
		}
		
		public function removeOrder(value:AbstractCommand):void
		{
			var index:int = vCommand.indexOf(value);
			if (index != -1) vCommand.splice(index, 1);
		}
		
		public function sale():void
		{
			for (var i:* in vCommand)
			{
				vCommand[i].sale();
			}
		}
	}

}