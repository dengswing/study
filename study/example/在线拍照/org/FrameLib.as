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
	public class FrameLib extends EventDispatcher  
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
		
		public function FrameLib() 
		{
			
		}
		public function loadFrameLibrary(_xmlpath:String)
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
			for (var i:Number = 0; i < lib_xml.children().length();i++ )
			{
				var styleID:String = lib_xml.children()[i].attribute("name").toString();
				libDict[styleID] = new Array();
				styleList.push(styleID);
				for (var j:Number = 0; j < lib_xml.children()[i].children().length(); j++ )
				{
					var _src:String = lib_xml.children()[i].children()[j].attribute("src");
					var type_name:String = _src.substr(_src.lastIndexOf(".")+1, 3);
					libDict[styleID].push( { 
											 id:lib_xml.children()[i].children()[j].attribute("name"),
											 path:_src,
											 isAni:(type_name=="gif" ? true : false)
											}
										);
				}
			}
			dispatchEvent(new Event("onLoadComplete"));
		}
		public function getStyleNames():Array
		{
			return styleList;
		}
		public function getStyle(id:String):Array
		{
			return libDict[id];
		}
	}
}