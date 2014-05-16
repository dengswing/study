package scripts.interfaceI
{
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public interface IMouseInputHandler 
	{
		function mousePressHandler(evt:MouseEvent):void;
		function enterFrameHandler(evt:Event):void;
	}
	
}