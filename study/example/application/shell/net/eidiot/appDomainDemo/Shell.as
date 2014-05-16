package net.eidiot.appDomainDemo
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import net.eidiot.appDomainDemo.ui.LoadingUi;
	import net.eidiot.net.LoadEvent;
	import net.eidiot.net.SWFLoader;
	/**
	 * 主程序
	 * 
	 * @author	eidiot (http://eidiot.net)
	 * @date	070601
	 * @version	1.0.070601
	 */	
	public class Shell extends Sprite
	{
		private var m_libList : Array;
		private var m_moduleList : Array;
		private var m_loader : SWFLoader;
		private var m_loading : LoadingUi;
		private var m_isLoading : Boolean = false;
		private var m_userName : String;
		/**
		 * 构造函数
		 */		
		public function Shell()
		{
			this.init();
		}
		
		private function init() : void
		{
			this.m_libList = ["lib.swf"];
			this.m_moduleList = ["login.swf", "result.swf"];
			this.m_loader = new SWFLoader();
			this.m_loading = new LoadingUi(this);
			this.loadSwf();
		}
		
		private function loadSwf() : void
		{
			if (this.m_moduleList.length == 0) return;
			var url : String;
			var target : String;
			if (this.m_libList.length > 0)
			{
				url = this.m_libList[0];
				target = SWFLoader.TARGET_SAME;
			} else
			{
				url = this.m_moduleList[0];
				target = SWFLoader.TARGET_CHILD;
			}
			if (!this.m_isLoading) 
			{
				this.addChild(this.m_loading);
				this.initLoadEvent();
				this.m_isLoading = true;
			}
			this.m_loader.load(url, target);
			this.m_loading.setTarget(url);
		}
		
		private function initLoadEvent() : void
		{
			this.m_loader.addEventListener(LoadEvent.COMPLETE, this.onComplete);
			this.m_loader.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
			this.m_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this.m_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
		}
		private function showModule(p_module : IModule) : void
		{
			if (this.m_moduleList[0] == "login.swf")
			{
				p_module.show(this);
				p_module.addEventListener("login", this.onLogin);
			} else
			{
				p_module.show(this, this.m_userName);
			}
		}
		private function removeLoadEvent() : void
		{
			this.m_loader.removeEventListener(LoadEvent.COMPLETE, this.onComplete);
			this.m_loader.removeEventListener(ProgressEvent.PROGRESS, this.onProgress);
			this.m_loader.removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
			this.m_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
		}
		private function onComplete(p_e : LoadEvent) : void
		{
			if (this.m_libList.length > 0)
			{
				this.m_libList.shift();
				this.loadSwf();
			} else
			{
				this.removeLoadEvent();
				if (this.m_isLoading)
				{
					this.removeChild(this.m_loading);
					this.m_isLoading = false;
				}
				this.showModule(p_e.loaderInfo.content as IModule);
				this.m_moduleList.shift();
			}
		}
		private function onProgress(p_e : ProgressEvent) : void
		{
			this.m_loading.update(p_e.bytesLoaded, p_e.bytesTotal);
		}
		private function onError(p_e : Event) : void
		{
			var s : String = this.m_libList.length > 0 ? this.m_libList[0] : this.m_moduleList[0];
			trace("加载" + s + "失败");
		}
		private function onLogin(p_e : Object) : void
		{
			this.m_userName = p_e.userName;
			var login : IModule = p_e.currentTarget;
			login.removeEventListener("login", this.onLogin);
			login.dispose();
			this.loadSwf();
		}
	}
}