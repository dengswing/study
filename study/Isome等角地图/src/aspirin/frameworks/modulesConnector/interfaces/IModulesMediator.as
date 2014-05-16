package aspirin.frameworks.modulesConnector.interfaces
{
	public interface IModulesMediator
	{
		function registerModule( module : IModule ) : void;
		
		function removeModule( moduleName : String ) : IModule;
		
		function getModule( moduleName : String ) : IModule;
		
		function hasModule( moduleName : String ) : Boolean;
		
		function registerCommand( commandName : String, moduleName : String ) : void;
		
		function removeCommand( commandName : String, moduleName : String ) : void;
		
		function broadcastCommand( commandName : String, body : Object = null, type : String = null ) : void;
		
		function notifyModules( command : ICommand ) : void;
		
	}
}