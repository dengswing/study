package aspirin.frameworks.modulesConnector.core
{
	import aspirin.frameworks.modulesConnector.interfaces.ICommand;
	import aspirin.frameworks.modulesConnector.interfaces.IModule;
	import aspirin.frameworks.modulesConnector.interfaces.IModulesMediator;
	
	public class Module implements IModule
	{
		/**
		 * @private <code>IModulesMediator</code>实例的局部引用
		 */	
		protected var mediator : IModulesMediator =  ModulesMediator.getInstance();
		
		/**
		 * @private <code>Module</code>实例的名称
		 */	
		protected var _moduleName : String;
		
		/**
		 * 构造方法 
		 * @param moduleName <code>Module</code>实例的名称
		 * 
		 */		
		public function Module( moduleName : String )
		{
			_moduleName = moduleName;
		}
		
		/**
		 * 执行指定的<code>ICommand</code>实例
		 * @param command 将被执行的<code>ICommand</code>实例
		 * 
		 */		
		public function execute( command : ICommand ) : void
		{
			
		}
		
		/**
		 * 为该<code>IModule</code>实例注册一个<code>ICommand</code> 
		 * @param commandName <code>ICommand</code>的名称
		 * 
		 */		
		public function registerCommand( commandName : String ) : void
		{
			mediator.registerCommand( commandName, this.moduleName );
		}
		
		/**
		 * 移除指定的<code>ICommand</code> 
		 * @param commandName <code>ICommand</code>的名称
		 * 
		 */		
		public function removeCommand( commandName : String ) : void
		{
			mediator.removeCommand( commandName, moduleName );
		}
		
		/**
		 * 创造一个<code>ICommand</code>实例并广播
		 * @param commandName <code>ICommand</code>实例的名称
		 * @param body <code>ICommand</code>实例的内容
		 * @param type <code>ICommand</code>实例的类型
		 * 
		 */		
		public function broadcast( commandName : String, body : Object = null, type : String = null ) : void
		{
			mediator.broadcastCommand( commandName, body, type );
		}
		
		/**
		 * 广播指定的<code>ICommand</code>实例
		 * @param command 将被广播的<code>ICommand</code>实例
		 * 
		 */		
		public function notify( command : ICommand ) : void
		{
			mediator.notifyModules( command );
		}
		
		/**
		 * 返回<code>Module</code>实例的名称
		 * @return <code>Module</code>实例的名称
		 * 
		 */		
		public function get moduleName() : String
		{
			return _moduleName;
		}
		
		/**
		 * 当<code>Module</code>实例在<code>IModuesMediator</code>实例中被注册时，该方法将被调用
		 * 
		 */		
		public function onRegister() : void
		{
			
		}
		
		/**
		 * 当<code>Module</code>实例在<code>IModuesMediator</code>实例中被移除时，该方法将被调用
		 * 
		 */
		public function onRemove() : void
		{
			
		}
	}
}