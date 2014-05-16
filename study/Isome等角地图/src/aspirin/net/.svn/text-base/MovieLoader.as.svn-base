package aspirin.net {
	import flash.system.Security;	
	
	import aspirin.events.LoaderErrorEvent;	
	
	import flash.system.LoaderContext;
	
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	//import flash.system.LoaderContext;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class MovieLoader extends Loader
	{
		private var _url : String;
		private var _variables : URLVariables;
		private var _request : URLRequest;
		
		private var _timeOut : uint;
		private var timer : Timer;
		
		private var timeStamp : uint = 0;
		
		private var isLoading : Boolean;
		
		public function MovieLoader()
		{
			super();
		}

		public function loadMovie( url : String, variables : Object = null, timeOut : uint = 5000, noCatch : Boolean = false, escape : Boolean = true, context : LoaderContext = null ) : void {
			_url = url;
			if( url != null) {
				_request = new URLRequest(url);
			}else {
				throw( new Error("URL should not be null") );	 
			}
			//
			if( url != null) {
				_request = new URLRequest(url);
			}else {
				throw( new Error("URL should not be null") );	 
			}
		   
			if( variables != null ) {
				_variables = new URLVariables();
		   
				for( var str : String in variables ) {
					if(typeof(variables[str]) != "object" && variables[str] != null) {
						_variables[str] = variables[str];
					}else {
						throw( new Error("Something wrong in the paramters") );	   		
					}
				}
			}
			
			if( noCatch ) {
				_variables["noCatch"] = getTimer();
			}
		   
			if( _variables != null ) {
				if( escape ) {
					_request.data = _variables;
				}else {
					_request.data = unescape(_variables.toString());
				}
			}
		   
			if( checkCrossdomain ) {
				var reg : RegExp = /^(http:\/\/)?([^\/]+)/i;
				var crossDomainURL : String = String(url.match(reg)[0]).concat("/crossdomain.xml");
				Security.loadPolicyFile(crossDomainURL);
			}
			
			try {
				this.load(_request, context);
				configureListeners();
				//
				isLoading = true;
				timeStamp = getTimer();
			}catch(e : Error) {
				trace("Security error fired, when loading - " + _request.url);
				dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.SECURITY_ERROR));
				return;
			}
			
			_timeOut = timeOut;
			if( timer != null ) {
				timer.stop();
				timer = null;
			}  
			timer = new Timer(_timeOut, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeOut);
			timer.start();
		}

		public function getClassInstance(className:String) : Object {
        try {
            var theClass : Class = this.contentLoaderInfo.applicationDomain.getDefinition(className)  as  Class;
            return new theClass();
        } catch (e:Error) {
            throw new IllegalOperationError(className + " definition not found in " + _request.url);
        }
        return null;
        }
        
        public function getContentType() : String 
        {
        	try{
        	    return this.contentLoaderInfo.contentType;
        	}catch( e : Error ){
        		trace("Error: can't find out the content type: " + e);
        		return null;
        	}
        	
        	return null;
        }
        
        public function getRequestString() : String
		{
			return _request.data==null?_request.url:(_request.url + "?" + _request.data.toString());
		}
		
		public function get request() : URLRequest
		{
			return _request;
		}
		
		public function get loading() : Boolean
		{
			return isLoading;
		}
		
		private function configureListeners():void {
			this.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
		    this.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
            this.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            this.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            this.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
            this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            this.contentLoaderInfo.addEventListener(Event.OPEN, openHandler);
            this.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            this.contentLoaderInfo.addEventListener(Event.UNLOAD, unLoadHandler);
        }
        
        private function removeListeners():void {
			this.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
		    this.contentLoaderInfo.removeEventListener( Event.COMPLETE, completeHandler );
            this.contentLoaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
            this.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            this.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
            this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            this.contentLoaderInfo.removeEventListener(Event.OPEN, openHandler);
            this.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
            this.contentLoaderInfo.removeEventListener(Event.UNLOAD, unLoadHandler);
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            //trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            //trace("initHandler: " + event);
        }

        private function openHandler(event:Event):void {
            //trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            //trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
        }

        private function unLoadHandler(event:Event):void {
           // trace("unLoadHandler: " + event);
        }

        private function ioErrorHandler( event:IOErrorEvent ):void {
        	//trace("ioErrorHandler: " + event);
        	isLoading = false;
        	timer.stop();
        	removeListeners();
            dispatchEvent( new LoaderErrorEvent( LoaderErrorEvent.IO_ERROR ) );
        }
        
        private function completeHandler( event : Event ):void {
        	//trace("completeHandler: " + event + "---" + this.getRequestString() + "---" + "Loading Total Time: " + uint((getTimer() - timeStamp)/1000) + " seconds.");
            finishLoading();
			dispatchEvent( new Event( Event.COMPLETE ) );
        }
        
        private function onTimeOut( event : TimerEvent ):void {
        	finishLoading();
            dispatchEvent( new LoaderErrorEvent( LoaderErrorEvent.TIME_OUT ) );
        }
        
        private function finishLoading() : void
        {
        	isLoading = false;
        	timer.stop();
        	removeListeners();
        }
        
        private var checkCrossdomain : Boolean = false;
		public function set checkRootPolicyFile( c : Boolean ) : void
		{
			checkCrossdomain = c;
		}
		
		public function get checkRootPolicyFile( ) : Boolean
		{
			return checkCrossdomain;
		}

	}
}