package {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;		
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	
	[SWF(backgroundColor = 0xffffff, width = 500, height = 400)]
	
	/*	图 7-2 Flash 10 3D 旋转
		绕X轴旋转
		绕Y轴旋转
		绕Z轴旋转
	*/
	public class Test3D extends Sprite
	{
		private var _shape:Shape;
		
		public function Test3D()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			stage.addEventListener(Event.RESIZE, onResize)
			
			_shape = new Shape();
			
			_shape.graphics.beginFill(0xff0000,.5);
			_shape.graphics.drawRect(-100, -100, 200, 200);
			_shape.x = stage.stageWidth / 2;
			_shape.y = stage.stageHeight / 2;
			
			addChild(_shape);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		
		}
		
		private function onEnterFrame(event:Event):void
		{
			_shape.rotationX += 2;		
		}
		
		private function onResize(event:Event):void
		{
			root.transform.perspectiveProjection.projectionCenter = new Point(stage.stageWidth / 2, stage.stageHeight / 2);
			if(_shape != null)
			{
			_shape.x = stage.stageWidth / 2;
			_shape.y = stage.stageHeight / 2;
			}
		}
	}
}