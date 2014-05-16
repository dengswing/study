package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author dengsw
	 */
	public class BaseSprite extends Sprite
	{
		
		public function BaseSprite() 
		{
			init();
		}
		
		private function init():void
		{
			addEventListener(Event.REMOVED_FROM_STAGE,removeFromStage);
		}
		
		public function removeFromStage(...rest):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStage);
		}
		
		public function moveTo(chipWidth:int, chipHeight:int):void 
		{
			
		}
		
		public function getNonnegative(num:int):int 
		{
			//trace("num", num);
			return Math.abs(num);
		}
	}

}