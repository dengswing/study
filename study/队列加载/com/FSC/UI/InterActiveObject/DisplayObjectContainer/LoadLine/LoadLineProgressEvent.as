package com.FSC.UI.InterActiveObject.DisplayObjectContainer.LoadLine
{
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	public class LoadLineProgressEvent extends ProgressEvent
	{
		public var currentTragetURL:URLRequest;
		public function LoadLineProgressEvent(type:String,URL:URLRequest, bubbles:Boolean=false, cancelable:Boolean=false, bytesLoaded:uint=0.0, bytesTotal:uint=0.0)
		{
			super(type, bubbles, cancelable, bytesLoaded, bytesTotal);
			this.currentTragetURL = URL;
		}
	}
}