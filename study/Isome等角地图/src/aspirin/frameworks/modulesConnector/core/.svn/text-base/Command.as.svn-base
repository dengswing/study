package aspirin.frameworks.modulesConnector.core
{
	import aspirin.frameworks.modulesConnector.interfaces.ICommand;
	
	public class Command implements ICommand
	{
		/**
		 * @private  <code>Command</code>实例的名称
		 */		
		private var _name : String;
		
		/**
		 * @private  <code>Command</code>实例的内容
		 */	
		private var _body : Object;
		
		/**
		 * @private  <code>Command</code>实例的类型
		 */	
		private var _type : String;
		
		/**
		 * <code>Command</code>是用于模块之间相互传递消息的载体
		 * @param name 命令的名称(required)
		 * @param body 内容(optional)
		 * @param type 类型(optional)
		 * 
		 */		
		public function Command( name : String, body : Object=null, type : String=null ) : void
		{
			_name = name;
			_body = body;
			_type = type;
		}
		
		/**
		 * 获取<code>Command</code>实例的名称 
		 * @return 返回<code>Command</code>实例的名称
		 * 
		 */		
		public function get name() : String
		{
			return _name;
		}
		
		/**
		 * 设置<code>Command</code>实例的内容 
		 * @param body <code>Command</code>实例的内容
		 * 
		 */		
		public function set body( body:Object ) : void
		{
			_body = body;
		}
		
		/**
		 * 获取<code>Command</code>实例的内容
		 * @return <code>Command</code>实例的内容
		 * 
		 */		
		public function get body():Object
		{
			return _body;
		}
		
		/**
		 * 设置<code>Command</code>实例的类型
		 * @param type <code>Command</code>实例的类型
		 * 
		 */		
		public function set type( type:String ) : void
		{
			_type = type;
		}
		
		/**
		 * 返回<code>Command</code>实例的类型
		 * @return <code>Command</code>实例的类型
		 * 
		 */		
		public function get type() : String
		{
			return _type;
		}
		
		/**
		 * 返回<code>Command</code>实例的字符串表达形势
		 * @return <code>Command</code>实例的字符串表达形势
		 * 
		 */		
		public function toString() : String
		{
			var msg:String = "Command Name: " + _name;
			msg += "\nBody:"+( ( _body == null ) ? "null" : _body.toString() );
			msg += "\nType:"+( ( _type == null ) ? "null" : _type );
			return msg;
		}
	}
}