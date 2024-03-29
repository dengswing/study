﻿package com.FSC.UI.InterActiveObject.DisplayObjectContainer.LoadLine
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.events.*;

	/**下载队列类 单例
	 * @ panyong
	 * @ v1.080506
	 */
	public class LoadLine extends MovieClip
	{
		private static var loadLine:LoadLine;
		private static var key:Boolean=false;
		private var _loader:Loader= new Loader();
		private var _loaderList:Array = new Array();
		private var _timer:Timer = new Timer(500);
		
		private var _isNowLoading:Boolean=false;
		//加载失败尝试次数
		private var _tryErrorTime:Number=1;
		//当前加载失败次数
		private var _tryErrorNowTime:Number = 0;

		public function LoadLine()
		{
			if( !key ){
	            throw new Error ("单例,请用 getInstance() 取实例。");
	        }
	        key=false;
	        _timer.addEventListener(TimerEvent.TIMER,everySed); 
	        _timer.start();
	        _loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
	    	_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
	   		_loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);       
	   		_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
		}
		
		public static function getInstance() : LoadLine {
            if ( loadLine == null ){
            	 key=true;
                loadLine = new LoadLine();
            }
            return loadLine;
        }
        
        /**静态函数 下载命令
        * @param target下载地址
        */
        public function loadFile(target:URLRequest,emergent:Number=10){
        	if(emergent==0){
        		_loaderList.unshift(target);
        		if(_isNowLoading){
        			//如果有正在加载的项目则 暂停
        			cancelNowLoad();
        		}
        	}else{
				_loaderList.push(target);
        	}
        }
        /**终止当前下载
        */
        private  function cancelNowLoad(){
        	_loader.close();
        }
        /**每秒监听 队列是否有下载
        * @param e 时间参数
        */
        private function everySed(e:TimerEvent){
        	//但下载器空闲时
        	if((!_isNowLoading)&&(_loaderList.length>0)){
        		var tmp_url:URLRequest = _loaderList[0] as URLRequest;     		
        		_loader.load(tmp_url);
        		this.addChild(_loader);
        		_isNowLoading = true;
        	}
        }
        /**当前下载中的侦听
        */
        private function progressHandler(e:ProgressEvent){
        	this.dispatchEvent(new LoadLineProgressEvent(ProgressEvent.PROGRESS,_loaderList[0],false,false,e.bytesLoaded,e.bytesTotal));
        }
        /**当前下载完成
        */
        private function onCompleteHandler(e:Event){
        	this.dispatchEvent(new LoadLineEvent(LoadLineEvent.ONLOADLINECOMPLETE,_loaderList[0],_loader.content));
        	_loaderList.shift();//当完成下载后再从队列中删除
        	_isNowLoading = false;
        }
        /**当加载错误进行尝试处理
        */
        private function onError(e:IOErrorEvent){
        	_isNowLoading = false;
        	if(_tryErrorNowTime>_tryErrorTime){
	        	trace("error:下载队列中有文件加载失败,并且超过尝试次数。已从队列中删除")
	        	this.dispatchEvent(new LoadLineEvent(LoadLineEvent.ONLOADLINECOMPLETE, _loaderList[0], "", false));
	        	_tryErrorNowTime=0;
	        	//当完成下载后再从队列中删除
	        	_loaderList.shift();
        	}else{
        		_tryErrorNowTime++;
        	}
        }		
	}
}