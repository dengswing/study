package  
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Shiu
	 */
	public class Ball extends Sprite
	{
		private var _rad:Number = 10;
		private var _col:Number = 0xCCCCCC;
		public function Ball() 
		{
			draw();
		}
		
		public function draw():void 
		{
			graphics.clear();
			graphics.beginFill(_col);
			graphics.drawCircle(0, 0, _rad);
			graphics.endFill();
		}
		
		public function get rad():Number 
		{
			return _rad;
		}
		
		public function set rad(value:Number):void 
		{
			_rad = value;
		}
		
		public function get col():Number 
		{
			return _col;
		}
		
		public function set col(value:Number):void 
		{
			_col = value;
		}
		
	}

}