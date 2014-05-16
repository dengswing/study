package aspirin.frameworks.modulesConnector.interfaces
{
	public interface ICommand
	{
		function get name() : String;
			
		function get body() : Object;
			
		function get type() : String;

	}
}