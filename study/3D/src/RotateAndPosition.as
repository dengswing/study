package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width = 800, height = 800, backgroundColor = 0x000000)]
	
	public class RotateAndPosition extends Sprite
	{
		private var _holder:Sprite;
		
		public function RotateAndPosition()
		{
			_holder = new Sprite();
			_holder.x = stage.stageWidth / 2;
			_holder.y = stage.stageHeight / 2;
			addChild(_holder);
			var shape:Shape = new Shape();
			shape.z = 200;
			shape.graphics.beginFill(0xffffff);
			shape.graphics.drawRect( -100, -100, 200, 200);
			
			_holder.addChild(shape);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			_holder.rotationY += 2;
		}
	}
}