package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import gs.easing.Circ;
	import gs.TweenLite;
	
	/**
	 * ...
	 * @author dengswing
	 */
	public class Main extends Sprite 
	{
		private var target:Sprite;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			target = new Sprite();
			target.graphics.beginFill(0xCCCCCC, .5);
			target.graphics.drawRect(0, 0, 10, 10);
			target.graphics.endFill();
			addChild(target);
			
			
			this.stage.addEventListener(MouseEvent.CLICK,stageHandler);
			
		}
		
		private function stageHandler(e:MouseEvent):void 
		{
			var tx:int = target.stage.mouseX;
			var ty:int = target.stage.mouseY;
			//TweenLite.to(target, 1, { x:tx } );
			TweenLite.to(target, 1, { x:tx, y:ty, ease:Circ.easeIn } );
		}
		
	}
	
}