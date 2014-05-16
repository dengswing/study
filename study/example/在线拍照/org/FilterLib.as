package org 
{
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.xml.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	/**
	* ...
	* @author ezshine
	*/
	public class FilterLib extends EventDispatcher  
	{
		private var xmlConfigloader:URLLoader;
		private var lib_xml:XML;
		private var byteLoaded:Number;
		private var totalLoaded:Number;
		private var libDict:Dictionary;
		private var styleList:Array;
		private var nowStyleIndex:Number;
		private var nowElementIndex:Number;
		private var tempLdr:Loader;
		private var s_timer:Number;
		private var e_timer:Number;
		
		public function FilterLib() 
		{
			
		}
		public function loadFilterLibrary(_xmlpath:String)
		{
			byteLoaded = 0;
			totalLoaded = 0;
			nowStyleIndex=0;
			nowElementIndex=0;
			libDict = new Dictionary();
			styleList = new Array();
			xmlConfigloader = new URLLoader();
			xmlConfigloader.addEventListener(Event.COMPLETE, parseXML);
			
			var request:URLRequest = new URLRequest(_xmlpath);
			xmlConfigloader.load(request);
		}
		private function parseXML(e:Event):void
		{
			xmlConfigloader.removeEventListener(Event.COMPLETE, parseXML);
			lib_xml = new XML(e.target.data);
			for (var j:Number = 0; j < lib_xml.children().length(); j++ )
			{
				var _src:String = lib_xml.children()[j].attribute("src");
				var _id:String = lib_xml.children()[j].attribute("name");
				var _param:String = lib_xml.children()[j].attribute("param");
				var _value:String = lib_xml.children()[j].attribute("value");
				styleList.push(_id);
				libDict[_id] = { path:_src, param:_param, value:_value };
			}
			dispatchEvent(new Event("onLoadComplete"));
		}
		public function getFilterNames():Array
		{
			return styleList;
		}
		public function getFilter(id:String):Object
		{
			return libDict[id];
		}
	}
}