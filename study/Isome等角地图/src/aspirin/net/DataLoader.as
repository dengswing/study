package aspirin.net {
	import flash.system.Security;	
	import flash.events.SecurityErrorEvent;	

	import aspirin.events.LoaderErrorEvent;	

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	public class DataLoader extends URLLoader {
		
		private var _request : URLRequest;
		
		private var _variables : URLVariables;
		
		private var _timeOut : uint = 5000;
		
		private var _noCatch : Boolean = false;
		
		private var _escape : Boolean = true;
		
		private var _post : Boolean = false;

		private var timer : Timer;

		private var isLoading : Boolean = false;
		
		public function DataLoader() {
			super();
		}

		public function loadData( url : String, variables : Object = null) : void {
			if( url != null) {
				_request = new URLRequest(url);
				
			}else {
				throw( new Error("URL should not be null") );	 
			}
		   
			_variables = new URLVariables();
		   
			for( var str : String in variables ) {
				if(typeof(variables[str]) != "object" && variables[str] != null) {
					_variables[str] = variables[str];
				}else {
					throw( new Error("Something wrong in the paramters") );	   		
				}
			}
		   
			if( noCatch ) {
				_variables["noCatch"] = getTimer();
			}
		   
			if( escape ) {
				_request.data = _variables;
			}else {
				_request.data = unescape(_variables.toString());
			}
		   
			_request.method = post ? URLRequestMethod.POST : URLRequestMethod.GET;
			
			
			if( checkCrossdomain ) {
				var reg : RegExp = /^(http:\/\/)?([^\/]+)/i;
				var crossDomainURL : String = String(url.match(reg)[0]).concat("/crossdomain.xml");
				Security.loadPolicyFile(crossDomainURL);
			}
			try {
				this.addEventListener(IOErrorEvent.IO_ERROR, onError, false, 1);
				this.addEventListener(Event.COMPLETE, onLoad, false, 1);
				this.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 1);
				//
				this.load(_request);
				isLoading = true;
			}catch(e : Error) {
				dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.SECURITY_ERROR));
				return;
			}
		   
			_timeOut = timeOut;
		   		   
			timer = new Timer(_timeOut, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeOut);
			timer.start();
		}

		protected function onError( evt : IOErrorEvent ) : void {
			timer.stop();
			isLoading = false;
			dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.IO_ERROR));
		}

		protected function onSecurityError( evt : SecurityErrorEvent ) : void {
			timer.stop();
			isLoading = false;
			dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.SECURITY_ERROR));
		}

		protected function onLoad( evt : Event ) : void {
			isLoading = false;
			timer.stop();
		}

		protected function onTimeOut( evt : TimerEvent ) : void {
			isLoading = false;
			dispatchEvent(new LoaderErrorEvent(LoaderErrorEvent.TIME_OUT));
		}

		
		public function getRequestString() : String {
			return _request.url + "?" + _request.data.toString();
		}

		public function get request() : URLRequest {
			return _request;
		}

		public function get loading() : Boolean {
			return isLoading;
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
		
		public function get timeOut() : uint {
			return _timeOut;
		}
		
		public function set timeOut(timeOut : uint) : void {
			_timeOut = timeOut;
		}
		
		public function get noCatch() : Boolean {
			return _noCatch;
		}
		
		public function set noCatch(noCatch : Boolean) : void {
			_noCatch = noCatch;
		}
		
		public function get escape() : Boolean {
			return _escape;
		}
		
		public function set escape(escape : Boolean) : void {
			_escape = escape;
		}
		
		public function get post() : Boolean {
			return _post;
		}
		
		public function set post(post : Boolean) : void {
			_post = post;
		}
	}
}