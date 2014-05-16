package c
{
	import org.puremvc.as3.core.View;
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand
	{
		public function StartupCommand()
		{
		}
		
		override protected function initializeMacroCommand():void
		{
			addSubCommand(ModelPrepCommand);
			addSubCommand(ViewRrepCommand);
		}
	}
}