package com.aspirin.game.isometric {
	import com.aspirin.game.isometric.items.Item;
	
	import flash.display.Sprite;
	import flash.geom.Point;		

	/**
	 * @author ashi
	 */
	public class Character extends Item {
		protected var _height:Number;
		protected var _color:uint;
		
		protected var _direction : int = 0;
		protected var _world : Sprite;
		
		public function Character(color:uint, height:Number, world : Sprite = null) {
			_height = height;
			_color = color;
			_world = world;
			
			super("Char_1", 1, 1);
			draw();
		}
		
		override public function draw():void
		{
			graphics.clear();
			var red:int = _color >> 16;
			var green:int = _color >> 8 & 0xff;
			var blue:int = _color & 0xff;
			
			var leftShadow:uint = (red * .5) << 16 |
								  (green * .5) << 8 |
								  (blue * .5);
			var rightShadow:uint = (red * .75) << 16 |
								   (green * .75) << 8 |
								   (blue * .75);
			
			var _size:int = 5;					   
			var h:Number = _height * Y_CORRECT;
			// draw top
			graphics.beginFill(_color);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, -_size * .5 - h);
			graphics.lineTo(_size, -h);
			graphics.lineTo(0, _size * .5  - h);
			graphics.lineTo(-_size, -h);
			graphics.endFill();
			
			// draw left
			graphics.beginFill(leftShadow);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(-_size, -h);
			graphics.lineTo(0, _size * .5 - h);
			graphics.lineTo(0, _size * .5);
			graphics.lineTo(-_size, 0);
			graphics.lineTo(-_size, -h);
			graphics.endFill();
			
			// draw right
			graphics.beginFill(rightShadow);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(_size, -h);
			graphics.lineTo(0, _size * .5 - h);
			graphics.lineTo(0, _size * .5);
			graphics.lineTo(_size, 0);
			graphics.lineTo(_size, -h);
			graphics.endFill();
			
			switch(_direction)
			{
				case 0:
				break;
				
				case 1:
				break;
				
				case 2:
				break;
				
				case 3:
				break;
				
				case 4:
				break;
				
				case 5:
				break;
				
				case 6:
				break;
				
				case 7:
				break;
			}
		}
		
		public function get direction() : int {
			return _direction;
		}
		
		public function set direction(direction : int) : void {
			_direction = direction;
		}
		
		/**
		 * Converts current 3d position to a screen position 
		 * and places this display object at that position.
		 */
		override protected function updateScreenPosition() : void {
			if(_world) {
				var screenPos : Point = IsoUtils.isoToScreen(_position);
				_world.x = -screenPos.x;
				_world.y = -screenPos.y;
			}else{
				super.updateScreenPosition();
			}
		}
		
		public function get world() : Sprite {
			return _world;
		}
		
		public function set world(world : Sprite) : void {
			_world = world;
		}
	}
}
