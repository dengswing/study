package util
{
	
	import flash.events.*;
	import flash.net.*;
	
	public class QuizLib extends EventDispatcher
	{
		private var _xmlUrl:String;
		private var _config:Array;
		
		private var _loader:URLLoader;
		private var _request:URLRequest;
		
		private var _q:Array;
		private var _libLength:int;
		private var _quizNeeded:int;
		private var _shuffleArr:Array;
		private var _currentQuiz:int;
		private var _needShuffle:Boolean;
		
		public function QuizLib()
		{
			_libLength = 0;
		}
		
		private function logger(msg:String, level:String = "DEBUG"):void
		{
			
			//logger(msg, level);
			trace(msg,level);
			
		}
		
		public function load(xmlUrl:String, count:int, needShuffle:Boolean = true):void
		{
			_quizNeeded = count;
			_needShuffle = needShuffle;
			_xmlUrl = xmlUrl;
			
			var _head:URLRequestHeader = new URLRequestHeader('Content-Referer','http://ifengfeng.com');
			var _post:URLVariables = new URLVariables();
			_post.user = 'ifengfeng';
			_request = new URLRequest(xmlUrl);
			_request.data = _post;
			_request.method = URLRequestMethod.POST;
			_request.requestHeaders.push(_head);
			try
			{
				_loader = new URLLoader();
				_loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
		        _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		        _loader.addEventListener(ProgressEvent.PROGRESS, xmlProgress);
				_loader.addEventListener(Event.COMPLETE,xmlLoaded);
				_loader.load(_request);

			}catch (error:Error)
			{
				logger("[QuizLib] Can not open xml file: " + xmlUrl, "ERROR");
				var outEvt:GameEvent = new GameEvent(GameEvent.XMLLOADFAIL);
				dispatchEvent(outEvt);
			}

		}
		
		private function onError(evt:Event):void
		{
			logger("[QuizLib] Error when open xml file " + _xmlUrl + ". Event = "+ evt, "ERROR");
			var outEvt:GameEvent = new GameEvent(GameEvent.XMLLOADFAIL);
			dispatchEvent(outEvt);
		}
		
		private function xmlProgress(evt:ProgressEvent):void
		{
			var outEvt:GameEvent;
			outEvt = new GameEvent(GameEvent.XMLPROGRESS,evt);
			dispatchEvent(outEvt);
		}
		
		private function xmlLoaded(evt:Event):void
		{
			var lib:XML;
			var outEvt:GameEvent;
			try
			{
				lib=new XML(evt.target.data);
				_loader = null;
			}
			catch (err:Error)
			{
				logger("[QuizLib] xml file " + _xmlUrl + "loading error" + err, "ERROR");
				outEvt = new GameEvent(GameEvent.XMLLOADFAIL);
				dispatchEvent(outEvt);
				return;
			}

			_config = new Array;
			
			// save config
			for each  (var a:XML in lib.config.children())
			{
				_config[a.name()] = a.text();
			}
			
			// save quiz
			var sourceQuiz:Array = new Array();
			for each  (var q:XML in lib.questions.children())
			{
				sourceQuiz[_libLength] = q;
				_libLength ++;
			}
			/* by shikar on 2008-05-18
			if (_libLength <= 0)
			{
				sourceQuiz = null;
				logger("[QuizLib] lib file " + _xmlUrl + " is empty", "ERROR");
				outEvt = new GameEvent(GameEvent.XMLLOADFAIL);
				dispatchEvent(outEvt);
				return;
			}
			*/
			
			if (_libLength < _quizNeeded)
			{
				sourceQuiz = null;
				logger("[QuizLib] xml error: need more quiz in lib. File:" + _xmlUrl, "ERROR");
				outEvt = new GameEvent(GameEvent.XMLLOADFAIL);
				dispatchEvent(outEvt);
				return;
			}
			
			_q = new Array();
			var i:int;
			
			if (_quizNeeded == 0)
			{
				_quizNeeded = _libLength;
			}
			
			if (_needShuffle)
			{
				var randomNumber:int;
				for (i=0; i < _quizNeeded; i++) 
				{
					do
					{
						randomNumber = RandomNumber.gen(0, _libLength - 1);
					}while (sourceQuiz[randomNumber] == null);
				
					_q[i] = sourceQuiz[randomNumber];
					sourceQuiz[randomNumber] = null;
				}
			}
			else
			{
				for (i=0; i < _quizNeeded; i++)
				{
					_q[i] = sourceQuiz[i];
				}
			}
			
			sourceQuiz = null;
			_currentQuiz = 0;

			outEvt = new GameEvent(GameEvent.XMLLOADED);
			dispatchEvent(outEvt);
		}
		
		public function get config():Array
		{
			return _config;
		}
		
		public function get q():Array
		{
			return _q;
		}
		
		public function get(i:int):XML
		{
			var x:XML = null;
			if (i < _quizNeeded)
			{
				return _q[i];
			}
			else
			{
				return null;
			}
		}
		
		public function get length():int
		{
			return _quizNeeded;
		}
		
	}
}