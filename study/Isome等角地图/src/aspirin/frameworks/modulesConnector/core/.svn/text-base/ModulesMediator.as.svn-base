package aspirin.frameworks.modulesConnector.core
{
	import aspirin.frameworks.modulesConnector.interfaces.ICommand;
	import aspirin.frameworks.modulesConnector.interfaces.IModule;
	import aspirin.frameworks.modulesConnector.interfaces.IModulesMediator;
	
	import flash.utils.Dictionary;
	
	public class ModulesMediator implements IModulesMediator
	{
		/**
		 * @private 单例失败后返回消息
		 */
		protected const SINGLETON_MSG : String = "Mediator Singleton already constructed!";
		
		/**
		 * @private 单例对象
		 */
		protected static var instance : IModulesMediator;
		
		/**
		 *  @private 注册的<code>IModule</code>实例集合
		 */		
		protected var modulesMap : Dictionary;
		
		/**
		 *  @private 注册的<code>ICommand</code>集合
		 */
		protected var commandsMap : Dictionary;
		
		public function ModulesMediator()
		{
			if ( instance != null ) throw Error(SINGLETON_MSG);
			instance = this;
			
			initializeMediator();	
			
		}
		
		protected function initializeMediator() : void
		{
			modulesMap = new Dictionary();
			
			commandsMap = new Dictionary();
		}
		
		/**
		 * 注册指定的<code>IModule</code>实例
		 * @param module 将被注册的<code>IModule</code>实例
		 * 
		 */		
		public function registerModule( module : IModule ) : void
		{
			modulesMap[ module.moduleName ] = module;
			module.onRegister();
		}
		
		/**
		 * 注销指定的<code>IModule</code>实例
		 * @param module 将被注销的<code>IModule</code>实例的名字
		 * @return 返回被注销的<code>IModule</code>实例
		 */	
		public function removeModule( moduleName : String ) : IModule
		{
			var module : IModule = modulesMap[ moduleName ] as IModule;
			if( module )
			{
				delete modulesMap[ moduleName ];
				module.onRemove();
			}
			return module;
		}
		
		/**
		 * 根据指定的名字返回<code>IModule</code>实例
		 * @param moduleName <code>IModule</code>实例的名字
		 * @return <code>IModule</code>实例，若没有则返回<code>null</null>
		 * 
		 */		
		public function getModule( moduleName : String ) : IModule
		{
			var module : IModule = modulesMap[ moduleName ] as IModule;
			if( module )
			{
				return module;
			}
			
			return null;
		}
		
		/**
		 * 检测集合中中是否具有该名字的<code>IModule</code>实例
		 * @param moduleName <code>IModule</code>实例的名字
		 * @return 有则返回<code>true</null>,没有返为<code>false</null>
		 * 
		 */		
		public function hasModule( moduleName : String ) : Boolean
		{
			var module : IModule = modulesMap[ moduleName ] as IModule;
			if( module )
			{
				return true;
			}
			
			return false;
		}
		
		/**
		 * 为该<code>IModule</code>实例注册一个<code>ICommand</code> 
		 * @param commandName <code>ICommand</code>的名称
		 * @param moduleName <code>IModule</code>实例的名称
		 * 
		 */		
		public function registerCommand( commandName : String, moduleName : String ) : void
		{
			if( !commandsMap[ commandName ] ){
				commandsMap[ commandName ] = new Array();
			}
			
			var refArray : Array = commandsMap[ commandName ] as Array;
			refArray.push( moduleName );
		}
		
		/**
		 * 注销指定的<code>ICommand</code> 
		 * @param commandName <code>ICommand</code>的名称
		 * 
		 */	
		public function removeCommand( commandName : String, moduleName : String ) : void
		{
			var refArray : Array = commandsMap[ commandName ] as Array;
			var module : IModule = modulesMap[ moduleName ] as IModule;
			
            if( refArray && module ){
				for( var i : int = 0; i < refArray.length; i++ )
				{
					if( IModule( modulesMap[refArray[i]] ) === module )
					{
						refArray.splice(i, 1);
						break;
					}
				}

				commandsMap[ commandName ] = refArray;
			}

			if( refArray.length == 0 ){
				delete commandsMap[ commandName ];
			}
		}
		
		/**
		 * 创造一个<code>ICommand</code>实例并广播
		 * @param commandName <code>ICommand</code>实例的名称
		 * @param body <code>ICommand</code>实例的内容
		 * @param type <code>ICommand</code>实例的类型
		 * 
		 */	
		public function broadcastCommand( commandName : String, body : Object = null, type : String = null ) : void
		{
			notifyModules( new Command( commandName, body, type ) );
		}
		
		/**
		 * 广播指定的<code>ICommand</code>实例
		 * @param command 将被广播的<code>ICommand</code>实例
		 * 
		 */	
		public function notifyModules( command : ICommand ) : void
		{
			if( !commandsMap[ command.name ] ) return;
			
			var refArray : Array = commandsMap[ command.name ] as Array;
			
			var modules : Array = new Array();
			var module : IModule;
			
			for( var i : Number = 0; i < refArray.length; i++ )
			{ 
				module = modulesMap[ refArray[ i ] ] as IModule;
				if(module) modules.push( module );
			}
			
			for( i = 0; i < modules.length; i++ ) {
				module = modules[ i ] as IModule;
				module.execute( command );
			}

		}
		
		public static function getInstance() : IModulesMediator
		{
			if (instance == null) instance = new ModulesMediator();
			return instance;
		}
	}
}