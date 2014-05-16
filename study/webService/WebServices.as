package {
	import flash.net.*;
	import flash.events.*;

	public class WebServices extends EventDispatcher{
	   private var wsUrl:String;
	   private var xmlns:String;
	   private var methods:Object;
	  
	   private var mathodArray:Array;
	   private var analyseCompleteFlag:Boolean;
	  
	   public function WebServices(url:String){
			wsUrl = url;
			methods = {};
		   
			mathodArray = [];//方法数组及参数规则,用于在分析完服务之前保存调用方法，待分析完后再执行，避免调用不成功
			analyseCompleteFlag = false;//分析服务完成标记
			analyseService();//分析服务
	   }
	  
	   public function load(methodName:String, ...args):void{
			if(!analyseCompleteFlag){
				mathodArray.push( {methodName:methodName, args:args} );
			}else{
				 if(methods[methodName] != null){
					  var ws = new loadWSMethod();
					  ws.addEventListener("callComplete", callCompleteHandler);
					  ws.addEventListener("callError", callErrorHandler);
					 
					  var strParam:String = ""; //
					  strParam = args.toString(); // by alby:如果该方法是被callMethods方法调用，则args会变成只有一个元素，这里处理
					  args = strParam.split(/,/); //
					  ws.load(wsUrl, xmlns, methods[methodName], methodName, args);     

				 }else{
					dispatchEvent(new eventer("wsIOError", {code:"WebServices.call.noMethod"}));
				 }
			}
	   }
	  
	   private function callCompleteHandler(e:eventer):void{
			dispatchEvent(new eventer("wsComplete", {method:e.eventInfo.m, data:e.eventInfo.d}));
	   }
	  
	   private function callErrorHandler(e:eventer):void{
			dispatchEvent(new eventer("wsIOError", {code:"WebServices.call.Error"}));
	   }
	  
	   private function analyseService():void{
			//trace("方法：analyseService")
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		   
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = wsUrl + "?wsdl";
			urlRequest.method = URLRequestMethod.POST;
			urlLoader.addEventListener("complete", completeHandler);
			urlLoader.addEventListener("ioError", ioerrorHandler);
			urlLoader.load(urlRequest);
	   }
	  
	   private function completeHandler(e:Event):void{
			//trace("方法：completeHandler")
			var tmpXML:XML, wsdl:Namespace, s:Namespace, i:uint, j:uint, item:String, elementXML, itemLen;
		   
			tmpXML = XML(e.target.data);
			wsdl = tmpXML.namespace();
			for (i = 0; i < tmpXML.namespaceDeclarations().length; i++) {
				 s = tmpXML.namespaceDeclarations()[i];
				 var prefix:String = s.prefix;
				 if (prefix == "s") break;
			}
			elementXML = tmpXML.wsdl::["types"].s::["schema"];
			
			xmlns = elementXML.@targetNamespace;
			
			for (i =0; i<elementXML.s::element.length(); i+=2) {
				 item = elementXML.s::element[i].@name;
				 methods[item] = new Array();
				 itemLen = elementXML.s::element[i].s::complexType.s::sequence.s::element.length();
				 for (j =0; j<itemLen; j++)
				  methods[item].push(elementXML.s::element[i].s::complexType.s::sequence.s::element[j].@name);
			}
			//dispatchEvent(new eventer("wsAnalyseComplete", {methods:methods}));
			analyseCompleteFlag = true;
			callMethods();
	   }
	  
	   private function callMethods(){
			//trace("方法：callMethods")
			for(var m in mathodArray){
				 load(mathodArray[m].methodName, mathodArray[m].args);//
				 //trace(mathodArray[m].args is Array)
				 //trace("方法及数据4："mathodArray[m].methodName+":"+mathodArray[m].args)
			}
			mathodArray = null;
	   }
	  
	   private function ioerrorHandler(e:Event):void{
			dispatchEvent(new eventer("wsIOError", {code:"WebServices.analyse.IOError"}));
	   }
	}
}


/******************************************************************************
*
* 调用WebServices方法
*
******************************************************************************/
import flash.events.*;
import flash.net.*;

class loadWSMethod extends EventDispatcher{

	private var soap:Namespace = new Namespace("http://schemas.xmlsoap.org/soap/envelope/");
	private var soapXML:XML = <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			 xmlns:xsd="http://www.w3.org/2001/XMLSchema"
			 xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body/></soap:Envelope>;
	private var urlLoader:URLLoader;
	private var urlRequest:URLRequest;
	private var targetMethodName:String;

	public function loadWSMethod(){
	   urlLoader = new URLLoader();
	   urlRequest = new URLRequest();
	   urlLoader.addEventListener("complete", completeHandler);
	   urlLoader.addEventListener("ioError", ioerrorHandler);
	}

	public function load(wsUrl, xmlns, labels, methodName, args):void{
	   //trace("方法：loadWSMethod load")
	    targetMethodName = methodName;
		var methodXML:XML = XML("<" + methodName + " xmlns=\"" + xmlns + "\"/>");
		if(args[0]!=""){ //by alby:当无参数时,传递过来的为数组，只有一个元素，为空字符串
		for (var i=0; i<args.length; i++)
		    methodXML.appendChild( new XML("<" + labels[i] +">" + args[i] + "</" + labels[i] + ">") );
		}
	    trace(methodXML)
		var tempXML:XML = soapXML;
		tempXML.soap::["Body"].appendChild(methodXML);
		
		if (xmlns.lastIndexOf("/") == xmlns.length - 1) xmlns = xmlns.substr(0, xmlns.length - 1);
		
		urlRequest.url = wsUrl + "?op=" + methodName;            
		urlRequest.method = URLRequestMethod.POST;
		
		urlRequest.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml;charset=utf-8"));        
		urlRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", xmlns + "/" + methodName));
		
		urlRequest.data = tempXML;
		urlLoader.load(urlRequest);
	}

	private function completeHandler(e:Event):void{
	   dispatchEvent(new eventer("callComplete", {m:targetMethodName, d:e.target.data}));
	}

	private function ioerrorHandler(e:Event):void{
	   dispatchEvent(new eventer("callError", {e:e}));
	}
}
/******************************************************************************
*
* 事件扩展,附加传递参数eventInfo
*
******************************************************************************/
class eventer extends Event {
	private var info:Object;

	public function eventer(type:String, info:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
	   super(type, bubbles, cancelable);
	   this.info = info;
	}
	public function get eventInfo():Object {
	   return this.info;
	}
	public override function toString():String {
	   return formatToString("Event:", "type", "bubbles", "cancelable", "eventInfo");
	}
}
