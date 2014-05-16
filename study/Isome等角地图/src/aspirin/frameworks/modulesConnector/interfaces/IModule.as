package aspirin.frameworks.modulesConnector.interfaces
{
	public interface IModule
	{
		function execute( command : ICommand ) : void;
			
		function broadcast( commandName : String, body : Object = null, type : String = null) : void;
		
		function registerCommand( commandName : String ) : void;
		
		function removeCommand( commandName : String ) : void;
		
		function notify( command : ICommand ) : void;
		
		function get moduleName() : String;
		
		function onRegister() : void;
		
		function onRemove() : void;
	}
}