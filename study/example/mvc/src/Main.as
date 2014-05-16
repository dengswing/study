package 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import mvc.EkoFacade;
	
	/**
	 * ...
	 * @author eko
	 */
	public class Main extends Sprite 
	{
		public var txtEko:TextField;
		public var btnEko:SimpleButton;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			EkoFacade.getInstance().startup(this);
		}
		
	}
	
}