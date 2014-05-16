/**
 * loader swf
 */
package
{	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.utils.Timer;
	
	
	/**
	 * ...
	 * @author mypet_team
	 * @version
	 */		
	public class LoaderSwf extends EventDispatcher
	{		
		private var request:URLRequest;
		private var loader:Loader;
		private var loadData:*;	//swf路径、二进字数据;
		
		public var completeFunc:Function;	//完成后执行的方法;
		private var isDispatchErr:Boolean; //是否要抛错误事件
		private var application:String;		//域
		private var lossTimer:Timer;	//丢包时间
		private const MAX_COUNT:int = 3;	//最大次数
		private var _currentCount:int;	//当前次数
		private var isLoaderFinish:Boolean;	//是否加载完成
		
		public function LoaderSwf(data:*= null)				
		{	
			this.loadData = data;			
			initLoaderSwf();
		}
		
		/**
		 * 初始化,实例化loader;
		 */
		private function initLoaderSwf():void 
		{
			if(!loader) loader = new Loader();	
			if(!request) request = new URLRequest();
			if (!lossTimer)
			{
				lossTimer = new Timer(1000, 1);
				lossTimer.addEventListener(TimerEvent.TIMER_COMPLETE, lossHandler);
			}
		}
		
		/**
		 * 丢包事件
		 * @param	e
		 */
		private function lossHandler(e:TimerEvent):void 
		{
			_currentCount += 1;
			
			if (isLoaderFinish || _currentCount > MAX_COUNT)
			{
				if (_currentCount > MAX_COUNT) throw new Error("Bigger than the number of loading!");
				lossTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, lossHandler);
				lossTimer = null;
			}else
			{
				trace("_current", _currentCount);
				loadingSwf(loadData, completeFunc, application, isDispatchErr);		
			}
		}
		
		/**
		 * 加载数据
		 * @param	data swf路径、二进字数据		
		 * @param 	completeFunc 回调函数
		 * @param	application	是否加载到域控制(current表示载入同一域中、child:表示当前域子域中、system表示系统子域中)
		 * @param	isDispatchErr	是否触发错误事件(true:表示触发、false:表示不触发)
		 */
		public function loadingSwf(data:*, completeFunc:Function = null, application:String = "child", isDispatchErr:Boolean = false):void
		{					
			if (data != "") loadData = data;				
					
			if (completeFunc != null) this.completeFunc = completeFunc;
			this.isDispatchErr = isDispatchErr;
			this.application = application;
			
			if (loadData is String)
				setLoaderSwf("load", application);
			else if (loadData is ByteArray)
				setLoaderSwf("loadBytes", application);
			else 
				throw new Error("LoaderSwf类,loadingSwf方法中的data参数只能是 string、byteArray类型!");
		}
		
		
		/**
		 * 设置加载
		 * @param	loadType 加载类型(load 加载*.swf、loadBytes加载二进字数据)
		 * @param	application	是否加载到域控制(current表示载入同一域中、child:表示当前域子域中、system表示系统子域中)
		 */
	    private function setLoaderSwf(loadType:String, application:String = "child"):void 
		{				
			initLoaderSwf();
			
			var context:LoaderContext = new LoaderContext();
			
			if (application == "current")				
				context.applicationDomain = ApplicationDomain.currentDomain;		
			else if (application == "child")				
				context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);		
			else 
				context.applicationDomain = new ApplicationDomain();
			
			if (loadType == "load")	{				
				request.url = loadData;					
				loader.load(request, context);	
			}else if (loadType == "loadBytes") {								
				loader.loadBytes(loadData, context);			   
			}  
			
			//trace("***********************application=="+application);
			configListeners(loader.contentLoaderInfo);
		}
		
		public function getCurrentApplication():ApplicationDomain
		{
			return ApplicationDomain.currentDomain;
		}
		
		/**
		 * 注册侦听
		 * @param	dispath 事件
		 */
		protected function configListeners(dispath:EventDispatcher):void 
		{			
			dispath.addEventListener(Event.COMPLETE, completeHandler);				
			dispath.addEventListener(ProgressEvent.PROGRESS, progressHandler);			
			dispath.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);	
			dispath.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorHandler);
		}
		
		/**
		 * 成功侦听
		 * @param	evt
		 */
		protected function completeHandler(evt:Event):void
		{
			if (this.completeFunc != null) this.completeFunc();			
			dispatchEvent(evt);
			isLoaderFinish = true;
			removeListeners(evt.currentTarget as EventDispatcher);
		}
		
		/**
		 * 侦听进度
		 * @param	proEvt
		 */
		protected function progressHandler(proEvt:ProgressEvent):void
		{			
			if (int(proEvt.bytesLoaded / proEvt.bytesTotal * 100) == 100 && lossTimer) 
			{
				lossTimer.reset();
				lossTimer.start();	//检测丢包
			}
			
			dispatchEvent(proEvt);	
		}
		
		/**
		 * 侦听错误
		 * @param	ioErrorEvt
		 */
		protected function ioErrorHandler(ioErrorEvt:IOErrorEvent):void
		{	
			if (isDispatchErr) dispatchEvent(ioErrorEvt);
			
			removeListeners(ioErrorEvt.currentTarget as EventDispatcher);
		}	
		
		/**
		 * 返回根显示对象(舞台)
		 */
		public function get getContent():DisplayObject
		{			
			return loader.content as DisplayObject;
		}
		
		/**
		 * 返回loader正在加载的对象相对应的 LoaderInfo 对象	
		 */
		public function get getLoaderInfo():LoaderInfo
		{
			return loader.contentLoaderInfo;
		}
		
		/**
		 * 返回loaderInfo库中的元件
		 * @param	name 库绑定名称
		 * @param	info 应用程序域
		 * @param 	isLoader	是否检测loader域
		 * @return  返回库元件类
		 */
		public function getClass(name:String, info:LoaderInfo = null, isLoader:Boolean = true):Class 		
		{			
			try 
			{ 
				if (info != null)					
					return info.applicationDomain.getDefinition(name) as Class;
				else if (loader != null)
					return loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;				
			}catch (e:ReferenceError)
			{
				try 
				{					
					return ApplicationDomain.currentDomain.getDefinition(name) as Class;				
				}catch (e:ReferenceError) {					
					trace("定义 " + name + " 不存在");
					return null;
				}
				
				return null;
			}
			
			return null;
		}	
		
		/**
		 * 返回loaderInfo库中的元件
		 * @param	name 库绑定名称
		 * @param	info 应用程序域	
		 * @return  返回库元件类
		 */
		public static function getDefinitionClass(name:String, info:LoaderInfo = null):Class
		{
			var tmpLoaderSwf:LoaderSwf = new LoaderSwf();
			return tmpLoaderSwf.getClass(name, info);
		}
		
		
		/**
		 * 绕过安全沙箱
		 * @param	path	加载路径
		 * @param	callBack	回调（返回content）
		 */
		public static function crossSecurity(path:String, callBack:Function):void
		{
			if (!path) throw new Error("error,path is null");
			
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest(path);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			loader.load(request);
			
			function completeHandler(e:Event):void 
			{
				try 
				{
					callBack(loader.content);
					errorHandler(null);
				}catch (e:SecurityError) 
				{
					loader.loadBytes(loader.contentLoaderInfo.bytes);
				}
			}
			
			function errorHandler(e:IOErrorEvent):void 
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				loader = null;
				request = null;
			}			
		}
		
		/**
		 * 移除侦听
		 * @param	dispath 事件
		 */
		protected function removeListeners(dispath:EventDispatcher):void
		{
			dispath.removeEventListener(Event.COMPLETE, completeHandler);						
			dispath.removeEventListener(ProgressEvent.PROGRESS, progressHandler);			
			dispath.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispath.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, ioErrorHandler);
		}
		
		/**
		 * 停止当前加载
		 */
		public function loaderClose():void
		{
			loader.close();
			loader = null;
			request = null;	
		}
		
		/**
		 * 移除 gc
		 */
		public function gc():void
		{	
			try
			{
				if (getContent is MovieClip)
				   (getContent as MovieClip).stop();				   
			}catch (err:Error) { };
			
			try 
			{
				loader.unloadAndStop(true);
				loader.unload();
			}catch (err:Error) { };
			
			loader = null;
			request = null;			
		}	
		
	}	
}
