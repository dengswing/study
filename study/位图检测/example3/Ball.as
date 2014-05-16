﻿package
{
	import flash.display.Sprite;
	public class Ball extends Sprite	
	{
		private var _color:uint;
		private var _radius:Number;
		private var _vx:Number = 0;
		private var _vy:Number = 0;
		
		public function Ball(radius:Number, color:uint = 0xffffff)
		{
			_radius = radius;
			_color = color;
			draw();
		}
		private function draw():void
		{
			// draw a circle with a dot in the center
			graphics.clear();
			graphics.lineStyle(0);
			graphics.beginFill(_color, 1);
			graphics.drawCircle(0, 0, _radius);
			graphics.endFill();
			graphics.drawCircle(0, 0, 1);
		}
		
		public function update():void
		{
			// add velocity to position
			x += _vx;
			y += _vy;
		}
		
		public function set color(value:uint):void
		{
			_color = value;
			
			draw();
		}
		
		public function get color():uint
		{
			return _color;
		}
		
		public function set radius(value:Number):void
		{
			_radius = value;
			
			draw();
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		
		public function set vx(value:Number):void
		{
			_vx = value;
		}
		
		public function get vx():Number
		{
			return _vx;
		}
		
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		
		public function get vy():Number
		{
			return _vy;
		}

	}
}