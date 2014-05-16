package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Shiu
	 */
	public class Triangle extends Sprite
	{
		private var _w:Number = 25;
		private var _h:Number = 25;
		
		public function Triangle() 
		{
			draw();
		}
		
		public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(0xFF9933);
			graphics.lineStyle(3);
			graphics.moveTo(0, _h * 0.5);
			graphics.lineTo(_w, 0);
			graphics.lineTo(0, _h * -0.5);
			graphics.lineTo(0, _h * 0.5);
			graphics.endFill();
		}
		
		public function get h():Number 
		{
			return _h;
		}
		
		public function set h(value:Number):void 
		{
			_h = value;
		}
		
		public function get w():Number 
		{
			return _w;
		}
		
		public function set w(value:Number):void 
		{
			_w = value;
		}
		
	}

}