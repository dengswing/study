package scripts.interfaceI
{
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public interface Iplayer extends IEventDispatcher 
	{
		function setLoc(pt:Point):void;
		function getLoc():Point;
		function movePlayer(st:String, mo:Boolean, pt:Point):void;
		function setMove(ms:Boolean):void;
		function getMove():Boolean;
		function setDirection(de:String):void;
		function getDirection():String;
		
	}
	
}