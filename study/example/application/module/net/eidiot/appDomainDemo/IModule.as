package net.eidiot.appDomainDemo
{
	import flash.display.DisplayObjectContainer;
	
	/**
	 * 模型接口
	 * 
	 * @author	eidiot (http://eidiot.net)
	 * @date	070601
	 * @version	1.0.070601
	 */	
	public interface IModule
	{
		function show(p_parent : DisplayObjectContainer, ... rest) : void;
		function dispose() : void;
		function addEventListener(type : String, 
								listener : Function, 
								useCapture : Boolean = false, 
								priority : int = 0, 
								useWeakReference : Boolean = false) : void;
		function removeEventListener(type : String, 
								listener : Function, 
								useCapture : Boolean = false) : void 
	}
}