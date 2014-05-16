package {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	public class ServiceLoader extends URLLoader {
		private var _hostName:String;
		private var _serviceName:String;
		private var _parameters:Array;
		public function ServiceLoader(hostName:String,serviceName:String,parameters:Array) {
			_hostName=hostName;
			_serviceName=serviceName;
			_parameters=parameters;
			var serviceRequest:URLRequest = generateURLRequest();
			this.dataFormat = URLLoaderDataFormat.TEXT;
			this.load(serviceRequest);
		}
		private function generateURLRequest():URLRequest {
			var soap:Namespace = new Namespace("http://schemas.xmlsoap.org/soap/envelope/");
			var serviceRequest:URLRequest = new URLRequest(_hostName+_serviceName);
			serviceRequest.method = URLRequestMethod.POST;
			serviceRequest.requestHeaders.push(new URLRequestHeader("Content-Type", "text/xml;charset=utf-8"));
			serviceRequest.requestHeaders.push(new URLRequestHeader("SOAPAction", "http://tempuri.org/"+_serviceName));
			var rXML:XML =
			<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
			<soap:Body/>
			</soap:Envelope>;
			var conditionStr:String = "<"+_serviceName+" xmlns=\"http://tempuri.org/\">";

			for (var i:Number=0; i<_parameters.length; i++) {
				conditionStr+="<"+_parameters[i][0]+">"+_parameters[i][1]+"</"+_parameters[i][0]+">";
			}
			conditionStr +="</"+_serviceName + ">";
			
			trace(conditionStr);
			
			//
			var conditionXML:XML = new XML(conditionStr);
			rXML.soap::Body.appendChild(conditionXML);
			serviceRequest.data = rXML;
			return serviceRequest;
		}
	}
}