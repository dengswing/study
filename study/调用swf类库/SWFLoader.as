/*
 * SWF加载
 */
package
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	/**
	 * SWF加载器
	 */
	public class SWFLoader extends EventDispatcher
	{
		private var m_loadinfo:LoaderInfo;
		
		public function get loadinfo():LoaderInfo
		{
			return m_loadinfo
		}
		
		public function SWFLoader() {}
		/**
			 加载SWF
		 */
		public function Load(url:String):void 
		{
			var loader:Loader         = new Loader();
			var context:LoaderContext = new LoaderContext();
			
			/** 加载到子域 */
			context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			
			InitLoadEvent(loader.contentLoaderInfo);
			loader.load(new URLRequest(url),context);
		}
		
		/**
		 * 获取当前ApplicationDomain内的类定义
		 * 
		 * name类名称，必须包含完整的命名空间,如 Grave.Function.SWFLoader
		 * info加载swf的LoadInfo，不指定则从当前域获取
		 * return获取的类定义，如果不存在返回null
		 */
		public function GetClass(name:String, info:LoaderInfo = null):Class 
		{
			try 
			{
				if (info == null) 
				{
					return ApplicationDomain.currentDomain.getDefinition(name) as Class;
				}
				return info.applicationDomain.getDefinition(name) as Class;
			} 
			catch (e:ReferenceError) 
			{
				//trace("定义 " + name + " 不存在");
				return null;
			}
			return null;
		}
		
		/**
		 * @private
		 * 监听加载事件
		 * 
		 * @param info加载对象的LoaderInfo
		 */
		private function InitLoadEvent(info : LoaderInfo):void 
		{
			info.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			info.addEventListener(Event.COMPLETE, this.onComplete);
			info.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			info.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
		}
		
		/**
		 * @private
		 * 移除加载事件
		 * 
		 * @param inft加载对象的LoaderInfo
		 */
		private function RemoveLoadEvent(info:LoaderInfo):void 
		{
			info.removeEventListener(Event.COMPLETE,onComplete);
			info.removeEventListener(ProgressEvent.PROGRESS,onProgress);
			info.removeEventListener(IOErrorEvent.IO_ERROR,onError);
			info.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
		}
		
		/** 加载事件 */
		private function onComplete(e:Event):void 
		{
			var info:LoaderInfo = e.currentTarget as LoaderInfo;
			RemoveLoadEvent(info);
			m_loadinfo = info;
			this.dispatchEvent(e);
		}
		
		/** 加载中 */
		private function onProgress(e:ProgressEvent):void 
		{
			this.dispatchEvent(e);
		}
		
		/** 出错事件 */
		private function onError(e:Event):void 
		{
			this.dispatchEvent(e);
		}
	}
}