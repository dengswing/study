package scripts.view
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import scripts.interfaceI.*;
	
	/**
	 * ...
	 * @author 恋水泥人-2009-9-26
	 */
	public class  MouseInputView extends CompositeView
	{
		private var ptLoc:Point;
		private var target:Stage;
		
		public function MouseInputView(aModel:Iplayer, aController:IMouseInputHandler, target:Stage)
		{
			super(aModel, aController);
			this.ptLoc = aModel.getLoc();
			this.target = target;
			target.addEventListener(MouseEvent.CLICK, onClick);
			aModel.addEventListener(Event.DEACTIVATE,stopHandler)
			
		}
		
		private function stopHandler(e:Event):void 
		{
			target.removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		protected function onClick(evt:MouseEvent):void
		{
			
			(controller as IMouseInputHandler).mousePressHandler(evt);
			//trace("click");
			
			stopHandler(null);
			target.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		protected function onFrame(evt:Event):void
		{
			
			(controller as IMouseInputHandler).enterFrameHandler(evt);
		}
	}
	
}